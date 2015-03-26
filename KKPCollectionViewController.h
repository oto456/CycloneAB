//
//  KKPCollectionViewController.h
//  KKPcollectionLayout
//
//  Created by 刘特风 on 15/3/10.
//  Copyright (c) 2015年 kakapo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKPPhotoCell.h"

@interface KKPCollectionViewController : UICollectionViewController

-(KKPPhotoCell *)collectionviewCellWithIndex:(NSIndexPath*)index;

@end
