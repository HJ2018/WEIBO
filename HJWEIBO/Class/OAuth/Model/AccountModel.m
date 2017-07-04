//
//  AccountModel.m
//  HJWEIBO
//
//  Created by 黄杰 on 16/1/6.
//  Copyright © 2016年 黄杰. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel


//把字典转成模型
+(instancetype)accountWithdict:(NSDictionary *)dict
{
    AccountModel *accound = [[AccountModel alloc]init];
    accound.access_token = dict[@"access_token"];
    accound.uid = dict[@"uid"];
    accound.expires_in = dict[@"expires_in"];
//    access_token产生的时间
    NSDate *createdTime = [NSDate date];
    accound.created_time = createdTime;
    
    return accound;
}

//归档
-(void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [enCoder encodeObject:self.uid forKey:@"uid"];
    [enCoder encodeObject:self.created_time forKey:@"created_time"];
    [enCoder encodeObject:self.name forKey:@"name"];
}
//解档
-(id)initWithCoder:(NSCoder *)Decoder
{
    if (self = [super init]) {
        self.access_token = [Decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [Decoder decodeObjectForKey:@"expires_in"];
        self.uid = [Decoder decodeObjectForKey:@"uid"];
        self.created_time = [Decoder decodeObjectForKey:@"created_time"];
        self.name = [Decoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
