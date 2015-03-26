//
//  KKPPhotoDetailViewController.h
//  KKPcollectionLayout
//
//  Created by 刘特风 on 15/3/11.
//  Copyright (c) 2015年 kakapo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKPtableHeaderViewController.h"


@interface KKPPhotoDetailViewController : UIViewController

@property(strong,nonatomic) NSIndexPath *fromIndex;

@property(strong,nonatomic) KKPtableHeaderViewController *tableHeaderController;

@end
