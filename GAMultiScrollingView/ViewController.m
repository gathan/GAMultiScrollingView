//
//  ViewController.m
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

- (BOOL)multiScrollingView:(GAMultiScrollingView *)multiScrollingView shouldSelectItemAtIndex:(NSInteger)index{
    if (index != 0 && index != 1) {
        UIAlertView *cannotSelectAlert = [[UIAlertView alloc]initWithTitle:@"Cannot Select" message:@"For this example you can only selecte indexes:0,1" delegate:Nil cancelButtonTitle:@"Nice, thanks" otherButtonTitles:nil, nil];
        [cannotSelectAlert show];
        return NO;
    }
    return YES;
}

- (void)multiScrollingView:(GAMultiScrollingView *)multiScrollingView didSelectItemAtIndex:(NSInteger)index{
    UIAlertView *selectionAlert = [[UIAlertView alloc]initWithTitle:@"selected" message:[NSString stringWithFormat:@"%d",index] delegate:Nil cancelButtonTitle:@"nice" otherButtonTitles:nil, nil];
    [selectionAlert show];
}

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
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Example" message:@"For this example you are allowed to delete only items at indexes: 0,1" delegate:nil cancelButtonTitle:@"Thanks!" otherButtonTitles:nil, nil];
    [alertView show];
    return NO;
}

- (CGFloat)multiScrollingView:(GAMultiScrollingView*)multiScrollingView topInsetForDragToTopCustomViewsForItemAtIndex:(NSInteger)index{
    return 4;
}

- (UIView*)multiScrollingView:(GAMultiScrollingView*)multiScrollingView dragToTopCustomViewForItemAtIndex:(NSInteger)index{
    UIView *dragToTopCustomViewForItemAtIndex = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    dragToTopCustomViewForItemAtIndex.backgroundColor = [UIColor colorWithRed:203/255.0f green:72/255.0f blue:56/255.0f alpha:1];
    CGFloat imageViewWidth = 40;
    CGFloat imageViewHeight = 40;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(dragToTopCustomViewForItemAtIndex.bounds.size.width/2 - imageViewWidth/2 , dragToTopCustomViewForItemAtIndex.bounds.size.height/2 - imageViewHeight/2, imageViewWidth, imageViewHeight)];
    imageView.image = [UIImage imageNamed:@"deleteIcon"];
    [dragToTopCustomViewForItemAtIndex addSubview:imageView];
    return dragToTopCustomViewForItemAtIndex;
}

- (CGFloat)multiScrollingView:(GAMultiScrollingView *)multiScrollingView topInsetForAppearingBottomCustomViewsForItemAtIndex:(NSInteger)index{
    return 3;
}

- (UIView*)multiScrollingView:(GAMultiScrollingView *)multiScrollingView firstAppearingBottomCustomViewForItemAtIndex:(NSInteger)index{
    UIView *firstAppearingBottomCustomViewForItemAtIndex = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    firstAppearingBottomCustomViewForItemAtIndex.backgroundColor = [UIColor colorWithRed:84/255.0f green:113/255.0f blue:89/255.0f alpha:1];
    CGFloat imageViewWidth = 40;
    CGFloat imageViewHeight = 40;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(firstAppearingBottomCustomViewForItemAtIndex.bounds.size.width/2 - imageViewWidth/2 , firstAppearingBottomCustomViewForItemAtIndex.bounds.size.height/2 - imageViewHeight/2, imageViewWidth, imageViewHeight)];
    imageView.image = [UIImage imageNamed:@"refreshIcon"];
    [firstAppearingBottomCustomViewForItemAtIndex addSubview:imageView];
    return firstAppearingBottomCustomViewForItemAtIndex;
}


- (UIView*)multiScrollingView:(GAMultiScrollingView *)multiScrollingView secondAppearingBottomCustomViewForItemAtIndex:(NSInteger)index{
    UIView *secondAppearingBottomCustomViewForItemAtIndex = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    secondAppearingBottomCustomViewForItemAtIndex.backgroundColor = [UIColor colorWithRed:203/255.0f green:72/255.0f blue:56/255.0f alpha:1];
    CGFloat imageViewWidth = 40;
    CGFloat imageViewHeight = 40;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(secondAppearingBottomCustomViewForItemAtIndex.bounds.size.width/2 - imageViewWidth/2 , secondAppearingBottomCustomViewForItemAtIndex.bounds.size.height/2 - imageViewHeight/2, imageViewWidth, imageViewHeight)];
    imageView.image = [UIImage imageNamed:@"archiveIcon"];
    [secondAppearingBottomCustomViewForItemAtIndex addSubview:imageView];
    return secondAppearingBottomCustomViewForItemAtIndex;
}

- (void)multiScrollingView:(GAMultiScrollingView*)multiScrollingView didSelectAppearingBottomCustomViewWithButtonIndex:(NSInteger)buttonIndex forItemAtIndex:(NSInteger)itemIndex{
    NSString *whichAppeared;
    if (buttonIndex == 1) {
        whichAppeared = @"First to appear";
    }else{
        whichAppeared = @"Second to appear";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Custom View Selection" message:[NSString stringWithFormat:@"User Selected the %@ button", whichAppeared] delegate:nil cancelButtonTitle:@"Nice!" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
