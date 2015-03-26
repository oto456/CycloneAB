//
//  mycollectionViewController.m
//  CycloneAB
//
//  Created by edward_ng on 14-10-15.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "mycollectionViewController.h"
#import "peoplecircleTableViewController.h"
#import "CircleAndPersonDAO.h"

@interface mycollectionViewController ()<CircleAndPersonDAODelegate>

@property (strong,nonatomic) UIStoryboard *mainStoryboard;
@property (strong,nonatomic) UINavigationController *tableview_peopleincircle;
@property (strong,nonatomic) CircleAndPersonDAO *DAO;
@property(strong,nonatomic) NSMutableArray * list_circle;

@end

@implementation mycollectionViewController



-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view. 
//    _mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    _tableview_peopleincircle=[_mainStoryboard instantiateViewControllerWithIdentifier:@"NavigationControllerForPersonInCircle"];
//    _tableview_peopleincircle.modalPresentationStyle=UIModalTransitionStyleCoverVertical;
//    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.collectionView.backgroundColor= [UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.navigationController.navigationBar.translucent=NO;
//        self.navigationController.navigationBar.barTintColor=[UIColor grayColor];
    _DAO = [[CircleAndPersonDAO alloc] init];
    _DAO.delegate=self;
    [self getCircleFromServe];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toReload:) name:@"reload" object:nil];
}

-(void)toReload:(NSNotification *)nsnotification
{
    [self getCircleFromServe];
    [self.collectionView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getCircleFromServe
{
    [_DAO findAllMyCircle];
}

-(void)findAllMyCircleFinished:(NSMutableArray *)list
{
    _list_circle=[[NSMutableArray alloc] init];
    _list_circle=list;
    [self.collectionView reloadData];
}

-(void)findAllMyCirclefail:(NSError *)error
{
        NSString *errorStr=[error localizedDescription];
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"操作信息" message:errorStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];

}


#pragma mark - collectionviewcontroller

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_list_circle) {
        return _list_circle.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CircleJM *temp=[[CircleJM alloc] init];
    if (_list_circle) {
        temp=[_list_circle objectAtIndex:indexPath.row];
        collectionViewcell *cell =(collectionViewcell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"circle" forIndexPath:indexPath];
        cell.indexPath_row=indexPath.row;
        cell.circle_id=temp.circle_id;
        cell.label.text=temp.circle_name;
        cell.circle_passw=temp.circle_passw;
        cell.image.layer.masksToBounds=YES;
        cell.image.layer.cornerRadius=35;
        cell.image.image=[GetPreSetImage getPreSetCircleLoge];
        if (temp.circle_logo) {
            cell.image.image=[ImageConvert NSDataToImage:temp.circle_logo];
            NSString *result = [[NSString alloc] initWithData:temp.circle_logo  encoding:NSUTF8StringEncoding];
            NSLog(@"asdasdasd :%@",result);
        }
        cell.red_dot = temp.red_dot;
        if (cell.red_dot ==1) {
            [cell update];
        }
        return cell;
    }else{
    int pic=indexPath.row%2;
    NSString *picpath= [[NSString alloc] initWithFormat:@"%d",pic ];
    collectionViewcell *cell =(collectionViewcell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"circle" forIndexPath:indexPath];
    cell.label.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.image.image=[GetPreSetImage getPreSetCircleLoge];
    cell.image.layer.masksToBounds=YES;
    cell.image.layer.cornerRadius=35;

    cell.circle_id=[NSString stringWithFormat:@"hello %ld",(long)indexPath.row];
    return cell;
    }
}


/*

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    [self presentViewController:_tableview_peopleincircle animated:YES completion:^{
        NSLog(@" show tableview for person in cirecle %d",indexPath.row);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CVTSPICNotification" object:nil];  //发送通知
    }];
}

 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showpersonincircle"]) {
        collectionViewcell *cell=sender;
        peoplecircleTableViewController *peopleInCircleCV=segue.destinationViewController;
        [peopleInCircleCV setCircle_id:cell.circle_id];
        [peopleInCircleCV setCircle_name:cell.label.text];
        [peopleInCircleCV setCircle_passw:cell.circle_passw];
        if (cell.red_dot==1) {
            [[_list_circle objectAtIndex:cell.indexPath_row] setRed_dot:0];
            [cell haveCheck];
        }
    }
    
}


@end
