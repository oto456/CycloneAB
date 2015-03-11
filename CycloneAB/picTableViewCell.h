//
//  picTableViewCell.h
//  CycloneAB
//
//  Created by johnny on 14/10/30.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface picTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_personName;
@property (weak, nonatomic) IBOutlet UILabel *label_personRemarks;//真名字
@property (weak, nonatomic) IBOutlet UIImageView *imageview_headphoto;
@property (weak, nonatomic) IBOutlet UILabel *label_phonenumber;
@property (strong,nonatomic) NSString* user_id;

@end
