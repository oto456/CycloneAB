//
//  personJM.h
//  CycloneAB
//
//  Created by johnny on 14/10/29.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "JSONModel.h"

@interface PersonJM : JSONModel
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSString * qq;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * weibo;
@property (nonatomic, retain) NSString * wechat;
@property (nonatomic, retain) NSString * renren;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSData * avatar;//头像
@property (nonatomic, retain) NSString * circle_name;

-(NSInteger)socialCount;

-(NSString *)birthdayforString;

//里面存储的是字典 储存账号id和头像
-(NSMutableArray *)getArrayForSocialAccount;

@end
