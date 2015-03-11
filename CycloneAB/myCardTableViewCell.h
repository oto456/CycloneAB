//
//  myCardTableViewCell.h
//  CycloneAB
//
//  Created by Albert on 14/11/5.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *change;

@property (strong,nonatomic) NSString * type;

@end
