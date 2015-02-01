//
//  DetailViewController.h
//  WatchaTest
//
//  Created by noirCynical on 2015. 2. 1..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"

@protocol DetailViewControllerDelegate <NSObject>

@required
-(void)dataFromDetail:(Cell *)cell;

@end

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailSliderValue;
@property (weak, nonatomic) IBOutlet UISlider *detailSlider;

@property (weak, nonatomic) UIImage *detailImage;
@property (weak, nonatomic) NSString *title;
@property (weak, nonatomic) NSString *sliderValue;
@property float scoreValue;
@property (weak, nonatomic) Cell* cell;

@property (weak, nonatomic) id<DetailViewControllerDelegate> delegate;

-(IBAction)changeAccept:(id)sender;
-(IBAction)sliderChanged:(id)sender;

@end