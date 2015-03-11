//
//  peoplecircleTableViewController.m
//  CycloneAB
//
//  Created by edward_ng on 14-10-16.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "peoplecircleTableViewController.h"
#import "picTableViewCell.h"
#import "personDetailTableViewController.h"
#import "CircleAndPersonDAO.h"

@interface peoplecircleTableViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,CircleAndPersonDAODelegate,UIActionSheetDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) CircleJM * fromCircle;
@property (strong,nonatomic) PersonJM * personTemp;
@property (strong,nonatomic) CircleAndPersonDAO * DAO;


@property (strong,nonatomic) NSMutableArray * list_person;
@property (strong,nonatomic) NSMutableArray * searchresult;

@end

@implementation peoplecircleTableViewController


-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CVTSPICNotification" object:nil];
//    [self.navigationController.parentViewController.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    
    //设定搜索栏scopebar
    [self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];
    
    [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    [super viewDidLoad];
    NSLog(self.circle_name);
    _fromCircle = [[CircleJM alloc] init];
    _DAO=[[CircleAndPersonDAO alloc] init];
    _DAO.delegate=self;
    _fromCircle.circle_name=self.circle_name;
    _fromCircle.circle_id=self.circle_id;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem setTitle:self.circle_name];
   // 把标题栏的title改为白色
    self.navigationController.navigationBar.translucent=NO;

    
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
//    self.navigationController.navigationBar.titleTextAttributes=dict;
    [self getPersonFromServe];
}

-(void)getPersonFromServe
{
    [_DAO findPersonInCircle:_fromCircle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionButtonClick:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"对圈子进行操作"
                                  delegate:self
                                  cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"退出圈子",@"查看圈子id", @"查看进圈暗号",nil
                                  ];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [actionSheet showInView:self.view];
}


#pragma mark - findDAO

-(void)findPersonInCircleFinished:(NSMutableArray *)list
{
    _list_person = [[NSMutableArray alloc] init];
    _list_person = list;
    
    [self.tableView reloadData];
}

-(void)findPersonInCircleFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (_list_person) {
        return _list_person.count;
    }else{
        return 0;
    }
}


- (IBAction)barbutton_back:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//    NSLog(@" click back");
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"backtoshwocirecle" object:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_list_person) {
            picTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pictableviewcell" forIndexPath:indexPath];
        PersonJM *temp=[_list_person objectAtIndex:indexPath.row];
        cell.imageview_headphoto.image=[GetPreSetImage getPreSetHeadLogo];
        if (temp.avatar) {
            cell.imageview_headphoto.image = [ImageConvert NSDataToImage:temp.avatar];
        }
        cell.label_personName.text = temp.username;
        cell.label_personRemarks.text = temp.name;
        cell.label_phonenumber.text = temp.mobile;
        cell.user_id=temp.user_id;
        return cell;
    }
    picTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pictableviewcell" forIndexPath:indexPath];
    // Configure the cell...
    cell.imageview_headphoto.image=[GetPreSetImage getPreSetHeadLogo];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - quitDAO
-(void)quitCircleFinished
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:@"退出圈子成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    alertView.tag=2;
}

-(void)quitCircleFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        picTableViewCell *cell=sender;
        personDetailTableViewController *viewcontroller=segue.destinationViewController;
        viewcontroller.fromCircle_id=self.circle_id;
        viewcontroller.user_name=cell.label_personName.text;
        viewcontroller.user_id=cell.user_id;
    }
}


#pragma mark - uiactionbar

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //导致点击cancelButton无响应
//    if (buttonIndex==actionSheet.cancelButtonIndex) {
//        return;
//    }
    
    switch ( buttonIndex) {
        case 0:
            [self SureToQuit];
      //退出圈子
            break;
        case 1:{
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"圈子ID" message:_circle_id delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
                              //调用查看圈子id
            NSLog(@" 1");
            break;
        }
        case 2:{
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"进圈暗号" message:_circle_passw delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            break;
        }
        default:
            break;
    }
}

#pragma mark -uialerview
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==1){
        CircleJM *circle=[[CircleJM alloc] init];
        switch (buttonIndex) {
            case 1:
                circle.circle_id=self.circle_id;
                circle.circle_name=self.circle_name;
                [_DAO quitCircle:circle];
                break;
            default:
                break;
        }
    }if (alertView.tag==2){
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"backtoshwocirecle" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil]; //让圈子页面reload
    }
        
}



-(void)SureToQuit
{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:@"确定退出圈子吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alertView.tag=1;
    [alertView show];
}

#pragma mark - search bar

-(void)filterContentForSearchText:(NSString *)searchtext scope:(NSUInteger)scope
{
    if ([searchtext length]==0) {
        self.searchresult = [NSMutableArray arrayWithArray:self.list_person];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray;
    
    scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchtext];
    tempArray= [self.list_person filteredArrayUsingPredicate:scopePredicate];
    self.searchresult = [NSMutableArray arrayWithArray:tempArray];
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:self.searchBar.selectedScopeButtonIndex];
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}



@end
