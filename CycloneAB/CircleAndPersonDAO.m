//
//  CircleAndPersonDAO.m
//  CycloneAB
//
//  Created by edward_ng on 14-10-21.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "CircleAndPersonDAO.h"
#import "NSStringdictionary.h"


@implementation CircleAndPersonDAO



//查看我有的圈子
-(void)findAllMyCircle{
    NSString *path = [@"/circle_all.php" URLEncodedString];
    NSLog(@"DAO receive");
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"find_all_mycircle" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id] forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    NSLog([MyDetailDao getMyuser_id]);
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation){
        NSData *data= [operation responseData];
        NSDictionary *resDict= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"resDict : %@",resDict);
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue] >=0) {
            //成功接受数据
            NSMutableArray * listDict= [resDict objectForKey:@"params"];
            NSMutableArray * listData = [NSMutableArray new];
            for(NSMutableDictionary * dic in listDict){
        //用JSONModel的方法写入字典
                //把string转为nsdata
//                NSData *temp = [[dic objectForKey:@"circle_logo"] dataUsingEncoding: NSASCIIStringEncoding];
                NSData *temp = [[NSData alloc] initWithBase64EncodedString:[dic objectForKey:@"circle_logo"] options:0];
                NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] initWithDictionary:dic];
                [dictemp setValue:temp forKey:@"circle_logo"];
                CircleJM * circle=[[CircleJM alloc] initWithDictionary:dictemp];
                [listData addObject:circle];
            }
            //lisData是储存CircleJM对象的数组
            [self.delegate findAllMyCircleFinished:listData];
        
        }else{
            NSInteger resultCode=[resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate findAllMyCirclefail:err];
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError *err){
        NSError *error = [errorOp error];
        [self.delegate findAllMyCirclefail:error];
    }];
    
    [engine enqueueOperation:op];
}



//退出指定圈子
-(void)quitCircle:(CircleJM *)circle
{
    NSString *path = [@"/quit_circle.php" URLEncodedString];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"quitcircle" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id]  forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    [param setValue:circle.circle_id forKey:@"circle_id"];
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue]>=0) {
            [self.delegate quitCircleFinished];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate quitCircleFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        [self.delegate quitCircleFail:err];
    }];
    
    [engine enqueueOperation:op];
}


//查找指定圈子内的联系人
-(void)findPersonInCircle:(CircleJM *)circle
{
    NSString *path = [@"/circle_detail.php" URLEncodedString];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
        [param setValue:@"find_people_in_circle" forKey:@"function"];
    [param setValue:circle.circle_id  forKey:@"circle_id"];
    [param setValue:[MyDetailDao getMyuser_id] forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue]>=0) {
            //成功接受数据
            NSMutableArray * listDict= [resDict objectForKey:@"params"];
            NSMutableArray * listData = [NSMutableArray new];
            
            for(NSMutableDictionary * dic in listDict){
                //先把传来的转成nsdata 注意：64位置
                //用JSONModel的方法写入字典
                NSData *temp;
                if ([dic objectForKey:@"avatar"]) {
                    temp = [[NSData alloc] initWithBase64EncodedString:[dic objectForKey:@"avatar"] options:0];
                }
                NSLog(@"dic : %@",dic);
                NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] initWithDictionary:dic];
                [dictemp setValue:temp forKey:@"avatar"];
                PersonJM * person=[[PersonJM alloc] initWithDictionary:dictemp];
                
                [listData addObject:person];
            }

            //lisData是储存CircleJM对象的数组
            [self.delegate findPersonInCircleFinished:listData];
            
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate findPersonInCircleFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        [self.delegate quitCircleFail:err];
    }];
    
    [engine enqueueOperation:op];
    

}

