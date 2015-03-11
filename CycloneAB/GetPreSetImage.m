//
//  GetPreSetImage.m
//  CycloneAB
//
//  Created by johnny on 14/11/1.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "GetPreSetImage.h"

@implementation GetPreSetImage

+(UIImage *)getPreSetCircleLoge
{
    return [UIImage imageNamed:@"book"];
}

+(UIImage *)getPreSetHeadLogo
{
    return [UIImage imageNamed:@"0"];
}

//+(UIImage *)getPreSetFirstPageIcon
//{
//    
//}
//
//+(UIImage *)getPreSetThirdPageIcon
//{
//    
//}


+(UIImage *)getPreSetSecondPageIconNormal
{
    return [UIImage imageNamed:@"punkin"];
}

+(UIImage *)getPreSetSecondPageIconOpen
{
    return [UIImage imageNamed:@"collection"];
}

+(UIImage *)getPreSetSecondPageIconCreate
{
    return [UIImage imageNamed:@"1"];
}

+(UIImage *)getPreSetSecondPageIconJoin
{
    return [UIImage imageNamed:@"join"];
}

+(UIImage *)getCollectionIcon
{
    return [UIImage imageNamed:@"121"];
}

+(UIImage *)getTimeLineIcon;
{
    return [UIImage imageNamed:@"timeline"];
}

@end
