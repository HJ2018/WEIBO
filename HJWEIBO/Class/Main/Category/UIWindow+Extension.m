//
//  UIWindow+Extension.m
//  HJWEIBO
//
//  Created by 黄杰 on 16/1/7.
//  Copyright © 2016年 黄杰. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HJTabBarViewController.h"
#import "NewfeatureUIScrollView.h"
@implementation UIWindow (Extension)

+(void)swithRooViewController
{
    
    NSString *key = @"CFBundleVersion";
    
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    NSDictionary *currentVersion =  [[NSBundle mainBundle]infoDictionary][key];
    NSLog(@"---------%@",currentVersion);
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqual:lastVersion]) {
        window.rootViewController= [[HJTabBarViewController alloc]init];
    }else
    {
        window.rootViewController = [[NewfeatureUIScrollView alloc]init];
    }
    [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


@end