//查找指定联系人的详细资料
-(void)findPersonDetail:(PersonJM *)user FromCircle:(CircleJM *)Circle
{
    NSString *path = [@"/people_detail.php" URLEncodedString];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"find_person_detail" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id]  forKey:@"user_id"];
    [param setValue:user.user_id forKey:@"the_user_id"];
    [param setValue:Circle.circle_id forKey:@"circle_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    
    NSLog(Circle.circle_id);
    NSLog(user.user_id);
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for ( id key in resDict) {
            NSLog(@"key :%@, value: %@",key,[resDict objectForKey:key]);
        }
        NSMutableArray *params= [resDict objectForKey:@"params"];
        for(NSDictionary *dic in params)
        {
            NSLog(@"%@",[dic objectForKey:@"circle_id"]);
        }

        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue]>=0) {
            //成功接受数据
            NSMutableArray * listDict= [resDict objectForKey:@"params"];
        
            NSMutableArray * listData = [NSMutableArray new];
                //用JSONModel的方法写入字典
            for(NSMutableDictionary * dic in listDict){
                NSData *temp;
                if ([dic objectForKey:@"avatar"]) {
                    temp = [[NSData alloc] initWithBase64EncodedString:[dic objectForKey:@"avatar"] options:0];
                }
                NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] initWithDictionary:dic];
                [dictemp setValue:temp forKey:@"avatar"];
                PersonJM * person=[[PersonJM alloc] initWithDictionary:dictemp];
                [listData addObject:person];
            }
            //lisData是储存CircleJM对象的数组
            [self.delegate findPersonDetailFinished:listData];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate findPersonInCircleFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        [self.delegate quitCircleFail:err];
    }];
    
    [engine enqueueOperation:op];

}

-(void)createCircle:(CircleJM *)circle accountarray:(NSString *)array
{
    NSString *path = [@"/create_circle.php" URLEncodedString];

    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"createcircle" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id]  forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    [param setValue:circle.circle_name  forKey:@"circle_name"];
    [param setValue:circle.circle_passw forKey:@"circle_passw"];
    [param setValue:array forKey:@"private_info"];
    
    NSLog(@"id %@",[MyDetailDao getMyuser_id]);
    NSLog(@"name:%@",circle.circle_name);
    NSLog(@"password:%@",circle.circle_passw);
    NSLog(@"logo:%@",circle.circle_logo);
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        
        for ( id key in resDict) {
            NSLog(@"key :%@, value: %@",key,[resDict objectForKey:key]);
        }

        
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue]>=0) {
            [self.delegate createCircleFinished];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate createCircleFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        [self.delegate quitCircleFail:err];
    }];
    
    [engine enqueueOperation:op];
}

//加圈子

-(void)joinCircle:(CircleJM *)circle accountarray:(NSString *)array
{
    NSString *path = [@"/join_circle.php" URLEncodedString];
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"joincircle" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id]  forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    [param setValue:circle.circle_id forKey:@"circle_id"];
    [param setValue:circle.circle_passw forKey:@"circle_passw"];
    [param setValue:array forKey:@"private_info"];
    
    NSLog(circle.circle_id);
    NSLog(circle.circle_passw);

    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"DAO");
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       
        NSNumber *resultCodeNumber =[resDict objectForKey:@"resultCode"];
        NSString *test=[resDict objectForKey:@"function"];
        NSLog(test);
        NSLog(@"%d",resultCodeNumber);
               if ([resultCodeNumber integerValue]>=0) {
            [self.delegate joinCircleFinished];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate joinCircleFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        [self.delegate joinCircleFail:err];
    }];
    
    [engine enqueueOperation:op];
}

//修改圈子

-(void)modifycircle:(CircleJM *)circle Value:(NSString *)value Key:(NSString *)key
{
    NSString *path = [@"/modify_circle.php" URLEncodedString];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"modifycircle" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id]  forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    [param setValue:key forKey:@"info_key"];
    [param setValue:value forKey:@"info_value"];
    
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue]>=0) {
            [self.delegate modifycircleFinished];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate modifycircleFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        [self.delegate modifycircleFail:err];
    }];
    [engine enqueueOperation:op];
}

-(void)deleteMyDetailInfoForKey:(NSString *)key;
{
    NSString *path = [@"/delete_info.php" URLEncodedString];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"delet_info" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id]  forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    [param setValue:key forKey:@"info_1"];
    
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue]>=0) {
            int flag=0;
            for (NSString *k in [NSStringdictionary getBasicInfoKey]) {
                if ([k isEqualToString:key]) {
                    flag=1;
                    [MyDetailDao removeBasicInfoForKey:key];
                }
                if (flag==1) {
                    [MyDetailDao removeSocialForKey:key];
                }
            
                [self.delegate deleteMyDetailInfoForKeyFinished];}
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate modifycircleFail:err];
        }
     } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error){
        NSError *err = [completedOperation error];
        [self.delegate deleteMyDeTailInfoForKeyFail:err];
    }];
    [engine enqueueOperation:op];
}

