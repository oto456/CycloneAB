//
//  personJM.m
//  CycloneAB
//
//  Created by johnny on 14/10/29.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "PersonJM.h"

@implementation PersonJM

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //用来有时发送简写例如user_id写成id也能写入到user_id中
    if ([key isEqualToString:@"id"]) {
        self.user_id=value;
    }else
    {
        [super setValue:value forKey:key];
    }
}




-(NSInteger)socialCount
{
    NSInteger num=0;
    if (self.wechat) {
        num++;
    }
    if (self.qq) {
        num++;
    }
    if (self.email) {
        num++;
    }
    if (self.weibo) {
        num++;
    }
    if (self.renren) {
        num++;
    }
    return num;

}

-(NSString *)birthdayforString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
}

-(NSMutableArray *)getArrayForSocialAccount
{
    NSMutableArray * socialArray=[[NSMutableArray alloc] init];
    if (self.wechat) {
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
        UIImage *logo=[UIImage imageNamed:@"wechat"];
        [temp setValue:self.wechat forKey:@"account"];
        [temp setValue:logo forKey:@"logo"];
        [temp setValue:@"wechat" forKey:@"type"];
        [socialArray addObject:temp];
    }
    if (self.qq) {
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
        UIImage *logo=[UIImage imageNamed:@"qq"];
        [temp setValue:self.qq forKey:@"account"];
        [temp setValue:logo forKey:@"logo"];
        [temp setValue:@"qq" forKey:@"type"];
        [socialArray addObject:temp];
    }
    if (self.email) {
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
        UIImage *logo=[UIImage imageNamed:@"email"];
        [temp setValue:self.email forKey:@"account"];
        [temp setValue:logo forKey:@"logo"];
        [temp setValue:@"email" forKey:@"type"];
        [socialArray addObject:temp];
    }
    if (self.weibo) {
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
        UIImage *logo=[UIImage imageNamed:@"weibo"];
        [temp setValue:self.weibo forKey:@"account"];
        [temp setValue:logo forKey:@"logo"];
        [temp setValue:@"weibo" forKey:@"type"];
        [socialArray addObject:temp];
    }
    if (self.renren) {
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
        UIImage *logo=[UIImage imageNamed:@"renren"];
        [temp setValue:self.renren forKey:@"account"];
        [temp setValue:logo forKey:@"logo"];
        [temp setValue:@"renren" forKey:@"type"];
        [socialArray addObject:temp];
    }
    return socialArray;
}

@end
