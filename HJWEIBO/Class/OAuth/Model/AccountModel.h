//
//  AccountModel.h
//  HJWEIBO
//
//  Created by 黄杰 on 16/1/6.
//  Copyright © 2016年 黄杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject<NSCoding>


@property (nonatomic,copy)NSString *access_token;
@property (nonatomic,copy)NSString *expires_in;
@property (nonatomic,copy)NSString *uid;
@property (nonatomic,strong)NSDate *created_time;
@property (nonatomic,strong)NSString *name;
+(instancetype)accountWithdict:(NSDictionary *)dict;

@end
