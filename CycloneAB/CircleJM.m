//
//  CircleJM.m
//  CycloneAB
//
//  Created by johnny on 14/10/29.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "CircleJM.h"

@implementation CircleJM
-(instancetype)init
{
    if (self=[super init]) {
        self.circle_logo=@"";
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //用来有时发送简写例如circle_id写成id也能写入到circle_id中
    if ([key isEqualToString:@"id"]) {
        self.circle_id=value;
    }else
    {
        [super setValue:value forKey:key];
    }
}


@end
