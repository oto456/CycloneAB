//
//  NSString+URLEncoding.m
//  CycloneAB
//
//  Created by edward_ng on 14-10-22.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

-(NSString *)URLEncodedString
{
    NSString *result=(NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("+$,#[] "), kCFStringEncodingUTF8));
    return result;
}

-(NSString *) URLDecodedString
{
    NSString *result=(NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    return result;
}

@end
