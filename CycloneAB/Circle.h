//
//  Circle.h
//  CycloneAB
//
//  Created by edward_ng on 14-10-22.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Circle : NSManagedObject

@property (nonatomic, retain) NSString * circle_id;
@property (nonatomic, retain) NSString * circle_name;
@property (nonatomic, retain) NSString * circle_passw;
@property (nonatomic, retain) NSDate * circle_date;
@property (nonatomic, retain) NSString * circle_logo;
@property (nonatomic, retain) User *havePerson;

@end
