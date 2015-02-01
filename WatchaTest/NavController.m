//
//  NavController.m
//  WatchaTest
//
//  Created by noirCynical on 2015. 2. 1..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//

#import "NavController.h"

@interface NavController ()

@end

@implementation NavController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:150.0/255.0 alpha:1.0]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.alpha= 0.5;
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:150.0/255.0 alpha:1.0]];
}

@end

