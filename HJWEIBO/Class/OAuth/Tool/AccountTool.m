//
//  AccountTool.m
//  HJWEIBO
//
//  Created by 黄杰 on 16/1/7.
//  Copyright © 2016年 黄杰. All rights reserved.
//

#import "AccountTool.h"
#import "AccountModel.h"
@implementation AccountTool

+(NSString *)path
{
      return  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.archive"];
}

+(void)saveAccount:(AccountModel *)account
{

    [NSKeyedArchiver archiveRootObject:account toFile:[self  path]];
}
+(AccountModel *)account
{
    
    AccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
//    现在时间
    long long expirec_in =  [account.expires_in longLongValue];
    //    过期时间
    NSDate *expirecTime = [account.created_time dateByAddingTimeInterval:expirec_in];
    
    NSDate *now = [NSDate date];
/*  NSComparisonResult 是枚举
 
    NSOrderedAscending = -1L,
    NSOrderedSame,
    NSOrderedDescending
 */
    NSComparisonResult result=[expirecTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    
    return account;
}


@end
