//
//  LoginAndRegisterDAO.m
//  CycloneAB
//
//  Created by edward_ng on 14-10-23.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "LoginAndRegisterDAO.h"
#import "MyDetailDao.h"
#import <CommonCrypto/CommonDigest.h>

@interface LoginAndRegisterDAO()
@property (strong,nonatomic) NSString *accessToken;

@end


@implementation LoginAndRegisterDAO

-(void)setaccessToken:(NSString *)aAccessToken
{//设置访问令牌且保存
    _accessToken =aAccessToken;
    
    [[NSUserDefaults standardUserDefaults] setObject:self.accessToken forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *) accessToken
{//读取访问令牌
    if (_accessToken) {
        _accessToken=[[NSUserDefaults standardUserDefaults] stringForKey:@"accessToken"];
    }
    return _accessToken;
}


-(NSString *)ChangetoMD5:(NSString *)password
{
    const char *cStr = [password UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    NSString *passwordMD5= [NSString stringWithFormat:
                            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                            result[0], result[1], result[2], result[3],
                            result[4], result[5], result[6], result[7],
                            result[8], result[9], result[10], result[11],
                            result[12], result[13], result[14], result[15]
                            ];
    return passwordMD5;
}


-(void)login:(NSDictionary *)userData
{
    NSLog(@"hello");
    NSString *username = [userData objectForKey:@"username"];
    NSString *password = [userData objectForKey:@"password"];
    NSString *passwordMD5=[self ChangetoMD5:password];
    NSLog(username);
    NSLog(passwordMD5);
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"Login" forKey:@"function"];
    [param setValue:username forKey:@"username"];
    [param setValue:passwordMD5 forKey:@"password"];
    [param setValue:[APService registrationID] forKey:@"registrationID"];
    
    NSString *path = [@"/login.php" URLEncodedString];
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];

    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"got it");
        NSData *data= [completedOperation responseData];
         NSDictionary *resDict= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"come");
        for ( id key in resDict) {
            NSLog(@"key :%@, value: %@",key,[resDict objectForKey:key]);
        }
        NSMutableArray *params= [resDict objectForKey:@"params"];
        for(NSDictionary *dic in params)
        {
            NSLog(@"%@",[dic objectForKey:@"circle_id"]);
        }

        //登录成功后把数据通过mydetailDao保存在自定义的MyDetail.plist里面
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue] >=0) {
            [MyDetailDao setMyusername:username];
            [MyDetailDao setMD5PassWord:password];
            NSString *user_id=[resDict objectForKey:@"user_id"];
            [MyDetailDao setMyuser_id:user_id];
        [self.delegate loginSuccess:userData];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate loginFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *err) {
        NSError *error = [completedOperation error];
        [self.delegate loginFail:error];
    }];
    [engine enqueueOperation:op];
}


-(void)toRegister:(NSDictionary *)userDataForRegister
{
    NSLog(@"DAO recive");
    NSString *username = [userDataForRegister objectForKey:@"username"];
    NSString *password = [userDataForRegister objectForKey:@"password"];
    NSString *name=[userDataForRegister objectForKey:@"name"];
    NSString *passwordMD5=[self ChangetoMD5:password];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"register" forKey:@"function"];
    [param setValue:username forKey:@"username"];
    [param setValue:passwordMD5 forKey:@"password"];
    [param setValue:name forKey:@"name"];
    NSLog(username);
    NSLog(password);
    NSLog(name);
    NSString *path = [@"/register.php" URLEncodedString];
    MKNetworkEngine *engin =[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op= [engin operationWithPath:path params:param httpMethod:@"POST"];

    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data= [completedOperation responseData];
        NSDictionary *resDict= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"got it");
        
        //登录成功后把数据通过mydetailDao保存在自定义的MyDetail.plist里面
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        NSLog(@"resdic:%@",resDict);
        if ([resultCodeNumber integerValue] >=0) {
            [self.delegate toRegisterSuccess:userDataForRegister];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate toRegisterFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *err) {
        NSError *error = [completedOperation error];
        [self.delegate toRegisterFail:error];
    }];
    
    [engin enqueueOperation:op];
}

-(void)logout
{
    NSLog(@"logout");
    NSString *user_id = [MyDetailDao getMyuser_id];
    NSString *password = [MyDetailDao getMyMD5PassWord];
    NSString *registrationID =[APService registrationID];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"Logout" forKey:@"function"];
    [param setValue:user_id forKey:@"user_id"];
    [param setValue:password forKey:@"password"];
//    [param setValue:[APService registrationID] forKey:@"registrationID"];
    
    NSString *path = [@"/logout.php" URLEncodedString];
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data= [completedOperation responseData];
        NSDictionary *resDict= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"resDict : %@",resDict);
        //登录成功后把数据通过mydetailDao保存在自定义的MyDetail.plist里面
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue] >=0) {
            [self.delegate logoutSuccess];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate logoutFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *err) {
        NSError *error = [completedOperation error];
        [self.delegate loginFail:error];
    }];
    [engine enqueueOperation:op];
}



@end
