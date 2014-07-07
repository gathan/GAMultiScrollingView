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
    CGRect firstAppearingBottomCustomViewStartingRect;
    CGRect secondAppearingBottomCustomViewStartingRect;
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

- (void)setFirstAppearingBottomCustomView:(UIView *)firstAppearingBottomCustomView{
    [self.firstAppearingBottomCustomView removeFromSuperview];
    _firstAppearingBottomCustomView = firstAppearingBottomCustomView;
    firstAppearingBottomCustomView.frame = CGRectMake(0, 0, firstAppearingBottomCustomView.frame.size.width, firstAppearingBottomCustomView.frame.size.height);
    firstAppearingBottomCustomView.center = CGPointMake(self.customView.center.x, self.customView.frame.origin.y+firstAppearingBottomCustomView.frame.size.height/2 + self.topInsetForAppearingBottomCustomViews);
    firstAppearingBottomCustomViewStartingRect = firstAppearingBottomCustomView.frame;
    [containerScrollView insertSubview:firstAppearingBottomCustomView atIndex:0];
}

- (void)setSecondAppearingBottomCustomView:(UIView *)secondAppearingBottomCustomView{
    [self.secondAppearingBottomCustomView removeFromSuperview];
    _secondAppearingBottomCustomView = secondAppearingBottomCustomView;
    secondAppearingBottomCustomView.frame = CGRectMake(0, 0, secondAppearingBottomCustomView.frame.size.width, secondAppearingBottomCustomView.frame.size.height);
    secondAppearingBottomCustomView.center = CGPointMake(self.customView.center.x, self.customView.frame.origin.y+secondAppearingBottomCustomView.frame.size.height/2 + self.topInsetForAppearingBottomCustomViews);
    secondAppearingBottomCustomViewStartingRect = secondAppearingBottomCustomView.frame;
    [containerScrollView insertSubview:secondAppearingBottomCustomView aboveSubview:self.firstAppearingBottomCustomView];
}

#pragma mark - UIScrollViewDelegate

- (void)manageAppearingViews{
    CGFloat bottomOffset = containerScrollView.contentOffset.y;
    if (bottomOffset>0) {
        self.firstAppearingBottomCustomView.frame = firstAppearingBottomCustomViewStartingRect;
        self.secondAppearingBottomCustomView.frame = secondAppearingBottomCustomViewStartingRect;
    }else{
        bottomOffset = bottomOffset * (-1);
        [self setFrameToFirstForBottomOffset:bottomOffset];
        [self setFrameToSecondForBottomOffset:bottomOffset];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [containerScrollView directionScrollViewDidScroll:containerScrollView];
    [self manageAppearingViews];
}

- (void)setFrameToFirstForBottomOffset:(CGFloat)bottomOffset{
    if (bottomOffset >= self.firstAppearingBottomCustomView.bounds.size.height) {
        bottomOffset = self.firstAppearingBottomCustomView.bounds.size.height;
        self.firstAppearingBottomCustomView.frame = CGRectMake(self.firstAppearingBottomCustomView.frame.origin.x, firstAppearingBottomCustomViewStartingRect.origin.y - self.firstAppearingBottomCustomView.bounds.size.height, self.firstAppearingBottomCustomView.frame.size.width, self.firstAppearingBottomCustomView.frame.size.height);
        return;
    }
    self.firstAppearingBottomCustomView.frame = CGRectMake(self.firstAppearingBottomCustomView.frame.origin.x, firstAppearingBottomCustomViewStartingRect.origin.y-bottomOffset, self.firstAppearingBottomCustomView.frame.size.width, self.firstAppearingBottomCustomView.frame.size.height);
}

- (void)setFrameToSecondForBottomOffset:(CGFloat)bottomOffset{
    bottomOffset = bottomOffset-20;
    if (bottomOffset >= self.firstAppearingBottomCustomView.bounds.size.height + self.secondAppearingBottomCustomView.bounds.size.height) {
    self.secondAppearingBottomCustomView.frame = CGRectMake(self.secondAppearingBottomCustomView.frame.origin.x, secondAppearingBottomCustomViewStartingRect.origin.y - self.firstAppearingBottomCustomView.bounds.size.height, self.secondAppearingBottomCustomView.frame.size.width, self.secondAppearingBottomCustomView.frame.size.height);
        return;
    }
    
    self.secondAppearingBottomCustomView.frame = CGRectMake(self.secondAppearingBottomCustomView.frame.origin.x, secondAppearingBottomCustomViewStartingRect.origin.y + self.firstAppearingBottomCustomView.bounds.size.height - bottomOffset, self.secondAppearingBottomCustomView.frame.size.width, self.secondAppearingBottomCustomView.frame.size.height);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self manageAppearingViews];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self manageAppearingViews];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self manageAppearingViews];
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
        /*
        NSLog(@"content Offset start");
        [CGGeometryHelper printPoint:containerScrollView.contentOffset];
        NSLog(@"content Offset end");
         */
    }
    
    [self manageAppearingViews];
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