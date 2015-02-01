//
//  Cell.m
//  WatchaTest
//
//  Created by noirCynical on 2015. 1. 31..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (void)drawRect:(CGRect)rect
{
    // inset by half line width to avoid cropping where line touches frame edges
    CGRect insetRect = CGRectInset(rect, 0.5, 0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:insetRect cornerRadius:5.0];
    
    // white background
    [[UIColor whiteColor] setFill];
    [path fill];
    
    // red outline
    [[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0] setStroke];
    [path stroke];
}


-(IBAction)changeScore:(id)sender{
    [self.score setText:[NSString stringWithFormat:@"%.1f",self.slider.value]];
}

@end