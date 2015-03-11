//
//  MeViewController.h
//  CycloneAB
//
//  Created by Albert on 14/11/5.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleAndPersonDAODelegate.h"
#import "CircleAndPersonDAO.h"
#import "PersonJM.h"

@interface MeViewController : UIViewController<CircleAndPersonDAODelegate,UITableViewDataSource,
UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@end
