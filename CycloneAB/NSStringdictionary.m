//
//  NSStringdictionary.m
//  CycloneAB
//
//  Created by johnny on 14/11/2.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "NSStringdictionary.h"

@implementation NSStringdictionary

+(NSArray *)getBasicInfoKey
{
    NSArray *basicInfo= [[NSArray alloc] initWithObjects:@"name",@"birthday",@"mobile",@"note",nil];
    return basicInfo;
}

+(NSString *)getcircleNamekey
{
    return @"circle_name";
}

+(NSString *)getcirclepasswordKey
{
   return @"circle_passw";
}



@end
