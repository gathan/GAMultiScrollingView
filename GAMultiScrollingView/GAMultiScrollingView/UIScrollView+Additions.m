//
//  UIScrollView+Additions.m
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/7/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "UIScrollView+Additions.h"

@implementation UIScrollView (Additions)

- (BOOL)isAtTop {
    BOOL isAtTop = (self.contentOffset.y >= [self verticalOffsetForBottom]);
    return isAtTop;
}

- (BOOL)madeAFullScrollAtTopForSubview:(UIView*)subview{
    BOOL madeAFullScrollAtTop = (self.contentOffset.y + subview.frame.size.height/3 <= [self verticalOffsetForTop] + subview.frame.size.height/3 + 1);
    return madeAFullScrollAtTop;
}

- (BOOL)isAtBottom {
    BOOL isAtBottom = (self.contentOffset.y <= [self verticalOffsetForTop]);
    return isAtBottom;
}

- (CGFloat)verticalOffsetForTop {
    CGFloat topInset = self.contentInset.top;
    return -topInset;
}

- (CGFloat)verticalOffsetForBottom {
    CGFloat scrollViewHeight = self.bounds.size.height;
    CGFloat scrollContentSizeHeight = self.contentSize.height;
    CGFloat bottomInset = self.contentInset.bottom;
    CGFloat scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight;
    return scrollViewBottomOffset;
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    [self scrollRectToVisible:CGRectMake(0, self.contentSize.width, self.contentSize.width +1, self.contentSize.height +1) animated:YES];
}

- (void)scrollToTopAnimated:(BOOL)animated
{
     [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:animated];
}

@end