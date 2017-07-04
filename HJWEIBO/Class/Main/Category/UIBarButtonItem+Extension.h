//
//  UIBarButtonItem+Extension.h
//  HJWEIBO
//
//  Created by 黄杰 on 15/12/25.
//  Copyright © 2015年 黄杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
