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
