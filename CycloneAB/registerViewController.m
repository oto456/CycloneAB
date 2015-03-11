//
//  registerViewController.m
//  CycloneAB
//
//  Created by johnny on 14/11/2.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "registerViewController.h"

@interface registerViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password2;

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bl=[[LoginAndRegisterBL alloc] init];
    _bl.delegate=self;
    _password.secureTextEntry=YES;
    _password2.secureTextEntry=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)releaseAllKeyboard:(id)sender {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (IBAction)OKbuttonClick:(id)sender {
    if (!_name.text||!_username.text||!_password.text||[_name.text isEqual:@""]||[_username.text isEqual:@""]||[_password isEqual:@""]) {
        UIAlertView *alerview =[[UIAlertView alloc] initWithTitle:@"操作信息" message:@"请任何一个都别为空" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerview show];
    }
    else{
        if ([_password.text isEqualToString:_password2.text]) {
            NSMutableDictionary *nsdataforregister =[[NSMutableDictionary alloc] init];
            [nsdataforregister setValue:(_name.text) forKey:@"name"];
            [nsdataforregister setValue:(_password.text) forKey:@"password"];
            [nsdataforregister setValue:(_username.text) forKey:@"username"];
            NSLog(_name.text);
            [_bl toregister:nsdataforregister];

        }else{
            UIAlertView *alerview =[[UIAlertView alloc] initWithTitle:@"操作信息" message:@"两次输入密码不相同请检查" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerview show];

        }
    }
}


- (IBAction)CancelButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- bl

-(void)toRegisterSuccess:(NSDictionary *)user
{
    UIAlertView *alerview =[[UIAlertView alloc] initWithTitle:@"注册成功" message:@"请返回登陆页面登录" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alerview show];
    alerview.tag=1;
}

-(void)toRegisterFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    alertView.tag=1;
}

#pragma mark- alertview
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
