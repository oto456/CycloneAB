//
//  registerViewController.h
//  CycloneAB
//
//  Created by johnny on 14/11/2.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginAndRegisterBL.h"

@interface registerViewController : UIViewController<LoginAndRegisterBLDelegate>

@property(strong,nonatomic)LoginAndRegisterBL *bl;


@end
