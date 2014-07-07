//
//  CGGeometryHelper.h
//  GAMultiScrollingView
//
//  Created by gathanasopoulos on 7/7/14.
//  Copyright (c) 2014 g.athanasopoulos.it@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGGeometryHelper : NSObject

+ (void)printRect:(CGRect)rect;
+ (void)printRect:(CGRect)rect withDescription:(NSString*)description;

+ (void)printPoint:(CGPoint)point;

@end
