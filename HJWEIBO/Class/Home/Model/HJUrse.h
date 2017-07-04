//
//  HJUrse.h
//  HJWEIBO
//
//  Created by 黄杰 on 16/1/11.
//  Copyright © 2016年 黄杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJUrse : NSObject


@property (nonatomic,copy)NSString *idstr;
//idstr	string	字符串型的用户UID
@property (nonatomic,copy)NSString *name;
//name	string	友好显示名称
@property (nonatomic,copy)NSString *profile_image_url;
//profile_image_url	string	用户头像地址（中图），50×50像素
//+(instancetype)UserWithDict:(NSDictionary *)dict;

@end
