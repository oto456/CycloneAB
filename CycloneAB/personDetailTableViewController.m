//
//  personDetailTableViewController.m
//  CycloneAB
//
//  Created by johnny on 14/10/26.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "personDetailTableViewController.h"
#import "perBasicDataCell.h"
#import "socialAcountCell.h"
#import "CircleAndPersonDAO.h"
#import "RNFrostedSidebar.h"

@interface personDetailTableViewController ()<RNFrostedSidebarDelegate,UIAlertViewDelegate,CircleAndPersonDAODelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic,strong) CircleAndPersonDAO *DAO;
@property (nonatomic,strong) PersonJM * personDetail;

@end

@implementation personDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];

    _DAO = [[CircleAndPersonDAO alloc] init];
    [self initDelegate];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem setTitle:self.user_name];
    // 把标题栏的title改为白色
    UIColor *color = [UIColor whiteColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
//    self.navigationController.navigationBar.titleTextAttributes=dict;
    NSLog(self.user_id);
    NSLog(self.user_name);
    NSLog(self.fromCircle_id);
    [self getDetailFromServe];
}


-(void)viewWillAppear:(BOOL)animated
{
}


\
- (IBAction)actionClick:(id)sender {
    //点击右上角的aciton的响应
    NSLog(@"right button clicked");
    NSArray *images = @[
                        [UIImage imageNamed:@"callmobile"],
                        [UIImage imageNamed:@"sendmessage"],
                        [UIImage imageNamed:@"like"],
                        [UIImage imageNamed:@"ok"],
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    callout.showFromRight=YES;
    [callout show];

}

-(void)getDetailFromServe
{
    CircleJM *circle = [[CircleJM alloc] init];
    circle.circle_id=self.fromCircle_id;
    PersonJM *temp=[[PersonJM alloc] init];
    temp.user_id=self.user_id;
    [_DAO findPersonDetail:temp FromCircle:circle];
}

-(void)initDelegate
{
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _DAO.delegate=self;
}

//理解错误 此功能不需要
//修改备注
//- (IBAction)setRemarks:(id)sender {
//    
//    UIAlertView *alert1=[[UIAlertView alloc]
//                         initWithTitle:@"备注"
//                         message:@"请输入新备注"
//                         delegate:self
//                         cancelButtonTitle:@"取消"
//                         otherButtonTitles:@"确定", nil
//                         ];
//    alert1.tag=1;
//    alert1.alertViewStyle=UIAlertViewStyleSecureTextInput;
//    [alert1 show];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DAO
-(void)findPersonDetailFinished:(NSMutableArray *)list
{
    _personDetail = [[PersonJM alloc] init];
    _personDetail = [list lastObject];
    NSLog(@"%d",list.count);
    NSLog(_personDetail.username);
    NSLog(_personDetail.mobile);
    [self.tableview reloadData];
}

-(void)findPersonDetailFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (_personDetail) {
        return (_personDetail.socialCount+1);
        NSLog(@"sociacount:%d",_personDetail.socialCount);
    }
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Detial Information";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_personDetail) {
        NSMutableArray *socialaccount =[[NSMutableArray alloc] init];
        socialaccount=[_personDetail getArrayForSocialAccount];
        NSLog(@"asdasdasd%d",_personDetail.socialCount);
    if (indexPath.row==0) {
            perBasicDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personBasicData" forIndexPath:indexPath];
        cell.headLogo.image=[GetPreSetImage getPreSetHeadLogo];
        if (_personDetail.avatar) {
            cell.headLogo.image = [ImageConvert NSDataToImage:_personDetail.avatar];
        }
        cell.name.text=_personDetail.name;
        cell.mobilePhone.text=_personDetail.mobile;
        cell.remarks.text=_personDetail.note;
        cell.birthday.text=[_personDetail birthdayforString];
        return cell;
    }
        socialAcountCell *cell=[tableView dequeueReusableCellWithIdentifier:@"socialAcounts" forIndexPath:indexPath];
        cell.socialLogo.image=[UIImage imageNamed:@"1"];
        if (indexPath.row<=socialaccount.count) {
            NSMutableDictionary *socialtemp= [[NSMutableDictionary alloc] init];
            NSMutableArray *accountArray=[_personDetail getArrayForSocialAccount];
            socialtemp=[accountArray objectAtIndex:(indexPath.row-1)];
            NSLog(@"qweqwe:%d",accountArray.count);
            for ( id key in socialtemp) {
                NSLog(@"key :%@, value: %@",key,[socialtemp objectForKey:key]);
            }

            if ([socialtemp objectForKey:@"logo"]) {
                cell.socialLogo.image = [socialtemp objectForKey:@"logo"];
                NSLog(@"asdas");
            }
            NSLog([socialtemp objectForKey:@"account"]);
            cell.acountName.text = [socialtemp objectForKey:@"account"];
            return cell;
        }
    }
    if (indexPath.row==0) {
        perBasicDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personBasicData" forIndexPath:indexPath];
        cell.headLogo.image=[GetPreSetImage getPreSetHeadLogo];
        return cell;
    }
    socialAcountCell *cell=[tableView dequeueReusableCellWithIdentifier:@"socialAcounts" forIndexPath:indexPath];
    // Configure the cell...
    cell.socialLogo.image=[UIImage imageNamed:@"1"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 150.0f;
    }
    return 40.0f;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - alertview
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1){
        if (buttonIndex==0) {
            NSLog(@"0");
        }if (buttonIndex==1) {
            NSLog(@"1");
        }
    }
    
}




#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %lu",(unsigned long)index);
    
    switch (index) {
        case 0:
            [sidebar dismiss];
            [self makeThePhoneCall];
            break;
            case 1:
            [sidebar dismiss];
            break;
            case 2:
            [sidebar dismiss];
            break;
            case 3:
            [sidebar dismiss];
            break;
        default:
            break;
    }
}

-(void)makeThePhoneCall
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_personDetail.mobile];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    NSLog(@"call");
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}


@end
