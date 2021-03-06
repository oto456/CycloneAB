//
//  loginViewController.m
//  CycloneAB
//
//  Created by edward_ng on 14-10-17.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "loginViewController.h"
#import <ReactiveCocoa.h>

@interface loginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *switch_remember;
@property (weak, nonatomic) IBOutlet UITextField *txt_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_pwd;
@property (weak, nonatomic) IBOutlet UIButton *button_login;
@property (weak, nonatomic) IBOutlet UIButton *button_register;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation loginViewController

- (IBAction)clickLogin:(id)sender {
    if (!_txt_name.text||!_txt_pwd.text||[_txt_name.text isEqual:@""]||[_txt_pwd.text isEqual:@""]) {
        UIAlertView *alerview =[[UIAlertView alloc] initWithTitle:@"操作信息" message:@"请任何一个都别为空" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerview show];
    }else{
    NSString *username = self.txt_name.text;
    NSString *password = self.txt_pwd.text;
    NSMutableDictionary * user = [[NSMutableDictionary alloc] init];
    [user setValue:username forKey:@"username"];
    [user setValue:password forKey:@"password"];
    [_bl login:user];
    NSLog(@"click login");
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [_scrollView setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height+216)];
    [_scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    _scrollView.tag=0;
}


-(void)hideKeyboard
{
    if (_scrollView.tag==0) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//        [_scrollView setFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height-216)];
        [self.view endEditing:YES];
        _scrollView.tag=1;
    }
}

- (IBAction)releaseKeyboard:(id)sender {
    //点击背景释放键盘
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)clickregister:(id)sender {
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bl=[[LoginAndRegisterBL alloc] init];
    _bl.delegate=self;
    _txt_pwd.secureTextEntry=YES;
    RAC(_button_login,enabled)=[RACSignal combineLatest:@[_txt_name.rac_textSignal,_txt_pwd.rac_textSignal] reduce:^(NSString *name,NSString *pass){
        return @(name.length>3&&pass.length>0);
    }];
    
    [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - bl

-(void)loginSuccess:(NSDictionary *)userData
{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *maininterface= [main instantiateViewControllerWithIdentifier:@"mainInterface"];
    
    [self presentViewController:maininterface animated:YES completion:^{
        NSLog(@"login");
    }];
//    [self.navigationController pushViewController:maininterface animated:YES];
}

-(void)loginFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}



#pragma mark - keyboard

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"] )
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
