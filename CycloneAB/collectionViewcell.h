//
//  collectionViewcell.h
//  CycloneAB
//
//  Created by edward_ng on 14-10-15.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface collectionViewcell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *label; //名字
@property (weak,nonatomic) NSString * circle_id;
@property(strong,nonatomic)NSString * circle_passw;
@property(nonatomic) int red_dot;
@property(strong,nonatomic) UIImageView *badge;
@property(nonatomic) NSInteger indexPath_row;

-(void)update;
-(void)haveCheck;


@end
