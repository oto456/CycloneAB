//
//  LoginAndRegisterBL.m
//  CycloneAB
//
//  Created by johnny on 14/10/27.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "LoginAndRegisterBL.h"

@implementation LoginAndRegisterBL

-(instancetype)init
{
    if ((self=[super self])) {
        _loginandregisterDAO= [[LoginAndRegisterDAO alloc] init];
    }
    return  self;
}

-(void)login:(NSMutableDictionary *)userData
{
    _loginandregisterDAO.delegate=self;
    [_loginandregisterDAO login:userData];
}

-(void)loginSuccess:(NSMutableDictionary *)user
{
    NSLog(@"login success do something in logiclayer");
    [_delegate loginSuccess:user];
}

-(void)loginFail:(NSError *)error
{
    NSLog(@"login fail");
    [_delegate loginFail:error];
}

-(void)toregister:(NSMutableDictionary *)userDataForRegister
{
    NSLog(@"send to DAO");
    _loginandregisterDAO.delegate=self;
    [_loginandregisterDAO toRegister:userDataForRegister];
    NSString *name=[userDataForRegister objectForKey:@"name"];
}



-(void)toRegisterFail:(NSError *)error
{
    NSLog(@"register fail");
    [_delegate toRegisterFail:error];
}

-(void)toRegisterSuccess:(NSMutableDictionary *)user
{
    NSLog(@"register success");
    [_delegate toRegisterSuccess:user];
}

@end
