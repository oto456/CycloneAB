//
//  LoginAndRegisterBLDelegate.h
//  CycloneAB
//
//  Created by johnny on 14/10/27.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginAndRegisterBLDelegate <NSObject>

-(void)loginSuccess:(NSDictionary *)userData;
-(void)loginFail:(NSError *)error;

-(void)toRegisterSuccess:(NSDictionary *)user;
-(void)toRegisterFail:(NSError *)error;

@end
