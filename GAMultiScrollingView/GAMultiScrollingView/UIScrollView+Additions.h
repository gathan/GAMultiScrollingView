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
