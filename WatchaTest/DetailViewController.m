//
//  DetailViewController.m
//  WatchaTest
//
//  Created by noirCynical on 2015. 2. 1..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//


#import "DetailViewController.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

@synthesize title, detailImage, detailImageView, detailTitle, sliderValue, detailSlider, cell, scoreValue;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detailImageView.image= self.detailImage;
    self.detailTitle.text= self.title;
    self.detailSliderValue.text= [NSString stringWithFormat:@"%.1f", self.scoreValue];
    self.detailSlider.value= scoreValue;
}

-(IBAction)changeAccept:(id)sender{
    if([self.delegate respondsToSelector:@selector(dataFromDetail:)])
        [_delegate dataFromDetail:self.cell];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(IBAction)sliderChanged:(id)sender{
    [self.detailSliderValue setText:[NSString stringWithFormat:@"%.1f",self.detailSlider.value]];
    [self.cell.slider setValue:self.detailSlider.value];
    [self.cell.score setText:[NSString stringWithFormat:@"%.1f",self.detailSlider.value]];
}

@end
