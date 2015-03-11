//
//  MyDetailDao.m
//  CycloneAB
//
//  Created by johnny on 14/10/31.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "MyDetailDao.h"
#import <CommonCrypto/CommonDigest.h> //use for MD5 密码加密 只保存md5加密后的密码


@implementation MyDetailDao

+(NSString *)getFilePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    NSString *path=[NSString stringWithFormat:@"%@/MyDetail.plist",documentsDirectory];
    //Resource目录下的mydetail.plist文件
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"mydetailinfo" ofType:@"plist"];
    return path;
}

+ (void)initPlist{
    NSLog(@"initPlist");
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL exist=[fileManager fileExistsAtPath:[self getFilePath]];
    NSLog([self getFilePath]);
    if(!exist){
        //获取工程目录下的静态data.plist
        NSError *error;
        NSString *appPath = [[NSBundle mainBundle] pathForResource:@"mydetailinfo" ofType:@"plist"];
        NSLog(appPath);
        BOOL success=[fileManager copyItemAtPath:appPath toPath:[self getFilePath] error:&error];
        NSLog(@"cp plist");
    }
}


+ (NSMutableDictionary *)getMutableDictionary{
    return [[NSMutableDictionary alloc]initWithContentsOfFile:[self getFilePath]];
}

+(void)setMD5PassWord:(NSString *)password
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
    NSMutableDictionary *dict = [self getMutableDictionary];
    
    [dict setObject:passwordMD5 forKey:@"password"];
    [dict writeToFile:[self getFilePath] atomically:YES];   //把md5写入到文件中
}

+(NSMutableArray *)getAllMyDetail
{
    NSMutableArray *listData;
    return listData;
}

+(NSString *)getMyMD5PassWord
{
    NSMutableDictionary *dict = [self getMutableDictionary];
    NSString *passwordMD5=[dict objectForKey:@"password"];
    return passwordMD5;
}

+(void)setMyusername:(NSString *)username
{
    NSMutableDictionary *dict=[self getMutableDictionary];
    [dict setObject:username forKey:@"username"];
    [dict writeToFile:[self getFilePath] atomically:YES];
    NSMutableDictionary *data1 = [self getMutableDictionary];
    NSLog(@"%@", data1);

}

+(NSString *)getMyusername
{
    NSMutableDictionary *dict = [self getMutableDictionary];
    NSString *username=[dict objectForKey:@"username"];
    return username;
}

+(void)setMyuser_id:(NSString *)user_id
{
    NSMutableDictionary *dict=[self getMutableDictionary];
    [dict setObject:user_id forKey:@"user_id"];
    [dict writeToFile:[self getFilePath] atomically:YES];
    
    NSMutableDictionary *data1 = [self getMutableDictionary];
    NSLog(@"%@", data1);

}


+(NSString *)getMyuser_id
{
    NSMutableDictionary *dict = [self getMutableDictionary];
    NSString *user_id=[dict objectForKey:@"user_id"];
    return user_id;
}


+(NSMutableDictionary*)getMySocialAccount
{
    NSMutableDictionary *dict = [self getMutableDictionary];
    NSMutableDictionary *socialaccount=[dict objectForKey:@"socialaccount"];
    return socialaccount;
}



+(void)setMySocialAccount:(NSString *)account forkey:(NSString *)key
{
    NSMutableDictionary *dict =[self getMutableDictionary];
    [[dict objectForKey:@"socialaccount"] setObject:account forKey:key];
    [dict writeToFile:[self getFilePath] atomically:YES];
}

+(void)removeSocialForKey:(NSString *)key
{
    NSMutableDictionary *dict =[self getMutableDictionary];
    [[dict objectForKey:@"socialaccount"] removeObjectForKey:key];
    [dict writeToFile:[self getFilePath] atomically:YES];
}

+(void)removeBasicInfoForKey:(NSString *)key
{
    NSMutableDictionary *dict=[self getMutableDictionary];
    [dict removeObjectForKey:key];
    [dict writeToFile:[self getFilePath] atomically:YES];
}

+(void)setMyname:(NSString *)name
{
    NSMutableDictionary *dict=[self getMutableDictionary];
    [dict setObject:name forKey:@"name"];
    [dict writeToFile:[self getFilePath] atomically:YES];
    NSMutableDictionary *data1 = [self getMutableDictionary];
    NSLog(@"%@", data1);

}

+(NSString *)getMyname
{
    NSMutableDictionary *dict = [self getMutableDictionary];
    NSString *name=[dict objectForKey:@"name"];
    return name;
}

+(NSString *)getMyNote
{
    NSMutableDictionary *dict = [self getMutableDictionary];
    NSString *name=[dict objectForKey:@"note"];
    return name;
}

+(void)setMyNote:(NSString *)value
{
    NSMutableDictionary *dict=[self getMutableDictionary];
    [dict setObject:value forKey:@"note"];
    [dict writeToFile:[self getFilePath] atomically:YES];
}

+(void)deleteMyDetail
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL exist=[fileManager fileExistsAtPath:[self getFilePath]];
    NSLog([self getFilePath]);
    if(exist){
        //获取工程目录下的静态data.plist
        NSError *error;
        [fileManager removeItemAtPath:[self getFilePath] error:nil];
    }

}

@end
