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
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    return 10;
}

#pragma mark - GAMultiScrollingViewDelegate

- (CGFloat)widthForItemInMultiScrollingView:(GAMultiScrollingView *)multiScrollingView{
    return 200;
}

- (CGFloat)widthSpacingInsetInMultiScrollingView:(GAMultiScrollingView*)multiScrollingView{
    return 35;
}

- (UIView*)multiScrollingView:(GAMultiScrollingView *)multiScrollingView viewForItemAtIndex:(NSInteger)index{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", index%3]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    return imageView;
}

@end
