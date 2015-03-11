//
//  JSONModel.m
//  CycloneAB
//
//  Created by johnny on 14/10/27.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "JSONModel.h"

@implementation JSONModel


//kvc模型基类，用来吧字典写入到模型中。从服务器读数据请继承此类。
-(id)initWithDictionary:(NSDictionary *)jsonDictionary
{
    if ((self=[super init])) {
        [self setValuesForKeysWithDictionary:jsonDictionary];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"Undefined Key : %@",key);
}

@end
