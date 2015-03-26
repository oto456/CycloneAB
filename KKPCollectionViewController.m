//
//  KKPCollectionViewController.m
//  KKPcollectionLayout
//
//  Created by 刘特风 on 15/3/10.
//  Copyright (c) 2015年 kakapo. All rights reserved.
//

#import "KKPCollectionViewController.h"
#import "KKPCollectionlayout.h"
#import "KKPPhotoDetailViewController.h"
#import "KKPTransitionFromCLVToPD.h"
#import "KKPPhotoCell.h"


@interface KKPCollectionViewController ()<UICollectionViewDelegateFlowLayout,KKPViewLayoutDelegate,UINavigationControllerDelegate>

@end

@implementation KKPCollectionViewController

static NSString * const reuseIdentifier = @"KKPPhotoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.hidesBarsOnSwipe=YES;

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

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




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    if ([segue.destinationViewController isKindOfClass:[KKPPhotoDetailViewController class]]){
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        NSLog(@"prepareForSegue");
        // Set the thing on the view controller we're about to show
   
            KKPPhotoDetailViewController *secondViewController = segue.destinationViewController;
            secondViewController.fromIndex=selectedIndexPath;
  
    }

}




#pragma mark UINavigationControllerDelegate methods
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (fromVC == self && [toVC isKindOfClass:[KKPPhotoDetailViewController class]]) {
        return [[KKPTransitionFromCLVToPD alloc] init];
    }
    else {
        return nil;
    }

}






#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KKPPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    cell.backgroundColor = [UIColor yellowColor];
    cell.imageview.image=[UIImage imageNamed:@"cover"];
    cell.index=indexPath;
    return cell;
}

#pragma mark <UICollectionViewDelegate>



/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark <UICollectionViewDelegateFlowLayout>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat randomHeight = 100+(arc4random()%140);
    return CGSizeMake(100, randomHeight);
}


#pragma mark <KKPViewLayoutDelegate>
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(KKPCollectionlayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat randomHeight = 100 + (arc4random() % 140);
    return randomHeight;
}


-(KKPPhotoCell *)collectionviewCellWithIndex:(NSIndexPath*)index;
{
    return (KKPPhotoCell *)[self.collectionView cellForItemAtIndexPath:index];
}


@end
