//
//  CircleJM.h
//  CycloneAB
//
//  Created by johnny on 14/10/29.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "JSONModel.h"

@interface CircleJM : JSONModel
@property (nonatomic, retain) NSString * circle_id;
@property (nonatomic, retain) NSString * circle_name;
@property (nonatomic, retain) NSString * circle_passw;
@property (nonatomic, retain) NSDate * circle_date;
@property (nonatomic, retain) NSData * circle_logo;
@property (nonatomic) int red_dot;

@end
