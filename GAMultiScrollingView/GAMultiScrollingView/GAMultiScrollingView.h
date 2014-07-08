//
//  GAMultiScrollingView.h
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/4/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//
//Copyright (c) <2014> <Georgios Z. Athanasopoulos g.athanasopoulos.it@gmail.com>.
//All rights reserved.
//
//Redistribution and use in source and binary forms are permitted
//provided that the above copyright notice and this paragraph are
//duplicated in all such forms and that any documentation,
//advertising materials, and other materials related to such
//distribution and use acknowledge that the software was developed
//by Georgios Z. Athanasopoulos. The name of the
//Georgios Z. Athanasopoulos may not be used to endorse or promote products derived
//from this software without specific prior written permission.
//THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
//IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
//WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

#import <UIKit/UIKit.h>
#import "GAMultiScrollingCollectionViewCell.h"

@class GAMultiScrollingView;

@protocol GAMultiScrollingViewDelegate<NSObject, UIScrollViewDelegate>

@required
- (CGFloat)widthForItemInMultiScrollingView:(GAMultiScrollingView*)multiScrollingView;

@optional
- (CGFloat)widthSpacingInsetInMultiScrollingView:(GAMultiScrollingView*)multiScrollingView;
- (UIView*)multiScrollingView:(GAMultiScrollingView*)multiScrollingView viewForItemAtIndex:(NSInteger)index;
- (UIView*)multiScrollingView:(GAMultiScrollingView*)multiScrollingView firstAppearingBottomCustomViewForItemAtIndex:(NSInteger)index;
- (CGFloat)multiScrollingView:(GAMultiScrollingView*)multiScrollingView topInsetForAppearingBottomCustomViewsForItemAtIndex:(NSInteger)index;

- (UIView*)multiScrollingView:(GAMultiScrollingView*)multiScrollingView secondAppearingBottomCustomViewForItemAtIndex:(NSInteger)index;
- (BOOL)multiScrollingView:(GAMultiScrollingView*)multiScrollingView shouldDeleteItemAtIndex:(NSInteger)index;
- (void)multiScrollingView:(GAMultiScrollingView*)multiScrollingView didSelectAppearingBottomCustomViewWithButtonIndex:(NSInteger)buttonIndex forItemAtIndex:(NSInteger)itemIndex;

@end

@protocol GAMultiScrollingViewDataSource<NSObject>

@optional

- (NSInteger)numberOfItemsInMultiScrollingView:(GAMultiScrollingView *)multiScrollingView;

@end


@interface GAMultiScrollingView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GAMultiScrollingCollectionViewCellDelegate>

@property(nonatomic, strong)   id <GAMultiScrollingViewDataSource> multiScrollingViewDataSource;
@property(nonatomic, strong)   id <GAMultiScrollingViewDelegate>   multiScrollingViewDelegate;

- (void)clearData;
- (void)reloadData;
- (CGSize)contentSize;

@end
