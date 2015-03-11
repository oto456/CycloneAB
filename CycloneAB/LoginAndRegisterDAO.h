//
//  LoginAndRegisterDAO.h
//  CycloneAB
//
//  Created by edward_ng on 14-10-23.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNumber+Message.h"
#import "NSString+URLEncoding.h"
#import "LoginAndPersonDAODelegate.h"


#define HOST_PATH @""
#define HOOST_NAME @"2.contaclone.sinaapp.com"


@interface LoginAndRegisterDAO : NSObject

@property (nonatomic,strong) NSMutableArray *listData;
@property (nonatomic,weak) id<LoginAndPersonDAODelegate> delegate;
//登陆
-(void)login:(NSMutableDictionary *)userData;
//注册
-(void)toRegister:(NSMutableDictionary *) userDataForRegister;
//登出
-(void)logout;
@end
