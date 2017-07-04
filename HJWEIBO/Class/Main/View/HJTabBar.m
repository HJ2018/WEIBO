
//  HJTabBar.m
//  HJWEIBO
//
//  Created by 黄杰 on 15/12/28.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import "HJTabBar.h"

@interface HJTabBar()

@property(nonatomic ,weak)UIButton *plusBtn;

@end

@implementation HJTabBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [[UIButton alloc]init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(clicke) forControlEvents:UIControlEventTouchUpInside];
        self.plusBtn = plusBtn;
        [self addSubview:plusBtn];
    }
    return self;
}


-(void)clicke
{
    NSLog(@"点击了.....");
    
    if ([self.delegatel respondsToSelector:@selector(TabBarDidClickplusBtn:)]) {
        [self.delegatel TabBarDidClickplusBtn:self];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.plusBtn.centerX = self.width *0.5;
    self.plusBtn.centerY = self.height*0.5;
    CGFloat TaBbarW = self.width/5;
    /**
     *  创建索引
     */
    CGFloat TabBarIndex =0;
for (UIView *chilv in self.subviews) {
    Class class = NSClassFromString(@"UITabBarButton");
    if ([chilv isKindOfClass:class]) {
        chilv.width = TaBbarW;
    /**
    *  设置X
    */

    chilv.x = TabBarIndex*TaBbarW;
    TabBarIndex++;
    /**
    *  增加索引
    */
    if (TabBarIndex==2) {
        TabBarIndex++;
        }
      }
   }
}
//    NSInteger count = self.subviews.count;
//    for (int i=0; i<count; i++) {
//        Class class = NSClassFromString(@"UITabBarButton");
//        UIView *chilv = self.subviews[i];
//        if ([chilv isKindOfClass:class]) {
//            chilv.width = TaBbarW;
//            chilv.x = TabBarIndex*TaBbarW;
//            TabBarIndex++;
//            if (TabBarIndex==2) {
//                TabBarIndex++;
//            }
//        }
//    }
@end
