//
//  Loadmore.m
//  HJWEIBO
//
//  Created by 黄杰 on 16/1/15.
//  Copyright © 2016年 黄杰. All rights reserved.
//

#import "Loadmore.h"

@implementation Loadmore

+(instancetype)footer
{
    return [[[NSBundle mainBundle]loadNibNamed:@"Loadmore" owner:nil options:nil]lastObject];
}

@end