-(void)modifyMyDetailInfoValue:(NSString *)value Forkey:(NSString *)key
{
    NSString *path = [@"/modify_info.php" URLEncodedString];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"modify_info" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id]  forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    [param setValue:key forKey:@"info_key"];
    [param setValue:value forKey:@"info_value"];
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];

    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"resDict :%@",resDict);
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue]>=0) {
            if ([key isEqualToString:@"password"]) {
                [MyDetailDao setMD5PassWord:value];
            }
            if ([key isEqualToString:@"name"]) {
                [MyDetailDao setMyname:value];
            }
            if ([key isEqualToString:@"note"]) {
                [MyDetailDao setMyNote:value];
            }
            [self.delegate modifyMyDetailInfoForKeyFinished];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate modifycircleFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        [self.delegate deleteMyDeTailInfoForKeyFail:err];
    }];
    [engine enqueueOperation:op];
}

//增加信息 个人资料的
-(void)addMyInfoValue:(NSString *)value Key:(NSString *)key
{
    NSString *path = [@"/add_info.php" URLEncodedString];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"add_info" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id]  forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    [param setValue:key forKey:@"info_key"];
    [param setValue:value forKey:@"info_value"];
    
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue]>=0) {
            if ([key isEqualToString:@"password"]) {
                [MyDetailDao setMD5PassWord:value];
            }
            if ([key isEqualToString:@"name"]) {
                [MyDetailDao setMyname:value];
            }
            if ([key isEqualToString:@"note"]) {
                [MyDetailDao setMyNote:value];
            }if ([key isEqualToString:@"birthday"]) {
                
            }

            [self.delegate addMyInfoValueFinished];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate addMyInfoValueFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        [self.delegate modifycircleFail:err];
    }];
    [engine enqueueOperation:op];
}

//得到我登记的详细个人信息。
-(void)getMyDetail
{
    NSString *path = [@"/my_detail.php" URLEncodedString];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"get_my_detail" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id]  forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    
    NSLog(@"asdasdasd");
    
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for ( id key in resDict) {
            NSLog(@"key :%@, value: %@",key,[resDict objectForKey:key]);
        }
        NSMutableArray *params= [resDict objectForKey:@"params"];
        for(NSDictionary *dic in params)
        {
            NSLog(@"%@",[dic objectForKey:@"circle_id"]);
        }
        
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue]>=0) {
            //成功接受数据
            NSMutableArray * listDict= [resDict objectForKey:@"params"];
            
            NSMutableArray * listData = [NSMutableArray new];
            //用JSONModel的方法写入字典
            for(NSDictionary * dic in listDict){
                NSData *temp;
                if ([dic objectForKey:@"avatar"]) {
                    temp = [[NSData alloc] initWithBase64EncodedString:[dic objectForKey:@"avatar"] options:0];
                }
                NSLog(@"dic : %@",dic);
                NSMutableDictionary *dictemp = [[NSMutableDictionary alloc] initWithDictionary:dic];
                [dictemp setValue:temp forKey:@"avatar"];
                PersonJM * person=[[PersonJM alloc] initWithDictionary:dictemp];
                [listData addObject:person];
            }
            //lisData是储存CircleJM对象的数组
            [self.delegate getMyDetailFinished:listData];
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate getmyDetailFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        [self.delegate getmyDetailFail:err];
    }];
    [engine enqueueOperation:op];
}

//forwhat 1代表上传用户头像。  2代表上传circle头像
-(void)uploadPic:(NSData *)pic forWhat:(int) forwhat
{
    NSString *path;
    switch (forwhat) {
        case 1:
            path = [@"/save_photo.php" URLEncodedString];
            break;
        case 2:
            break;
    }
//    转化为64
    NSString *base64String = [pic base64EncodedDataWithOptions:0];
    
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"save_photo" forKey:@"function"];
    [param setValue:base64String  forKey:@"avatar"];
    [param setValue:[MyDetailDao getMyuser_id] forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    MKNetworkEngine *engine=[[MKNetworkEngine alloc] initWithHostName:HOOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op=[engine operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"resDict: %@",resDict);
        NSNumber *resultCodeNumber = [resDict objectForKey:@"resultCode"];
        if ([resultCodeNumber integerValue]>=0) {
            [self.delegate uploadphotoFinished];
            
        }else{
            NSInteger resultCode= [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message=[resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            NSError *err=[NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate uploadphotoFail:err];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        [self.delegate uploadphotoFail:err];
    }];
    
    [engine enqueueOperation:op];
}



@end
