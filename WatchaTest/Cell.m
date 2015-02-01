//
//  Cell.m
//  WatchaTest
//
//  Created by noirCynical on 2015. 1. 31..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//

#import "Cell.h"

@implementation Cell

-(IBAction)changeScore:(id)sender{
    [self.score setText:[NSString stringWithFormat:@"%.1f",self.slider.value]];
}

@end