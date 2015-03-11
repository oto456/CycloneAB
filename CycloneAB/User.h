//
//  User.h
//  CycloneAB
//
//  Created by edward_ng on 14-10-22.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSNumber * mobile;
@property (nonatomic, retain) NSString * qq;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * weibo;
@property (nonatomic, retain) NSString * wechat;
@property (nonatomic, retain) NSString * renren;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSManagedObject *inCircle;

@end
