//
//  HJStatus.h
//  HJWEIBO
//
//  Created by 黄杰 on 16/1/11.
//  Copyright © 2016年 黄杰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HJUrse;
@interface HJStatus : NSObject


@property (nonatomic,copy)NSString *idstr;
//idstr	string	字符串型的微博ID
@property (nonatomic,copy)NSString *text;
//text	string	微博信息内容
@property (nonatomic,strong)HJUrse *user;
//user	object	微博作者的用户信息字段 详细
//+(instancetype)StatusWithDict:(NSDictionary *)dict;

@end
