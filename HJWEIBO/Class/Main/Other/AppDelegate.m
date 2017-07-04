//
//  AppDelegate.m
//  HJWEIBO
//
//  Created by 黄杰 on 15/12/8.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "OAuthViewController.h"
#import "AccountModel.h"
#import "AccountTool.h"
#import "SDWebImageManager.h"
#import "HJTabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
//    [WXApi registerApp:@"wxd930ea5d5a25Bf4f"];
    self.window = [[UIWindow alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[HJTabBarViewController alloc] init];
//    AccountModel *account = [AccountTool account];
//
//    if (account) {
//        [UIWindow swithRooViewController];
//
//    }else
//    {
//        self.window.rootViewController = [[OAuthViewController alloc]init];
//    }

    
    return YES;
}
//-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [WXApi handleOpenURL:url delegate:self];
//}
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    return [WXApi handleOpenURL:url delegate:self];
//}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
     SDWebImageManager *mag =[SDWebImageManager sharedManager];
//    取消下载
    [mag cancelAll];
//   清除内存中的所有图片
    [mag.imageCache clearMemory];
}

@end
