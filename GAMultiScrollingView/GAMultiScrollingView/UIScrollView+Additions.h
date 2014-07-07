//
//  UIScrollView+Additions.h
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/7/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Additions)

- (BOOL)isAtTop;
- (BOOL)madeAFullScrollAtTopForSubview:(UIView*)subview;

- (BOOL)isAtBottom;

- (CGFloat)verticalOffsetForTop;

- (CGFloat)verticalOffsetForBottom;

- (void)scrollToBottomAnimated:(BOOL)animated;
- (void)scrollToTopAnimated:(BOOL)animated;

@end
