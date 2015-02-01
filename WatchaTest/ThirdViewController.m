//
//  ThirdViewController.m
//  WatchaTest
//
//  Created by noirCynical on 2015. 1. 31..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//

#import "ThirdViewController.h"
#import "DetailViewcontroller.h"
#import "Cell.h"

@interface ThirdViewController () <DetailViewControllerDelegate> {
    NSMutableArray *viewItemImages, *viewItemTitles;
    
    Cell *selected;
}
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    static int index= -1;
    // Do any additional setup after loading the view, typically from a nib.
//    CGSize scSize= [UIScreen mainScreen].bounds.size;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:150.0/255.0 alpha:1.0]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor= [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    
    UIImage *buttonImage = [UIImage imageNamed:@"icon_filter"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:buttonImage forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barButton;
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:150.0/255.0 alpha:1.0]];
    
    viewItemImages= [[NSMutableArray alloc] initWithCapacity:15];
    viewItemTitles= [[NSMutableArray alloc] initWithCapacity:15];
    
    NSError *error= nil;
    NSString *file= [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"json"];
    NSData *data= [NSData dataWithContentsOfFile:file];
    NSDictionary *json= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if(error != nil)
        NSLog(@"json parsing error");
    else{
        NSArray *banner= json[@"cards"];
        if(index == -1){
            index= arc4random()%(banner.count/2);
            if(index == 4) index++;
        }
        
        int count= 0;
        for (NSDictionary *item in banner){
            NSDictionary *temp;
            if(count == index*2 && item[@"movie"] != nil){
                temp= [item objectForKey:@"movie"];
                NSLog(@"movie title: %@", temp[@"title"]);
                if([temp[@"stillcut"] rangeOfString:@"assets"].location == NSNotFound){
                    NSURL *url= [NSURL URLWithString:temp[@"stillcut"]];
                    NSData *stillcut= [NSData dataWithContentsOfURL:url];
                    UIImage *img=[[UIImage alloc] initWithData:stillcut];
                    [viewItemImages addObject:img];
                    [viewItemTitles addObject:[temp[@"title"] copy]];
                }
            }
            else if(count == (index*2+1) && item[@"movies"] != nil){
                NSArray *movies= [item objectForKey:@"movies"];
                NSLog(@"type is %@", item[@"type"]);
                for(NSDictionary *inItems in movies){
                    NSLog(@"movies item name : %@", inItems[@"title"]);
                    NSString *str;
                    if(arc4random()%2 == 0)
                        str= [inItems[@"poster"] copy];
                    else
                        str= [inItems[@"stillcut"] copy];

                    if([str rangeOfString:@"d12n550ohk75u3"].location != NSNotFound){
                        NSURL *url= [NSURL URLWithString:str];
                        NSData *stillcut= [NSData dataWithContentsOfURL:url];
                        UIImage *img=[[UIImage alloc] initWithData:stillcut];
                        [viewItemImages addObject:img];
                        [viewItemTitles addObject:[inItems[@"title"] copy]];
                    }
                }
            }
            count++;
        }
    }
    
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
//    CGSize scSize= [UIScreen mainScreen].bounds.size;
    int width= size.width-20;
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, width, width*(image.size.width/image.size.height))];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return viewItemImages.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Cell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.imgView setImage:viewItemImages[indexPath.row]];
    [cell.title setText:viewItemTitles[indexPath.row]];
    [cell.score setText:[NSString stringWithFormat:@"%.1f",cell.slider.value]];
    cell.indexPath= indexPath;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"segue identifier : %@", segue.identifier);
    if([segue.identifier isEqualToString:@"viewDetail"]){
        NSIndexPath *indexPath= [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        Cell *cell= [self.collectionView cellForItemAtIndexPath:indexPath];
        DetailViewController *destViewController= (DetailViewController *)segue.destinationViewController;
        destViewController.detailImage= cell.imgView.image;
        destViewController.title= cell.title.text;
        destViewController.sliderValue= [NSString stringWithFormat:@"%.1f", cell.slider.value];
        destViewController.scoreValue= cell.slider.value;
        destViewController.cell= cell;
        destViewController.delegate= self;
    }
}

-(void)dataFromDetail:(Cell *)data{
    Cell *cell= [self.collectionView cellForItemAtIndexPath:data.indexPath];
    [cell.score setText:[NSString stringWithFormat:@"%.1f",data.slider.value]];
    [cell.slider setValue:data.slider.value];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    selected= [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 3.0f;
}

-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.layer.borderColor = nil;
    cell.layer.borderWidth = 0.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
