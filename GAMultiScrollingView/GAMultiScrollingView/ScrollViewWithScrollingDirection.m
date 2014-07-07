//
//  ScrollViewWithScrollingDirection.m
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/7/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "ScrollViewWithScrollingDirection.h"

@interface ScrollViewWithScrollingDirection ()

@property (nonatomic, assign) CGFloat lastContentOffsetX;
@property (nonatomic, assign) CGFloat lastContentOffsetY;

@end

@implementation ScrollViewWithScrollingDirection

+ (void)printScrollDirection:(ScrollDirection)scrollDirection{
    if (scrollDirection == ScrollDirectionNone) {
        NSLog(@"ScrollDirection = ScrollDirectionNone");
    }else if (scrollDirection == ScrollDirectionRight) {
        NSLog(@"ScrollDirection = ScrollDirectionRight");
    }else if (scrollDirection == ScrollDirectionLeft) {
        NSLog(@"ScrollDirection = ScrollDirectionLeft");
    }else if (scrollDirection == ScrollDirectionUp) {
        NSLog(@"ScrollDirection = ScrollDirectionUp");
    }else if (scrollDirection == ScrollDirectionDown) {
        NSLog(@"ScrollDirection = ScrollDirectionDown");
    }else if (scrollDirection == ScrollDirectionCrazy) {
        NSLog(@"ScrollDirection = ScrollDirectionCrazy");
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

//
- (void)directionScrollViewDidScroll:(UIScrollView *)sender
{
    if (self.lastContentOffsetX > self.contentOffset.x){
        self.lastScrollDirection = ScrollDirectionRight;
        self.lastContentOffsetX = self.contentOffset.x;
    }else if (self.lastContentOffsetX < self.contentOffset.x){
        self.lastScrollDirection = ScrollDirectionLeft;
        self.lastContentOffsetX = self.contentOffset.x;
    }else if (self.lastContentOffsetY > self.contentOffset.y){
        self.lastScrollDirection = ScrollDirectionUp;
        self.lastContentOffsetY = self.contentOffset.y;
    }else if (self.lastContentOffsetY < self.contentOffset.y){
        self.lastScrollDirection = ScrollDirectionDown;
        self.lastContentOffsetY = self.contentOffset.y;
    }
//    [ScrollViewWithScrollingDirection printScrollDirection:self.lastScrollDirection];
}

@end
