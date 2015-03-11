//
//  ImageConvert.h
//  CycloneAB
//
//  Created by johnny on 14/11/26.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageConvert : NSObject
+(NSData *) ImageToNSData :(UIImage *)image;
+(UIImage *) NSDataToImage :(NSData *)data;

@end
