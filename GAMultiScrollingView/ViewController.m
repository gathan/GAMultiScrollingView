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
    itemsMutableArray = [[NSMutableArray alloc]init];
    for (NSUInteger x = 0 ; x < 10 ; x++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", x%3]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [itemsMutableArray addObject:imageView];
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
        return YES;
    }
    return NO;
}

@end
