//
//  GAMultiScrollingCollectionViewCell.h
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
