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

@optional
- (CGFloat)multiScrollingView:(GAMultiScrollingView*)multiScrollingView heightForSection:(NSInteger)section;
@end

@protocol GAMultiScrollingViewDataSource<NSObject>

@optional

- (NSInteger)numberOfItemsInMultiScrollingView:(GAMultiScrollingView *)multiScrollingView;

@end


@interface GAMultiScrollingView : UIView

@property(nonatomic, strong)   id <GAMultiScrollingViewDataSource> multiScrollingViewSource;
@property(nonatomic, strong)   id <GAMultiScrollingViewDelegate>   multiScrollingViewDelegate;

- (void)clearData;
- (void)reloadData;

@end
