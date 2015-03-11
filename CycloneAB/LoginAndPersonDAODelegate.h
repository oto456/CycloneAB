//
//  LoginAndPersonDAODelegate.h
//  CycloneAB
//
//  Created by edward_ng on 14-10-23.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginAndPersonDAODelegate <NSObject>

-(void)loginSuccess:(NSMutableDictionary *)user;
-(void)loginFail:(NSError *)error;

-(void)toRegisterSuccess:(NSMutableDictionary *)user;
-(void)toRegisterFail:(NSError *)error;

-(void)logoutSuccess;
-(void)logoutFail:(NSError *)error;
@end
