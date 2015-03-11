//
//  socialAcountCell.h
//  CycloneAB
//
//  Created by johnny on 14/10/27.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface socialAcountCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *socialLogo;

@property (weak, nonatomic) IBOutlet UILabel *acountName;
@property (strong,nonatomic) NSString *type;

@end
