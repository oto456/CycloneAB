//
//  perBasicDataCell.h
//  CycloneAB
//
//  Created by johnny on 14/10/26.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface perBasicDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mobilePhone;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property (weak, nonatomic) IBOutlet UIImageView *headLogo;
@property (weak, nonatomic) IBOutlet UILabel *remarks;


@end
