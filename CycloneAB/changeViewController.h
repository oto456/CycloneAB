//
//  changeViewController.h
//  CycloneAB
//
//  Created by Albert on 14/11/9.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleAndPersonDAO.h"
#import "CircleAndPersonDAODelegate.h"
@interface changeViewController : UIViewController<CircleAndPersonDAODelegate>

@property(strong,nonatomic) NSString *type;
@property(strong,nonatomic) NSString *content;


@end
