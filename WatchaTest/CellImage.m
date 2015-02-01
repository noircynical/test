//
//  CellImage.m
//  WatchaTest
//
//  Created by noirCynical on 2015. 1. 31..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//

#import "CellImage.h"

@implementation CellImage

-(void)drawRect:(CGRect)rect{
    CGContextRef aRef= UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezier= [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0];
    [bezier setLineWidth:5.0];
    [[UIColor blackColor] setStroke];
    
    UIColor *fill= [UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:150.0/255.0 alpha:1.0];
    [fill setFill];
    
    [bezier stroke];
    [bezier fill];
    CGContextSaveGState(aRef);
}

@end