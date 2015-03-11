//
//  JchooseToPublicTableViewController.h
//  CycloneAB
//
//  Created by johnny on 14/11/9.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassArrayToPublic <NSObject>
//回传
-(void)setArrayToPublic:(NSMutableArray *)array;

@end


@interface JchooseToPublicTableViewController : UITableViewController
{
    id<PassArrayToPublic>delegate;
    
}

@property (weak,nonatomic) id<PassArrayToPublic> delegate;
@property(strong,nonatomic) NSMutableArray *array;

@end
