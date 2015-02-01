//
//  ForthViewController.m
//  WatchaTest
//
//  Created by noirCynical on 2015. 2. 1..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//

#import "ForthViewController.h"
//
//
//@interface ForthViewController : UINavigationController ()
//@end

@implementation ForthViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:150.0/255.0 alpha:1.0]}];
    self.navigationController.navigationBar.translucent = NO;
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:150.0/255.0 alpha:1.0]];
}

@end
