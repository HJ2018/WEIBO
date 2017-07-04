//
//  HJTabBar.h
//  HJWEIBO
//
//  Created by 黄杰 on 15/12/28.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJTabBar;
@protocol HJTabBarDelegate <NSObject>
@optional

-(void)TabBarDidClickplusBtn:(HJTabBar *)taBbar;
@end

@interface HJTabBar : UITabBar

@property (nonatomic,weak)id <HJTabBarDelegate> delegatel;

@end
