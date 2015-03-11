//
//  showcircleViewController.m
//  CycloneAB
//
//  Created by edward_ng on 14-10-17.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "showcircleViewController.h"
#import "mycollectionViewController.h"
#import "timelineTableViewController.h"
#import "BROptionsButton.h"

@interface showcircleViewController ()<BROptionButtonDelegate>

@property (strong,nonatomic) UIView *collectionview;
@property (strong,nonatomic) mycollectionViewController * mycollectionViewController;

//timeline
@property (strong,nonatomic) UIView *timelineview;
@property (strong,nonatomic) timelineTableViewController *
mytimelineViewController;

@property (weak, nonatomic) IBOutlet UIView *view_container;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button_change;

@property (nonatomic)int showway; //1=collectionview, 2=timeline

@end

@implementation showcircleViewController


- (IBAction)showChangeActionBar:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"choose to change"
                                  delegate:self
                                  cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"collectionview", @"tableview", nil
                                  ];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    
}


-(void)viewWillAppear:(BOOL)animated
{

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *mainStoryboard= [UIStoryboard storyboardWithName:@"Main" bundle:nil];  //获取stroyboard
    
    // 把标题栏的title改为白色
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
//    self.navigationController.navigationBar.titleTextAttributes=dict;
    [self.navigationItem setTitle:@"我的圈子"];

    
    _mycollectionViewController= [mainStoryboard instantiateViewControllerWithIdentifier:@"NavigationControllerForPersonInCircle"]; //得到collectionview的控制器
        _mytimelineViewController= [mainStoryboard instantiateViewControllerWithIdentifier:@"NavigationControllertimeline"];//得到timeline的控制器
    _collectionview=_mycollectionViewController.view;
    _timelineview=_mytimelineViewController.view;
    [_view_container addSubview:_collectionview];
    _showway=1;  //默认为collection方式
    [self notificationRegister];
    [_button_change setImage:[GetPreSetImage getCollectionIcon]];
    //navigationbar的颜色
//    self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
    self.navigationController.navigationBar.translucent=NO;
   //设置tabbar不透明
    self.tabBarController.tabBar.translucent=NO;
    //设置选中颜色为黑色
    [self.tabBarController.tabBar setSelectedImageTintColor:[UIColor blackColor]];
    
    //中间
    BROptionsButton *brOption = [[BROptionsButton alloc] initForTabBar:self.tabBarController.tabBar forItemIndex:1 delegate:self];
    
    [brOption setImage:[GetPreSetImage getPreSetSecondPageIconNormal] forBROptionsButtonState:BROptionsButtonStateNormal];
    [brOption setImage:[GetPreSetImage getPreSetSecondPageIconOpen] forBROptionsButtonState:BROptionsButtonStateOpened];

}



//注册各种监听事件。
-(void)notificationRegister
{
    // 从collectionview进入显示circle内联系人的页面。
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectionViewToShowPersonInCircle:) name:@"CVTSPICNotification" object:nil];
    //返回showcircleview
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comeback:) name:@"backtoshwocirecle" object:nil];
}

-(void)comeback:(NSNotification *)notification
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void)collectionViewToShowPersonInCircle : (NSNotification *)notification
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex==actionSheet.cancelButtonIndex) {
//        return;
//    }
    
    switch ( buttonIndex) {
        case 0:
            [self changeToCollectionView];      //调用切换collectionview
            break;
        case 1:
            [self changeToTimelineView];                      //调用tableview
            NSLog(@" 1");
            break;
        default:
            break;
    }
}

-(void)changeToCollectionView
{
    if (_showway==2) {
        [_collectionview removeFromSuperview];
        [_view_container addSubview:_collectionview];
        [_button_change setImage:[GetPreSetImage getCollectionIcon]];
        _showway=1;
    }
}

-(void)changeToTimelineView
{
    if (_showway==1) {
        [_timelineview removeFromSuperview];
        [_view_container addSubview:_timelineview];
        [_button_change setImage:[GetPreSetImage getTimeLineIcon]];
        _showway=2;
    }
}

#pragma mark - BROptionsButtonState

- (NSInteger)brOptionsButtonNumberOfItems:(BROptionsButton *)brOptionsButton
{
    return 2;
}

- (UIImage*)brOptionsButton:(BROptionsButton *)brOptionsButton imageForItemAtIndex:(NSInteger)index
{
    UIImage *image;
    switch (index) {
        case 1:
            image = [GetPreSetImage getPreSetSecondPageIconCreate];
            break;
        default:
            image = [GetPreSetImage getPreSetSecondPageIconJoin];
            break;
    }
    return image;
}


- (void)brOptionsButton:(BROptionsButton *)brOptionsButton didSelectItem:(BROptionItem *)item
{
    //从左至右 item.index 3210.
    [self.tabBarController setSelectedIndex:brOptionsButton.locationIndexInTabBar];
    NSLog(@"%ld",(long)item.index);
    switch (item.index) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadView" object:@"addVC"];
            break;
        default:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadView" object:@"joinVC"];
            NSLog(@"post it");
            break;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
