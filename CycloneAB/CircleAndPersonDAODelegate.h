//
//  CircleAndPersonDAODelegate.h
//  CycloneAB
//
//  Created by edward_ng on 14-10-21.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CircleAndPersonDAODelegate <NSObject>

-(void)findAllMyCircleFinished:(NSMutableArray *)list;
-(void)findAllMyCirclefail:(NSError *) error;

-(void)quitCircleFinished;
-(void)quitCircleFail:(NSError *) error;

-(void)findPersonInCircleFinished:(NSMutableArray* )list;
-(void)findPersonInCircleFail:(NSError *) error;

-(void)findPersonDetailFinished:(NSMutableArray *)list;
-(void)findPersonDetailFail:(NSError *) error;

-(void)createCircleFinished;
-(void)createCircleFail:(NSError *) error;

-(void)joinCircleFinished;
-(void)joinCircleFail:(NSError *) error;

-(void)modifycircleFinished;
-(void)modifycircleFail:(NSError *)error;

-(void)deleteMyDetailInfoForKeyFinished;
-(void)deleteMyDeTailInfoForKeyFail:(NSError *)error;

-(void)modifyMyDetailInfoForKeyFinished;
-(void)modifyMyDetailInfoForKeyFail:(NSError *)error;

-(void)addMyInfoValueFinished;
-(void)addMyInfoValueFail:(NSError *)error;

-(void)getMyDetailFinished:(NSMutableArray *)list;
-(void)getmyDetailFail:(NSError *)error;

-(void)uploadphotoFinished;
-(void)uploadphotoFail:(NSError *)error;

@end
