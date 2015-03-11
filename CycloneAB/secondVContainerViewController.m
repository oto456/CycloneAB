//
//  secondVContainerViewController.m
//  CycloneAB
//
//  Created by johnny on 14/10/29.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "secondVContainerViewController.h"
#import "addorcreateViewController.h"
#import "joinCircleTableViewController.h"

@interface secondVContainerViewController()
@property (weak, nonatomic) IBOutlet UIView *view_container;
@property(strong,nonatomic) addorcreateViewController * addVC;
@property(strong,nonatomic) joinCircleTableViewController *joinVC;
@end

@implementation secondVContainerViewController

int showway;//2add 1join


-(void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadView:) name:@"loadView" object:nil];
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _addVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"addVC"];
    _joinVC= [mainStoryboard instantiateViewControllerWithIdentifier:@"NavigationControllerForJoinCircle"];
}

-(void)loadView:(NSNotification *) notification
{
    id flag=[notification object];
    NSLog(flag);
    if ([flag isEqual:@"addVC"]) {
        if (showway!=2) {
            [_joinVC.view removeFromSuperview];
            [_view_container addSubview:_addVC.view];
        }
        
    }
    if ([flag isEqual:@"joinVC"]) {
        if (showway!=1) {
            [_addVC.view removeFromSuperview];
            [_view_container addSubview:_joinVC.view];
        }
        
    }
    
}


@end
