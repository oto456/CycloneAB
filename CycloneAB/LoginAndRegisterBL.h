//
//  LoginAndRegisterBL.h
//  CycloneAB
//
//  Created by johnny on 14/10/27.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginAndRegisterDAO.h"
#import "LoginAndRegisterBLDelegate.h"

@interface LoginAndRegisterBL : NSObject<LoginAndPersonDAODelegate>

@property(weak,nonatomic)id<LoginAndRegisterBLDelegate> delegate;
@property(strong,nonatomic) LoginAndRegisterDAO *loginandregisterDAO;


-(void)login:(NSDictionary *)userData;
-(void)toregister:(NSDictionary *)userDataForRegister;

@end
