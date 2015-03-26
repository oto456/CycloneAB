//
//  KKPPhotoDetailViewController.m
//  KKPcollectionLayout
//
//  Created by 刘特风 on 15/3/11.
//  Copyright (c) 2015年 kakapo. All rights reserved.
//

#import "KKPPhotoDetailViewController.h"
#import "KKPCollectionlayout.h"
#import "KKPCollectionViewController.h"
#import "KKPTransitionFromPDToCLV.h"
#import "KKPPhotoCell.h"


@interface KKPPhotoDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIView *headerCotainer;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation KKPPhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tableView.sectionHeaderHeight = 350;
    _headerCotainer= [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, 580)];
    //设置视图的颜色
    _tableHeaderController=[self.storyboard instantiateViewControllerWithIdentifier:@"KKPtableHeaderViewController"];
    _tableHeaderController.view.frame=_headerCotainer.frame;
    
    //设置表头视图
    _tableView.tableHeaderView = _tableHeaderController.view;
    
    //修改行分隔线颜色
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //设置委托的对象－－－－表的委托，切记添加
    _tableView.dataSource=self;
    _tableView.delegate=self;
    
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
    
    //要用自己实现的back按钮，因为发现如果画面下拉之后back 会出现野指针。所以点击back时 要先跳转到顶部。
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    // Do any additional setup after loading the view.
}



-(void)backClick
{
    //先将视图跳转到顶部。不然会造成野指针。两种方法如下
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
//    [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set outself as the navigation controller's delegate so we're asked for a transitioning object
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Stop being the navigation controller's delegate
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置静态变量，作为标志
    static NSString * identifer = @"comment";
    //创建TableViewCell对象，根据静态变量标志判断缓存中是否已存在
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    //判断TableViewCell是否为空，为空则创建新的
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark NavigationDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (fromVC == self && [toVC isKindOfClass:[KKPCollectionViewController class]]) {
        return [[KKPTransitionFromPDToCLV alloc] init];
    }
    else {
        return nil;
    }
}


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    // Check if this is for our custom transition
    if ([animationController isKindOfClass:[KKPPhotoDetailViewController class]]) {
        return self.interactivePopTransition;
    }
    else {
        return nil;
    }
}


- (void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer*)recognizer {
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
    
}

#pragma mark - scrollerview

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
        // 假设偏移表格高度的20%进行刷新
    
    
    
    
            float height = scrollView.contentSize.height > _tableView.frame.size.height ?_tableView.frame.size.height : scrollView.contentSize.height;
    
    
    
//            if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
//    
//                // 调用上拉刷新方法
//    
//            }
//    
    
    
            if (- scrollView.contentOffset.y / _tableView.frame.size.height > 0.25) {
                
                // 调用下拉刷新方法
                [self.navigationController popViewControllerAnimated:YES];
                
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
