//
//  GAMultiScrollingCollectionViewCell.h
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/4/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAMultiScrollingCollectionViewCell : UICollectionViewCell <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *customView;

@end
