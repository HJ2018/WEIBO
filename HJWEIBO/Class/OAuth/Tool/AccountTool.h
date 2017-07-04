//
//  AccountTool.h
//  HJWEIBO
//
//  Created by 黄杰 on 16/1/7.
//  Copyright © 2016年 黄杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"
//@class AccountModel;
@interface AccountTool : NSObject


+(void)saveAccount:(AccountModel *)account;


+(AccountModel *)account;

@end
