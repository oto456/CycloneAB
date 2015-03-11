//
//  MeViewController.m
//  CycloneAB
//
//  Created by Albert on 14/11/5.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "MeViewController.h"
#import "myCardTableViewCell.h"
#import "changeViewController.h"

@interface MeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UIImageView *headphoto;
@property (weak, nonatomic) IBOutlet UITableView *metableview;
@property (strong, nonatomic) IBOutlet UITextField *textfield;
@property (strong, nonatomic) IBOutlet UIButton *button_select;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property(strong,nonatomic) CircleAndPersonDAO *DAO;
@property (strong,nonatomic) NSMutableArray *array;
@property (strong,nonatomic) NSString *addType;
@property (strong,nonatomic) PersonJM *person;
@property (strong,nonatomic) UIImage *image;

@end

@implementation MeViewController



- (void)changeSocial:(NSNotification *)notification
{
    _addType=[notification object];
    NSLog(@"你已经改变了%@",_addType);
    _button_select.titleLabel.text=_addType;
}

-(void)changeview{
    NSLog(@"收到通知了哈哈哈");
    [_DAO getMyDetail];
}

- (void)viewDidLoad {
    //接受返回的通知
    NSLog(@"viewdidload");
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSocial:) name:@"SocialNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeview) name:@"ensureNotification" object:nil];

    _textfield.hidden=YES;
    _textfield.delegate=self;
    [self.navigationItem setTitle:@"我的资料"];
    _button_select.hidden=YES;
    
    _DAO = [[CircleAndPersonDAO alloc] init];
    [_DAO getMyDetail];
    _DAO.delegate=self;
    
    UIImage *headimage=[UIImage imageNamed:@"0"];
    [_headphoto setImage:headimage];
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
    
    _metableview.delegate=self;
    _metableview.dataSource=self;
    
    
    NSLog(@"%lu",[_array count]);
    
}
- (IBAction)action_image:(id)sender {
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }else if (buttonIndex==2){
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    _image = [info  objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [_DAO uploadPic:[ImageConvert ImageToNSData:_image] forWhat:1];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_100.png"]];   // 保存文件的名称
    [UIImagePNGRepresentation(_image)writeToFile: filePath    atomically:YES];
    
    //[self dicPaths];
}
-(void)uploadphotoFinished
{
    NSLog(@"成功了");
    _headphoto.image=_image;
}

-(void)uploadphotoFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

-(void)plist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_100.png"]];   // 保存文件的名称
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    [_headphoto setImage:img];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//返回cell的row数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_array) {
        NSLog(@"返回cell数");
        NSUInteger i=[_array count];
        NSLog(@"返回cell的数%d",i);
        return i+1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_array) {
        NSLog(@"设置不同的cell");
        if (indexPath.row<[_array count]) {
            myCardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"myCard"];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            dic=[_array objectAtIndex:indexPath.row];
            cell.label.text=[dic objectForKey:@"account"];
            cell.type=[dic objectForKey:@"type"];
            UIImage *image=[dic objectForKey:@"logo"];
            [cell.imageview setImage:image];
            NSLog(@"前面的cell导入");
            return cell;
        }else{
            UITableViewCell *cell=[[UITableViewCell alloc]init];
            
            //添加联系方式的文本框
            
            
            _textfield.frame=CGRectMake(10,2,190,35);
            _textfield.text=@"";
            [cell.contentView addSubview:_textfield];
            
            //添加选择何种社交方式的按钮，跳出选择页面的model
            
            _button_select.titleLabel.textColor=[UIColor blueColor];
            _button_select.frame=CGRectMake(200, 0, 80, 35);
            [_button_select setTitle:@"select" forState:UIControlStateNormal];
            
            [cell.contentView addSubview:_button_select];
            
            NSLog(@"最后一行cell导入");
            return cell;
        }
    }
    myCardTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"myCard"];
    return cell;
    
}
//根据点击cell的删除还是添加添加触发不同事件
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"根据点击cell的删除还是添加来触发不同事件");
    if(editingStyle==UITableViewCellEditingStyleInsert){
        //[_array insertObject:_textfield.text atIndex:[_array count]];
        
        //[_metableview insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_DAO modifyMyDetailInfoValue:_textfield.text Forkey:_addType];
        [_array removeAllObjects];
        
        NSLog(@"插入");
    }else if(editingStyle==UITableViewCellEditingStyleDelete){
        NSLog(@"删除第一步");
        NSDictionary *dic=[_array objectAtIndex:indexPath.row];
        NSString *tpyestr= [dic valueForKey:@"type"];
        NSLog(@"删除%@",tpyestr);
        [_DAO modifyMyDetailInfoValue:nil Forkey:tpyestr];
        [_array removeAllObjects];
        //[_metableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"编辑");
    }
    [_metableview reloadData];
}
//没有按下edit时该cell被hidden
//-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"是否隐藏cell");
//    if (indexPath.row<[_array count]) {
//        return NO;
//    }else{
//        _button_select.hidden=YES;
//        return YES;
//    }
//}

//设置不同r行设置不同的editing风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @"设置不同的editing 风格";
    if (indexPath.row==[_array count]) {
        return UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}
//用于响应视图编辑状态
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{   NSLog(@"响应视图编辑状态");
    [super setEditing:editing animated:YES];
    [_metableview setEditing:editing animated:YES];
    if(editing){
        _textfield.hidden=NO;
        _button_select.hidden=NO;
    }else{
        _textfield.hidden=YES;
        _button_select.hidden=YES;
    }
}
//关闭键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITableViewCell *cell=(UITableViewCell *)[[textField superview]superview];
    [_metableview setContentOffset:CGPointMake(0.0,cell.frame.origin.y)animated:YES];
}
-(void)getMyDetailFinished:(NSMutableArray *)list
{
    NSLog(@"getMydetailFinished");
    NSLog(@"count:%d",list.count);
    
    PersonJM *temp=[[PersonJM alloc] init];
    
    temp=[list lastObject];
  
    if (temp.avatar) {
        _headphoto.image=[ImageConvert NSDataToImage:temp.avatar];
    }
    
    _name.text=temp.name;
    _number.text=temp.mobile;
    _birthday.text=temp.birthdayforString;
    
    _array=[temp getArrayForSocialAccount];
    NSLog(@"1111");
    NSMutableDictionary *dic= [[NSMutableDictionary alloc] init];
    NSLog(@"2222");
    //dic=[_array objectAtIndex:0];
    
    NSLog(@"_array有%d",[_array count]);
    //for ( id key in dic) {
     //   NSLog(@"键 :%@, 值: %@",key,[dic objectForKey:key]);
    //}
    [_metableview reloadData];
}
-(void)modifyMyDetailInfoForKeyFinished
{
    [_DAO getMyDetail];
}
-(void)modifyMyDetailInfoForKeyFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];

}



-(void)getmyDetailFail:(NSError *)error
{
    NSString *errorStr=[error localizedDescription];
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"modifyDetail"]) {
        myCardTableViewCell *cell=sender;
        changeViewController *viewcontroller=segue.destinationViewController;
        viewcontroller.type=cell.type;
        viewcontroller.content=cell.label.text;
    }

}


@end
