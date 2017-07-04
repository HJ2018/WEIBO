//
//  HJDropdownMenu.h
//  HJWEIBO
//
//  Created by 黄杰 on 15/12/25.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HJDropdownMenu;
@protocol HJDropdownMenuDelegate <NSObject>

@optional
-(void)dropdownMenuDidmiss:(HJDropdownMenu *)menu;
-(void)dropdownMenuDidshow:(HJDropdownMenu *)menu;
@end


@interface HJDropdownMenu : UIView

@property(nonatomic,weak) id <HJDropdownMenuDelegate> delegate;

+ (instancetype)menu;


- (void)showFrom:(UIView *)from;

- (void)dismiss;

@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;


@end
