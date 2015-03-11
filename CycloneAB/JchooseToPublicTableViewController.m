//
//  JchooseToPublicTableViewController.m
//  CycloneAB
//
//  Created by johnny on 14/11/9.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "JchooseToPublicTableViewController.h"
#import "CircleAndPersonDAO.h"
#import "socialAcountCell.h"


@interface JchooseToPublicTableViewController ()<CircleAndPersonDAODelegate>
@property(strong,nonatomic) CircleAndPersonDAO*DAO;
@property(strong,nonatomic) PersonJM *Mydetail;


@end

@implementation JchooseToPublicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_array) {
        _array =[[NSMutableArray alloc] init];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _DAO = [[CircleAndPersonDAO alloc] init];
    _DAO.delegate=self;
    [self getFromServe];
}

-(void)getFromServe
{
    [_DAO getMyDetail];
}

-(void)getMyDetailFinished:(NSMutableArray *)list
{
    _Mydetail = [[PersonJM alloc] init];
    _Mydetail = [list lastObject];
    [self.tableView reloadData];
}

-(void)getmyDetailFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)DoneButtonClick:(id)sender {
    NSLog(@"_array.count :%d",_array.count);
    [_delegate setArrayToPublic:_array];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (_Mydetail) {
        return _Mydetail.socialCount;
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    socialAcountCell *cell = [self.tableView
                             cellForRowAtIndexPath: indexPath ];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        for (int i=0; i<_array.count; i++) {
            socialAcountCell *temp=[_array objectAtIndex:i];
            if ([temp.type isEqualToString:cell.type]) {
                [_array removeObjectAtIndex:i];
            }
        }
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [_array addObject:cell];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
    cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_Mydetail) {
        socialAcountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"socialAcounts" forIndexPath:indexPath];

        NSMutableArray *socialaccount =[[NSMutableArray alloc] init];
        socialaccount=[_Mydetail getArrayForSocialAccount];
        
        cell.socialLogo.image=[UIImage imageNamed:@"1"];
        if (indexPath.row<=socialaccount.count) {
            NSMutableDictionary *socialtemp= [[NSMutableDictionary alloc] init];
            socialtemp=[socialaccount objectAtIndex:(indexPath.row)];
            NSLog(@"qweqwe:%d",socialaccount.count);
            for ( id key in socialtemp) {
                NSLog(@"key :%@, value: %@",key,[socialtemp objectForKey:key]);
            }
            
            if ([socialtemp objectForKey:@"logo"]) {
                cell.socialLogo.image = [socialtemp objectForKey:@"logo"];
                NSLog(@"asdas");
            }
            NSLog([socialtemp objectForKey:@"account"]);
            cell.acountName.text = [socialtemp objectForKey:@"account"];
            cell.type=[socialtemp objectForKey:@"type"];
            //判断是否是传过来的array中的（即选中的，是的话要标记）
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            for (socialAcountCell *temp in _array) {
                if ([temp.type isEqualToString:cell.type]) {
                    cell.accessoryType =UITableViewCellAccessoryNone;
                }
            }
        return cell;
        }
    }
        socialAcountCell *cell=[tableView dequeueReusableCellWithIdentifier:@"socialAcounts" forIndexPath:indexPath];
        return cell;

}

#pragma mark -DAO

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

@end
