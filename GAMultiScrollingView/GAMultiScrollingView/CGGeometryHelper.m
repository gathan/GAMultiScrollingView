//
//  CGGeometryHelper.m
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/7/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import "CGGeometryHelper.h"

@implementation CGGeometryHelper

+ (void)printRect:(CGRect)rect{
    [CGGeometryHelper printRect:rect withDescription:nil];
}

+ (void)printRect:(CGRect)rect withDescription:(NSString*)description{
    NSLog(@"\n\n");
    if (description) {
        NSLog([NSString stringWithFormat:@"Start of printing a rect named: %@", description]);
    }else{
        NSLog(@"Start of printing a rect");
    }

    NSLog([NSString stringWithFormat:@"rect.x      = %f", rect.origin.x]);
    NSLog([NSString stringWithFormat:@"rect.y      = %f", rect.origin.y]);
    NSLog([NSString stringWithFormat:@"rect.width  = %f", rect.size.width]);
    NSLog([NSString stringWithFormat:@"rect.height = %f", rect.size.height]);
    
    if (description) {
        NSLog([NSString stringWithFormat:@"End of printing a rect named: %@\n", description]);
    }else{
        NSLog(@"End of printing a rect\n");
    }
    NSLog(@"\n");
}

+ (void)printPoint:(CGPoint)point{
    NSLog(@"\n");
    NSLog(@"\nStart of printing a point");
    NSLog([NSString stringWithFormat:@"point.x      = %f", point.x]);
    NSLog([NSString stringWithFormat:@"point.y      = %f", point.y]);
    NSLog(@"End of printing a point\n");
    NSLog(@"\n");
}

@end