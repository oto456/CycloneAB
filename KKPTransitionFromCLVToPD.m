//
//  KKPTransitionFromCLVToPD.m
//  KKPcollectionLayout
//
//  Created by 刘特风 on 15/3/11.
//  Copyright (c) 2015年 kakapo. All rights reserved.
//

#import "KKPTransitionFromCLVToPD.h"
#import "KKPCollectionViewController.h"
#import "KKPPhotoDetailViewController.h"
#import "KKPPhotoCell.h"


@interface KKPTransitionFromCLVToPD()


@end


@implementation KKPTransitionFromCLVToPD

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    KKPCollectionViewController *fromViewController= (KKPCollectionViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    KKPPhotoDetailViewController *toViewController= (KKPPhotoDetailViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    //截屏，截取那个我们要点击的cell
    KKPPhotoCell *cell = (KKPPhotoCell*)[fromViewController.collectionView cellForItemAtIndexPath:[[fromViewController.collectionView indexPathsForSelectedItems] firstObject]];
    UIView *cellImageSnapshot = [cell.imageview snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:cell.imageview.frame fromView:cell.imageview.superview];
    cell.imageview.hidden = YES;
    
    // 设置开始时视图状态。（动画之初）
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    toViewController.view.hidden = YES;

    [containerView addSubview:toViewController.view];
    [containerView addSubview:cellImageSnapshot];
    
    //动画实现部分
    [UIView animateWithDuration:duration animations:^{
        //第二个页面的view慢慢显示出来.
        toViewController.view.alpha=1;
        //相对坐标转换
        CGRect frame=[containerView convertRect:toViewController.tableHeaderController.imageView.frame fromView:toViewController.tableHeaderController.view];
        cellImageSnapshot.frame=frame;
    } completion:^(BOOL finished) {
        //动画完成，善后工作
        toViewController.view.hidden = NO;
        cell.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        // 宣布完成
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];

    }];

}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

@end
