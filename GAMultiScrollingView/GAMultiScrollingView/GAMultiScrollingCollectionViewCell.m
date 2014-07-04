//
//  GAMultiScrollingCollectionViewCell.m
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/4/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "GAMultiScrollingCollectionViewCell.h"

@interface GAMultiScrollingCollectionViewCell (){

    UIScrollView *containerScrollView;
    
}

@end

@implementation GAMultiScrollingCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        containerScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        containerScrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height + 10);
        containerScrollView.delegate = self;
        
        [containerScrollView setShowsHorizontalScrollIndicator:NO];
        [containerScrollView setShowsVerticalScrollIndicator:NO];

        [self addSubview:containerScrollView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setCustomView:(UIView *)customView{
    [self.customView removeFromSuperview];
    _customView = customView;
    customView.center = CGPointMake(containerScrollView.bounds.size.width/2, containerScrollView.bounds.size.height/2);
    [containerScrollView addSubview:customView];
}

#pragma mark - UIScrollViewDelegate

@end
