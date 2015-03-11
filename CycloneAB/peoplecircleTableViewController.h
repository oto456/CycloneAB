//
//  peoplecircleTableViewController.h
//  CycloneAB
//
//  Created by edward_ng on 14-10-16.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface peoplecircleTableViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>
{
   
}


@property(strong,nonatomic) NSString * circle_id;  //当前圈子的id
@property(strong,nonatomic) NSString * circle_name; //当前圈子的名字
@property(strong,nonatomic) NSString *circle_passw;

-(void)filterContentForSearchText:(NSString *)searchtext scope:(NSUInteger)scope;

@end
