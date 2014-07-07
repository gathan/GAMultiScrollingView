//
//  GAMultiScrollingCollectionViewCell.m
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/4/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "GAMultiScrollingCollectionViewCell.h"
#import "UIScrollView+Additions.h"
#import "CGGeometryHelper.h"
#import "ScrollViewWithScrollingDirection.h"

@interface GAMultiScrollingCollectionViewCell (){

    ScrollViewWithScrollingDirection *containerScrollView;
    BOOL hasCalledHideToTop;
}

@end

@implementation GAMultiScrollingCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        containerScrollView = [[ScrollViewWithScrollingDirection alloc]initWithFrame:self.bounds];
        containerScrollView.contentSize = CGSizeMake(containerScrollView.bounds.size.width, (containerScrollView.bounds.size.height) * 2);
        containerScrollView.delegate = self;
        
        [containerScrollView setShowsHorizontalScrollIndicator:NO];
        [containerScrollView setShowsVerticalScrollIndicator:NO];
        
        hasCalledHideToTop = NO;
        
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
    [self displayItemAtDefaultPoint];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [containerScrollView directionScrollViewDidScroll:containerScrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
    BOOL isDeceleratingToHide = decelerate && containerScrollView.lastScrollDirection == ScrollDirectionDown;
    BOOL isAcceleratingToHide = !decelerate && [self isCustomViewRectAboutToHide];
    
    if (isDeceleratingToHide || isAcceleratingToHide) {
        if (!hasCalledHideToTop) {
            [self performSelector:@selector(hideToTop) withObject:nil afterDelay:0.01];
            hasCalledHideToTop = YES;
        }
    }else if (!decelerate){
        [self displayItemAtDefaultPoint];
    }else{
    
    
    
    }
}

- (void)wentToBottom{
    if (self.multiScrollingCollectionViewCellDelegate && [self.multiScrollingCollectionViewCellDelegate respondsToSelector:@selector(didEndMovingItemToBottomOfCell:)]) {
        [self.multiScrollingCollectionViewCellDelegate didEndMovingItemToBottomOfCell:self];
    }
}

- (void)hideToTop{
    hasCalledHideToTop = NO;
    BOOL shouldDelete = NO;
    if (self.multiScrollingCollectionViewCellDelegate && [self.multiScrollingCollectionViewCellDelegate respondsToSelector:@selector(shouldDeleteCell:)]) {
        shouldDelete = [self.multiScrollingCollectionViewCellDelegate shouldDeleteCell:self];
    }else{
        [self displayItemAtDefaultPoint];
    }
}

- (void)displayItemAtDefaultPoint{
    [containerScrollView scrollToTopAnimated:YES];
}

- (BOOL)isCustomViewRectAboutToHide{
    CGRect customViewRectForMultiScrollingView = [containerScrollView convertRect:self.customView.frame toView:self.superview];
    
    BOOL isCustomViewRectAboutToHide = (customViewRectForMultiScrollingView.origin.y < 0) && (-customViewRectForMultiScrollingView.origin.y > customViewRectForMultiScrollingView.size.height/2);
    
    return isCustomViewRectAboutToHide;
}

@end
