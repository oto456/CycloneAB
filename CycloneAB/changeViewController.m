//
//  changeViewController.m
//  CycloneAB
//
//  Created by Albert on 14/11/9.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "changeViewController.h"
#import "PersonJM.h";


@interface changeViewController ()<CircleAndPersonDAODelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong,nonatomic)CircleAndPersonDAO *DAO;
@property (strong,nonatomic)PersonJM *person;
@property (weak, nonatomic) IBOutlet UIButton *button_green;
@end
@implementation changeViewController

@synthesize type;
@synthesize content;
- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.text=self.content;
    _DAO=[[CircleAndPersonDAO alloc]init];
    _DAO.delegate=self;
}
- (IBAction)releaseKeyboard:(id)sender {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)cancelButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)changeView:(NSNotification *)notification
{
    NSLog(@"nimabi");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)ensure:(id)sender {
    [_DAO modifyMyDetailInfoValue:_textField.text Forkey:self.type];
    _button_green.enabled=NO;
}

-(void)modifyMyDetailInfoForKeyFinished
{
    NSLog(@"dashabi");
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ensureNotification" object:nil];
    _button_green.enabled=YES;
}

-(void)modifycircleFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    _button_green.enabled=YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
