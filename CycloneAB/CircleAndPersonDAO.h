//
//  CircleAndPersonDAO.h
//  CycloneAB
//
//  Created by edward_ng on 14-10-21.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircleAndPersonDAODelegate.h"
#import "NSNumber+Message.h"
#import "Circle.h"
#import "User.h"
#import "NSString+URLEncoding.h"
#import "CircleJM.h"
#import "PersonJM.h"
#import "MyDetailDao.h"


#define HOST_PATH @""
#define HOOST_NAME @"2.contaclone.sinaapp.com"

@interface CircleAndPersonDAO : NSObject

@property (nonatomic,strong) NSMutableArray *listData;

@property(weak,nonatomic) id<CircleAndPersonDAODelegate> delegate;

//查找我的所有圈子
-(void)findAllMyCircle;
//退出圈子
-(void)quitCircle:(CircleJM *)circle;
//查找圈子内的所有联系人
-(void)findPersonInCircle:(CircleJM *)circle;
//查找联系人详细资料
-(void)findPersonDetail:(PersonJM *)user FromCircle:(CircleJM *)Circle;
//创建圈子
-(void)createCircle:(CircleJM *)circle accountarray:(NSString *)array;
//加入圈子
-(void)joinCircle:(CircleJM *)circle accountarray:(NSString *)array;
//修改圈子信息  (名称，密码)
-(void)modifycircle:(CircleJM *)circle Value:(NSString *)value Key:(NSString *)key;
//删除个人资料
-(void)deleteMyDetailInfoForKey:(NSString *)key;
//更改个人资料
-(void)modifyMyDetailInfoValue:(NSString *)value Forkey:(NSString *)key;
//增加字段
-(void)addMyInfoValue:(NSString *)value Key:(NSString *)key;
//得到我的个人资
-(void)getMyDetail;
//forwhat 1代表上传用户头像。  2代表上传circle头像
-(void)uploadPic:(NSData *)pic forWhat:(int) forwhat;






@end
