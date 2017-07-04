//
//  HJTabBarViewController.m
//  HJWEIBO
//
//  Created by 黄杰 on 15/12/8.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import "HJTabBarViewController.h"
#import "Header.h"
#import "HomeViewController.h"
#import "MeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "HJNaviViewController.h"
#import "HJTabBar.h"
#import "TestViewController.h"

@interface HJTabBarViewController ()<HJTabBarDelegate>

@end

@implementation HJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithWhite:0.646 alpha:1.000]
                                                         } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithRed:1.000 green:0.500 blue:0.000 alpha:1.000]
                                                         } forState:UIControlStateSelected];

        HomeViewController *home = [[HomeViewController alloc]init];

        [self addChildVc:home title:@"首页" image:@"tabbar_home" seldectImage:@"tabbar_home_selected"];
        
        MessageViewController *message = [[MessageViewController alloc]init];
        [self addChildVc:message title:@"消息" image:@"tabbar_message_center" seldectImage:@"tabbar_message_center_selected"];
    
        DiscoverViewController *discover = [[DiscoverViewController alloc]init];
        [self addChildVc:discover title:@"发现" image:@"tabbar_discover" seldectImage:@"tabbar_discover_selected"];
        
        MeViewController *me = [[MeViewController alloc]init];
        [self addChildVc:me title:@"我" image:@"tabbar_profile" seldectImage:@"tabbar_profile_selected"];
//        self.tabBar = [[HJTabBar alloc]init];
    HJTabBar *tabBar = [[HJTabBar alloc]init];
    
//    tabBar.delegatel = self;
    
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}

-(void)TabBarDidClickplusBtn:(HJTabBar *)taBbar
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - taBbar封装
-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image seldectImage:(NSString *)selectImage
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    HJNaviViewController *nav = [[HJNaviViewController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
}

@end
