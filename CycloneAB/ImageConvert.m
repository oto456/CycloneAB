//
//  ImageConvert.m
//  CycloneAB
//
//  Created by johnny on 14/11/26.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "ImageConvert.h"

@implementation ImageConvert

+(NSData *) ImageToNSData :(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image, 0.7);
    return data;
}

+(UIImage *) NSDataToImage:(NSData *)data
{
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
