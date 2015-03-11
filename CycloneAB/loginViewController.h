//
//  loginViewController.h
//  CycloneAB
//
//  Created by edward_ng on 14-10-17.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginAndRegisterBLDelegate.h"
#import "LoginAndRegisterBL.h"


@interface loginViewController : UIViewController<UITextViewDelegate,LoginAndRegisterBLDelegate>

@property (strong,nonatomic)LoginAndRegisterBL *bl;



@end
