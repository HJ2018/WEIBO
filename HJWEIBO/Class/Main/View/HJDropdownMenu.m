//
//  HJDropdownMenu.m
//  HJWEIBO
//
//  Created by 黄杰 on 15/12/25.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import "HJDropdownMenu.h"


@interface HJDropdownMenu()
/**
 *  将来用来显示具体内容的容器
 */
@property (nonatomic, weak) UIImageView *containerView;
@end
@implementation HJDropdownMenu


- (UIImageView *)containerView
{
    if (!_containerView) {
        // 添加一个灰色图片控件
        UIImageView *containerView = [[UIImageView alloc] init];
//        containerView.image = [UIImage imageNamed:@"popover_background"];
//        containerView.width = 200;
//        containerView.height = 100;
        containerView.userInteractionEnabled = YES; // 开启交互
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+ (instancetype)menu
{
    return [[self alloc] init];
}

-(void)setContent:(UIView *)content
{
    _content = content;
    content.x = 10;
    content.y = 15;
    self.containerView.height = CGRectGetMaxY(content.frame)+10;
    self.containerView.width = CGRectGetMaxX(content.frame)+10;
    [self.containerView addSubview:content];
}
- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
}
-(void)showFrom:(UIView *)from
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
//    self.frame = window.bounds;
    [window addSubview:self];
    self.size = window.bounds.size;
//    CGRect newFrame = [from convertRect:from.bounds toView:window];
//    self.containerView.x = (self.width-self.containerView.width)*0.5;
        CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
//    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidshow:)])
    {
        [self.delegate dropdownMenuDidshow:self];
    }
}

-(void)dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidmiss:)]){
        [self.delegate dropdownMenuDidmiss:self];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

@end
