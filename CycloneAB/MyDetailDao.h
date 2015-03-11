//
//  MyDetailDao.h
//  CycloneAB
//
//  Created by johnny on 14/10/31.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDetailDao : NSObject

+(void)initPlist;

+(NSMutableArray *)getAllMyDetail;

+(void)setObject:(id)object forKey:(NSString *)key;

+(void)setMD5PassWord:(NSString *)password;

+(NSString *)getMyMD5PassWord;

+(void)setMyuser_id:(NSString *)user_id;

+(NSString *)getMyuser_id;

+(void)setMyusername:(NSString *)username;
//账户名
+(NSString *)getMyusername;

+(void)setMyname:(NSString *)name;
//真实姓名
+(NSString *)getMyname;
//社交账号
+(NSMutableDictionary *)getMySocialAccount;

+(void)setMySocialAccount:(NSString *)account forkey:(NSString *)key;

+(NSString *)getMyNote;

+(void)setMyNote:(NSString *)value;

//删除某社交信息
+(void)removeSocialForKey:(NSString *)key;
//删除基本信息中的
+(void)removeBasicInfoForKey:(NSString *)key;
//退出登录时的清楚mydetail
+(void)deleteMyDetail;

@end
