//
//  ViewController.m
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/4/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){

    __weak IBOutlet GAMultiScrollingView *multiScrollingView;
    NSMutableArray *itemsMutableArray;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self renew];
}

- (void)renew{
    [self renewAndReload:NO];
}

- (void)renewReload{
    [self renewAndReload:YES];
}

- (void)renewAndReload:(BOOL)reload{
    itemsMutableArray = [[NSMutableArray alloc]init];
    for (NSUInteger x = 0 ; x < 10 ; x++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", x%2]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [itemsMutableArray addObject:imageView];
    }
    
    if (reload) {
        [multiScrollingView reloadData];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]];
    multiScrollingView.multiScrollingViewDataSource = self;
    multiScrollingView.multiScrollingViewDelegate = self;
    [multiScrollingView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GAMultiScrollingViewDataSource

- (NSInteger)numberOfItemsInMultiScrollingView:(GAMultiScrollingView *)multiScrollingView{
    return itemsMutableArray.count;
}

#pragma mark - GAMultiScrollingViewDelegate

- (CGFloat)widthForItemInMultiScrollingView:(GAMultiScrollingView *)multiScrollingView{
    return 200;
}

- (CGFloat)widthSpacingInsetInMultiScrollingView:(GAMultiScrollingView*)multiScrollingView{
    return 35;
}

- (UIView*)multiScrollingView:(GAMultiScrollingView *)multiScrollingView viewForItemAtIndex:(NSInteger)index{
    UIImageView *imageView = [itemsMutableArray objectAtIndex:index];
    return imageView;
}

- (BOOL)multiScrollingView:(GAMultiScrollingView *)multiScrollingView shouldDeleteItemAtIndex:(NSInteger)index{
    if (index == 0 || index == 1) {
        [itemsMutableArray removeObjectAtIndex:index];
        if (itemsMutableArray.count == 0) {
            [self performSelector:@selector(renewReload) withObject:nil afterDelay:0.5];
        }
        return YES;
    }
    return NO;
}

- (UIView*)multiScrollingView:(GAMultiScrollingView *)multiScrollingView firstAppearingBottomCustomViewForItemAtIndex:(NSInteger)index{
    UIView *firstAppearingBottomCustomViewForItemAtIndex = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 40)];
    firstAppearingBottomCustomViewForItemAtIndex.backgroundColor = [UIColor colorWithRed:84/255.0f green:113/255.0f blue:89/255.0f alpha:1];
    CGFloat imageViewWidth = 40;
    CGFloat imageViewHeight = 40;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(firstAppearingBottomCustomViewForItemAtIndex.bounds.size.width/2 - imageViewWidth/2 , firstAppearingBottomCustomViewForItemAtIndex.bounds.size.height/2 - imageViewHeight/2, imageViewWidth, imageViewHeight)];
    imageView.image = [UIImage imageNamed:@"refreshIcon"];
    [firstAppearingBottomCustomViewForItemAtIndex addSubview:imageView];
    return firstAppearingBottomCustomViewForItemAtIndex;
}


- (UIView*)multiScrollingView:(GAMultiScrollingView *)multiScrollingView secondAppearingBottomCustomViewForItemAtIndex:(NSInteger)index{
    UIView *secondAppearingBottomCustomViewForItemAtIndex = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 40)];
    secondAppearingBottomCustomViewForItemAtIndex.backgroundColor = [UIColor colorWithRed:203/255.0f green:72/255.0f blue:56/255.0f alpha:1];
    CGFloat imageViewWidth = 40;
    CGFloat imageViewHeight = 40;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(secondAppearingBottomCustomViewForItemAtIndex.bounds.size.width/2 - imageViewWidth/2 , secondAppearingBottomCustomViewForItemAtIndex.bounds.size.height/2 - imageViewHeight/2, imageViewWidth, imageViewHeight)];
    imageView.image = [UIImage imageNamed:@"archiveIcon"];
    [secondAppearingBottomCustomViewForItemAtIndex addSubview:imageView];
    return secondAppearingBottomCustomViewForItemAtIndex;
}

@end
