//
//  GAMultiScrollingView.m
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

#import "GAMultiScrollingView.h"

@interface GAMultiScrollingView(){

    UICollectionView *myCollectionView;
    CGFloat widthForItem;
}

@end

@implementation GAMultiScrollingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib{
    if (!myCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        myCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        myCollectionView.delegate = self;
        myCollectionView.dataSource = self;
        
        [myCollectionView registerClass:[GAMultiScrollingCollectionViewCell class] forCellWithReuseIdentifier:@"MultiScrollingCollectionViewCellIdentifier"];
        
        [myCollectionView setShowsHorizontalScrollIndicator:NO];
        [myCollectionView setShowsVerticalScrollIndicator:NO];
        
        myCollectionView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:myCollectionView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(widthForItem, self.bounds.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger numberOfItems = 0;

    if (self.multiScrollingViewDataSource && [self.multiScrollingViewDataSource respondsToSelector:@selector(numberOfItemsInMultiScrollingView:)]) {
        numberOfItems = [self.multiScrollingViewDataSource numberOfItemsInMultiScrollingView:self];
    }
    
    return numberOfItems;
}

- (GAMultiScrollingCollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"MultiScrollingCollectionViewCellIdentifier";
    GAMultiScrollingCollectionViewCell *multiScrollingCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (self.multiScrollingViewDelegate && [self.multiScrollingViewDelegate respondsToSelector:@selector(multiScrollingView:viewForItemAtIndex:)]) {
        UIView *viewForItemAtIndex = [self.multiScrollingViewDelegate multiScrollingView:self viewForItemAtIndex:indexPath.row];
        [multiScrollingCollectionViewCell setCustomView:viewForItemAtIndex];
    }
    multiScrollingCollectionViewCell.multiScrollingCollectionViewCellDelegate = self;
    
    if (self.multiScrollingViewDelegate && [self.multiScrollingViewDelegate respondsToSelector:@selector(multiScrollingView:firstAppearingBottomCustomViewForItemAtIndex:)]) {
        if (self.multiScrollingViewDelegate && [self.multiScrollingViewDelegate respondsToSelector:@selector(multiScrollingView:topInsetForAppearingBottomCustomViewsForItemAtIndex:)]) {
            CGFloat topInset = [self.multiScrollingViewDelegate multiScrollingView:self topInsetForAppearingBottomCustomViewsForItemAtIndex:indexPath.row];
            multiScrollingCollectionViewCell.topInsetForAppearingBottomCustomViews = topInset;
        }
        
        UIView *firstAppearingBottomCustomView = [self.multiScrollingViewDelegate multiScrollingView:self firstAppearingBottomCustomViewForItemAtIndex:indexPath.row];
        if (firstAppearingBottomCustomView) {
            multiScrollingCollectionViewCell.firstAppearingBottomCustomView = firstAppearingBottomCustomView;
            if (self.multiScrollingViewDelegate && [self.multiScrollingViewDelegate respondsToSelector:@selector(multiScrollingView:secondAppearingBottomCustomViewForItemAtIndex:)]) {
                UIView *secondAppearingBottomCustomView = [self.multiScrollingViewDelegate multiScrollingView:self secondAppearingBottomCustomViewForItemAtIndex:indexPath.row];
                if (secondAppearingBottomCustomView) {
                    multiScrollingCollectionViewCell.secondAppearingBottomCustomView = secondAppearingBottomCustomView;
                }
            }
        }
    }
    
    return multiScrollingCollectionViewCell;
}

#pragma mark - UICollectionViewDataSource

#pragma mark - Actions

- (void)clearData{

}

- (void)reloadData{
    [myCollectionView reloadData];
}

#pragma mark - GAMultiScrollingCollectionViewCellDelegate

- (BOOL)shouldDeleteCell:(GAMultiScrollingCollectionViewCell *)cell{
    NSIndexPath *indexPath = [myCollectionView indexPathForCell:cell];
    BOOL shouldDelete = NO;
    if (self.multiScrollingViewDelegate && [self.multiScrollingViewDelegate respondsToSelector:@selector(multiScrollingView:shouldDeleteItemAtIndex:)]) {
        shouldDelete = [self.multiScrollingViewDelegate multiScrollingView:self shouldDeleteItemAtIndex:indexPath.row];
    }
    
    if (shouldDelete) {
        [myCollectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    }else{
        [cell displayItemAtDefaultPoint];
    }
    
    return shouldDelete;
}

- (void)multiScrollingCell:(GAMultiScrollingCollectionViewCell*)cell didSelectAppearingBottomCustomViewWithIndex:(NSInteger)buttonIndex;//can be one or two
{
    NSIndexPath *indexPath = [myCollectionView indexPathForCell:cell];
    if (self.multiScrollingViewDelegate && [self.multiScrollingViewDelegate respondsToSelector:@selector(multiScrollingView:didSelectAppearingBottomCustomViewWithButtonIndex:forItemAtIndex:)]) {
        [self.multiScrollingViewDelegate multiScrollingView:self didSelectAppearingBottomCustomViewWithButtonIndex:buttonIndex forItemAtIndex:indexPath.row];
    }
}

- (void)didEndMovingItemToBottomOfCell:(GAMultiScrollingCollectionViewCell *)cell{

}

#pragma mark - Custom Protocol Setters

- (void)setMultiScrollingViewDataSource:(id<GAMultiScrollingViewDataSource>)multiScrollingViewDataSource{
    _multiScrollingViewDataSource = multiScrollingViewDataSource;
}

- (void)setMultiScrollingViewDelegate:(id<GAMultiScrollingViewDelegate>)multiScrollingViewDelegate{
    _multiScrollingViewDelegate = multiScrollingViewDelegate;
    if (self.multiScrollingViewDelegate) {
        widthForItem = [self.multiScrollingViewDelegate widthForItemInMultiScrollingView:self];
        if (widthForItem <= 0) {
            NSException *exception = [[NSException alloc]initWithName:@"Negative or zero width" reason:@"Cannot give negative or zero width for item!" userInfo:nil];
            @throw exception;
        }
    }
    
    if (self.multiScrollingViewDelegate && [self.multiScrollingViewDelegate respondsToSelector:@selector(widthSpacingInsetInMultiScrollingView:)]) {
        CGFloat lineInset = [self.multiScrollingViewDelegate widthSpacingInsetInMultiScrollingView:self];
        UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)myCollectionView.collectionViewLayout;
        flowLayout.minimumLineSpacing = lineInset;
    }
}

@end