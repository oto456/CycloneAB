//
//  collectionViewcell.m
//  CycloneAB
//
//  Created by edward_ng on 14-10-15.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import "collectionViewcell.h"

@implementation collectionViewcell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
     }
    return self;
}

- (void)update
{
   _badge=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
   [_badge setImage:[UIImage imageNamed:@"badge"]];
    [self.image addSubview:_badge];
}

-(void)haveCheck
{
    [_badge removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
