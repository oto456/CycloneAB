//
//  MySocialTableViewController.m
//  CycloneAB
//
//  Created by Albert on 14/11/6.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "MySocialTableViewController.h"

@interface MySocialTableViewController ()
@property (strong ,nonatomic)NSMutableArray *array;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@property (strong,nonatomic)CircleAndPersonDAO *DAO;

@end

@implementation MySocialTableViewController

- (void)viewDidLoad {
    _array=[[NSMutableArray alloc]initWithObjects:@"weibo",@"qq",@"wechat",@"email",@"renren",nil];
    
    _DAO = [[CircleAndPersonDAO alloc] init];
    [_DAO getMyDetail];
    _DAO.delegate=self;
    
    self.navigationController.navigationBar.translucent=NO;

    
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(clickbackButton)];
    UIBarButtonItem *doneButton=[[UIBarButtonItem
                                  alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(clickdoneButton)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    [self.navigationItem setRightBarButtonItem:doneButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_array count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_selectIndex)
    //之前被选中的设置为空
    {
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:_selectIndex];
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    UITableViewCell *cell=[tableView
                           cellForRowAtIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    _selectIndex=indexPath;
    NSLog(@"%lu",_selectIndex.row);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addCell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"addCell"];
    }
    
    cell.textLabel.text=[_array objectAtIndex:indexPath.row];
    return cell;
}
-(void)clickbackButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)clickdoneButton{
    int i =_selectIndex.row;
    NSString *string=[_array objectAtIndex:i];
    NSLog(@"传回%@",[_array objectAtIndex:i]);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SocialNotification" object:string];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)getMyDetailFinished:(NSMutableArray *)list
{
    PersonJM *temp=[[PersonJM alloc]init];
    temp=[list lastObject];
    
    NSMutableArray *array1=[temp getArrayForSocialAccount];
    for (NSObject *obj in array1){
        NSMutableDictionary *dic = obj;
        NSString *string=[dic objectForKey:@"type"];
        NSLog(@"%@",string);
        [_array removeObject:string];
    }
    [self.tableView reloadData];
}

@end
