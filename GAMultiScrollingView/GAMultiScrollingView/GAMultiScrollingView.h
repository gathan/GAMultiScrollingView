//
//  GAMultiScrollingView.h
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/4/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GAMultiScrollingView;

@protocol GAMultiScrollingViewDelegate<NSObject, UIScrollViewDelegate>

@required
- (CGFloat)widthForItemInMultiScrollingView:(GAMultiScrollingView*)multiScrollingView;

@optional
- (CGFloat)widthSpacingInsetInMultiScrollingView:(GAMultiScrollingView*)multiScrollingView;
- (UIView*)multiScrollingView:(GAMultiScrollingView*)multiScrollingView viewForItemAtIndex:(NSInteger)index;

@end

@protocol GAMultiScrollingViewDataSource<NSObject>

@optional

- (NSInteger)numberOfItemsInMultiScrollingView:(GAMultiScrollingView *)multiScrollingView;

@end


@interface GAMultiScrollingView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)   id <GAMultiScrollingViewDataSource> multiScrollingViewDataSource;
@property(nonatomic, strong)   id <GAMultiScrollingViewDelegate>   multiScrollingViewDelegate;

- (void)clearData;
- (void)reloadData;

@end
