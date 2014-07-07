//
//  ScrollViewWithScrollingDirection.h
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/7/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ScrollDirection {
    ScrollDirectionNone,
    ScrollDirectionRight,
    ScrollDirectionLeft,
    ScrollDirectionUp,
    ScrollDirectionDown,
    ScrollDirectionCrazy,
} ScrollDirection;

@interface ScrollViewWithScrollingDirection : UIScrollView

+ (void)printScrollDirection:(ScrollDirection)scrollDirection;

- (void)directionScrollViewDidScroll:(UIScrollView *)sender;

@property (nonatomic) ScrollDirection lastScrollDirection;

@end
