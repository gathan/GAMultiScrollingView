//
//  GAMultiScrollingView.m
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/4/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "GAMultiScrollingView.h"
#import "GAMultiScrollingCollectionViewCell.h"

@interface GAMultiScrollingView (){

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
    
    return multiScrollingCollectionViewCell;
}

#pragma mark - UICollectionViewDataSource

#pragma mark - Actions

- (void)clearData{

}

- (void)reloadData{
    [myCollectionView reloadData];
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
