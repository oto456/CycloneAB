//
//  KKPPhotoCell.h
//  KKPcollectionLayout
//
//  Created by 刘特风 on 15/3/10.
//  Copyright (c) 2015年 kakapo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKPPhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (nonatomic,strong) NSIndexPath *index;

@end
