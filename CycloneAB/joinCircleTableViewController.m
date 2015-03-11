//
//  joinCircleTableViewController.m
//  CycloneAB
//
//  Created by johnny on 14/10/30.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "joinCircleTableViewController.h"
#import "CircleAndPersonDAO.h"
#import "socialAcountCell.h"
#import "JchooseToPublicTableViewController.h"


@interface joinCircleTableViewController ()<CircleAndPersonDAODelegate,PassArrayToPublic>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbuttonItem_done;
@property (weak, nonatomic) IBOutlet UITextField *circle_name;
@property (weak, nonatomic) IBOutlet UITextField *circle_password;
@property (strong,nonatomic) CircleAndPersonDAO * DAO;
//储存公开信息的数组
@property(strong,nonatomic) NSMutableArray *array;


@end

@implementation joinCircleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _DAO=[[CircleAndPersonDAO alloc] init];
    _DAO.delegate=self;
    _array =[[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _barbuttonItem_done.enabled=NO;
    //注册键盘监听事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneButtonshow:) name:UIKeyboardDidShowNotification object:nil];
    [self.navigationItem setTitle:@"加入圈子"];
    // 把标题栏的title改为白色
    UIColor *color = [UIColor whiteColor];
    // navigation设置为灰色
//    self.navigationController.navigationBar.barTintColor=[UIColor grayColor];

    self.navigationController.navigationBar.translucent=NO;

//    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
//    self.navigationController.navigationBar.titleTextAttributes=dict;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    _barbuttonItem_done.enabled=NO;
}

-(void)doneButtonshow:(NSNotification *)notification{
    _barbuttonItem_done.enabled=YES;
}


- (IBAction)cancelButtonClick:(id)sender {
    _circle_name.text=@"";
    _circle_password.text=@"";
    //清空
    _array =[[NSMutableArray alloc] init];
}

- (IBAction)doneTohideKB:(id)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    _barbuttonItem_done.enabled=NO;
}

- (IBAction)OKbuttonClick:(id)sender {
    if ([_circle_name.text isEqual:@""]||[_circle_password isEqual:@""]) {
        UIAlertView *alerview =[[UIAlertView alloc] initWithTitle:@"操作信息" message:@"请任何一个都别为空" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerview show];
    }
    else{
        _barbuttonItem_done.enabled=YES;
        CircleJM* circle=[[CircleJM alloc] init];
        circle.circle_id=_circle_name.text;
        circle.circle_passw=_circle_password.text;
        NSString *private =@"";
        for (socialAcountCell *temp in _array) {
            private = [private stringByAppendingString:[NSString stringWithFormat:@"%@/",temp.type]];
        }
        NSLog(private);
        [_DAO joinCircle:circle accountarray:private];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark  - DAO

-(void)joinCircleFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

-(void)joinCircleFinished
{
    _circle_name.text=@"";
    _circle_password.text=@"";
    
    UIAlertView *alerview =[[UIAlertView alloc] initWithTitle:@"加圈子成功" message:@"请返回圈子页面查看吧" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerview show];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
    
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
            n=3;
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


#pragma mark
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
