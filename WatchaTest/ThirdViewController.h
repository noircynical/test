//
//  ThirdViewController.h
//  WatchaTest
//
//  Created by noirCynical on 2015. 1. 31..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *score;
@end
