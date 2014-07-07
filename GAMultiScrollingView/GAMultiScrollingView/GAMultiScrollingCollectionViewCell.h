//
//  GAMultiScrollingCollectionViewCell.h
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/4/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GAMultiScrollingCollectionViewCell;

@protocol GAMultiScrollingCollectionViewCellDelegate <NSObject>

- (BOOL)shouldDeleteCell:(GAMultiScrollingCollectionViewCell*)cell;
- (void)didEndMovingItemToBottomOfCell:(GAMultiScrollingCollectionViewCell*)cell;
- (void)multiScrollingCell:(GAMultiScrollingCollectionViewCell*)cell didSelectAppearingBottomCustomViewWithIndex:(NSInteger)buttonIndex;//can be one or two

@end

@interface GAMultiScrollingCollectionViewCell : UICollectionViewCell <UIScrollViewDelegate>

- (void)displayItemAtDefaultPoint;

@property(nonatomic, strong) id <GAMultiScrollingCollectionViewCellDelegate> multiScrollingCollectionViewCellDelegate;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic)         CGFloat topInsetForAppearingBottomCustomViews;
@property (nonatomic, strong) UIView *firstAppearingBottomCustomView;
@property (nonatomic, strong) UIView *secondAppearingBottomCustomView;

@end
