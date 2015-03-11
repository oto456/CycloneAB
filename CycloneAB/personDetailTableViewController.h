//
//  personDetailTableViewController.h
//  CycloneAB
//
//  Created by johnny on 14/10/26.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personDetailTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
   
}

@property (strong,nonatomic) NSString *fromCircle_id; // 此圈内联系人来自哪个圈子
@property (strong,nonatomic) NSString *user_id;     //联系人id
@property (strong,nonatomic) NSString *user_name;   //联系人名字

@end
