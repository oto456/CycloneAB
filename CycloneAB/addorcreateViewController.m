//
//  addorcreateViewController.m
//  CycloneAB
//
//  Created by edward_ng on 14-10-19.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "addorcreateViewController.h"
#import "NSString+URLEncoding.h"
#import "MyDetailDao.h"
#import "CircleAndPersonDAO.h"

@interface addorcreateViewController ()<CircleAndPersonDAODelegate>

@property (weak, nonatomic) IBOutlet UITabBarItem *tabbaritem_secondpage;
@property(strong,nonatomic)CircleAndPersonDAO *DAO;
@end

@implementation addorcreateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _DAO = [[CircleAndPersonDAO alloc] init];
    _DAO.delegate=self;

    
}

- (IBAction)blueButton:(id)sender {
    NSString *path = [@"/add_info.php" URLEncodedString];
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setValue:@"modify_info" forKey:@"function"];
    [param setValue:[MyDetailDao getMyuser_id]  forKey:@"user_id"];
    [param setValue:[MyDetailDao getMyMD5PassWord] forKey:@"password"];
    [param setValue:@"wechat" forKey:@"info_key"];
    [param setValue:@"woshidashabi" forKey:@"info_value"];
    
    
    
    MKNetworkEngine *engin =[[MKNetworkEngine alloc] initWithHostName:@"1.contaclone.sinaapp.com" customHeaderFields:nil];
    MKNetworkOperation *op= [engin operationWithPath:path params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation){
        NSLog(@"do this");
        NSData *data= [operation responseData];
        if (data) {
            NSLog(@"have something");
        }
        
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        int count = [resDict count];
                    NSLog(@"count %d",count);
        
        
        for ( id key in resDict) {
            NSLog(@"key :%@, value: %@",key,[resDict objectForKey:key]);
        }
        NSMutableArray *params= [resDict objectForKey:@"params"];
        for(NSDictionary *dic in params)
        {
            NSLog(@"%@",[dic objectForKey:@"circle_id"]);
        }
        NSString *function=[resDict objectForKey:@"function"];
    } errorHandler:
    ^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"haven't success");
    }];
    
    [engin enqueueOperation:op];
}

//用于测试
- (IBAction)green:(id)sender {
//    [_DAO getMyDetail];
    _textViewForText.text=[APService registrationID];
    NSLog(@"registrationID: %@",[APService registrationID]);
}

-(void)getMyDetailFinished:(NSMutableArray *)list
{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
