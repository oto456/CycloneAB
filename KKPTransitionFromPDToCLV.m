//
//  KKPTransitionFromPDToCLV.m
//  KKPcollectionLayout
//
//  Created by 刘特风 on 15/3/12.
//  Copyright (c) 2015年 kakapo. All rights reserved.
//

#import "KKPTransitionFromPDToCLV.h"
#import "KKPCollectionViewController.h"
#import "KKPPhotoDetailViewController.h"
#import "KKPPhotoCell.h"

@implementation KKPTransitionFromPDToCLV

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    KKPCollectionViewController *toViewController= (KKPCollectionViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    KKPPhotoDetailViewController *fromViewController= (KKPPhotoDetailViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //截屏，截取那个我们要点击的cell
    UIView *cellImageSnapshot = [fromViewController.tableHeaderController.imageView snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:fromViewController.tableHeaderController.imageView.frame fromView:fromViewController.tableHeaderController.imageView.superview];
    
    fromViewController.tableHeaderController.imageView.hidden=YES;
    
    //得到那个我们要去的cell
    KKPPhotoCell *cell=[toViewController collectionviewCellWithIndex:fromViewController.fromIndex];
    cell.imageview.hidden=YES;
    
    // 设置开始时视图状态。（动画之初）
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    [containerView addSubview:cellImageSnapshot];
    
    
    //动画实现部分
    [UIView animateWithDuration:duration animations:^{
        //第二个页面的view慢慢显示出来.
        fromViewController.view.alpha=0;
        //相对坐标转换
        CGRect frame=[containerView convertRect:cell.imageview.frame fromView:cell.imageview.superview];
        cellImageSnapshot.frame=frame;
    } completion:^(BOOL finished) {
        //动画完成，善后工作
        fromViewController.tableHeaderController.imageView.hidden=NO;
        cell.imageview.hidden=NO;
        [cellImageSnapshot removeFromSuperview];
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
    }];
    
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
