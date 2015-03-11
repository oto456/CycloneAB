//
//  NSNumber+Message.m
//  CycloneAB
//
//  Created by edward_ng on 14-10-22.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "NSNumber+Message.h"

@implementation NSNumber (Message)

-(NSString *)errorMessage
{
    NSString *errorStr=@"";
    switch ([self integerValue]) {
        case -1:
            errorStr=@"密码验证失败";
            break;
        case -2:
            errorStr=@"用户名不存在";
            break;
            case -3:
            errorStr=@"注册失败，用户名已存在";
            break;
            case -4:
            errorStr=@"圈子不存在，请检查圈子名";
            break;
            case -5:
            errorStr=@"圈子密码错误";
            break;
            case -6:
            errorStr=@"退圈失败，请稍候重试";
            break;
            case -7:
            errorStr=@"创建失败，圈子名已存在";
            break;
            case -8:
            errorStr=@"未知错误";
            break;
            case -9:
            errorStr=@"修改失败";
            break;
            case -10:
            errorStr=@"删除字段失败";
            break;
            case -11:
            errorStr=@"更改字段失败";
            break;
            case -12:
            errorStr=@"增加字段失败";
            break;
            
        default:
            break;
    }
    return  errorStr;
}

@end
