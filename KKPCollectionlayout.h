//
//  KKPCollectionlayout.h
//  KKPcollectionLayout
//
//  Created by 刘特风 on 15/3/2.
//  Copyright (c) 2015年 kakapo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class KKPCollectionlayout;

@protocol KKPViewLayoutDelegate <NSObject>
@required
- (CGFloat) collectionView:(UICollectionView*) collectionView
                    layout:(KKPCollectionlayout*) layout
  heightForItemAtIndexPath:(NSIndexPath*) indexPath;
@end


@interface KKPCollectionlayout : UICollectionViewLayout

@property (weak, nonatomic) IBOutlet id<KKPViewLayoutDelegate> delegate;
@property (nonatomic, assign) NSUInteger numberOfColumns;
@property (nonatomic, assign) CGFloat interItemSpacing;


//以下是override的
//在集合视图开始布局前被调用,计算要放在这里面。
-(void)prepareLayout;
//当集合视图滚动时，系统会调用这个方法并传递可见的矩形区域。
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect;
//
-(CGSize)collectionViewContentSize;

@end
