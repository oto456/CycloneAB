//
//  createCircleTableViewController.m
//  CycloneAB
//
//  Created by johnny on 14/11/8.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "createCircleTableViewController.h"
#import "CircleAndPersonDAO.h"
#import "JchooseToPublicTableViewController.h"
#import "socialAcountCell.h"

@interface createCircleTableViewController ()<CircleAndPersonDAODelegate,PassArrayToPublic>
@property (weak, nonatomic) IBOutlet UITextField *circle_name;
@property (weak, nonatomic) IBOutlet UITextField *circle_password;
@property (weak, nonatomic) IBOutlet UITextField *circle_password2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton_done;
@property (strong,nonatomic) CircleAndPersonDAO * DAO;
//储存公开信息的数组
@property(strong,nonatomic) NSMutableArray *array;

@end

@implementation createCircleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _circle_password.secureTextEntry=YES;
    _circle_password2.secureTextEntry=YES;
    _DAO=[[CircleAndPersonDAO alloc] init];
    _DAO.delegate=self;
    _array =[[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _barbutton_done.enabled=NO;
    //注册键盘监听事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneButtonshow:) name:UIKeyboardDidShowNotification object:nil];
    [self.navigationItem setTitle:@"创建圈子"];
    // 把标题栏的title改为白色
    UIColor *color = [UIColor whiteColor];
    // navigation设置为灰色
//    self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
    self.navigationController.navigationBar.translucent=NO;

    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
//    self.navigationController.navigationBar.titleTextAttributes=dict;

}

-(void)doneButtonshow:(NSNotification *)notification{
    _barbutton_done.enabled=YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonClick:(id)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    _barbutton_done.enabled=NO;
}


- (IBAction)OkbuttonClick:(id)sender {
    if ([_circle_password.text isEqualToString:_circle_password2.text]) {
        CircleJM *temp=[[CircleJM alloc] init];
        temp.circle_name=_circle_name.text;
        temp.circle_passw=_circle_password.text;
        NSString *private =@"";
        for (socialAcountCell *temp in _array) {
            private = [private stringByAppendingString:[NSString stringWithFormat:@"%@/",temp.type]];
        }
        NSLog(private);
        [_DAO createCircle:temp accountarray:private];
    }else
    {
        UIAlertView *alerview =[[UIAlertView alloc] initWithTitle:@"操作信息" message:@"两次暗号输入不一致" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerview show];
    }
}

- (IBAction)cancelButtonClick:(id)sender {
    _circle_name.text=@"";
    _circle_password.text=@"";
    _circle_password2.text=@"";
    _array = [[NSMutableArray alloc] init];
}

#pragma mark - DAO
-(void)createCircleFinished
{
    _circle_name.text=@"";
    _circle_password.text=@"";
    _circle_password2.text=@"";
    
    UIAlertView *alerview =[[UIAlertView alloc] initWithTitle:@"创建圈子成功" message:@"请返回圈子页面查看吧" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerview show];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
}

-(void)createCircleFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    int n=0;
    switch (section) {
        case 0:
            n=4;
            break;
        case 1:
            n=2;
        default:
            break;
    }
    return n;
}

#pragma mark - pass
-(void)setArrayToPublic:(NSMutableArray *)array
{
    NSLog(@"recive array");
    _array=array;
    for (socialAcountCell *temp in _array) {
        NSLog(@"type: %@",temp.type);
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"chooseToPublic"]) {
        JchooseToPublicTableViewController * destinantionVC =segue.destinationViewController;
        destinantionVC.delegate=self;
        destinantionVC.array=_array;
    }
}


@end
