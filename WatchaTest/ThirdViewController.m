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
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:150.0/255.0 alpha:1.0]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor= [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    
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
        if(index == -1)
            index= arc4random()%(banner.count/2);
        
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

-(UIImage*)resizeKeepRatio:(UIImage*)image{
    CGSize size= CGSizeMake(127, 157);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage*)resizeImageWithImage:(UIImage*)image toSize:(CGSize)newSize
{
    CGSize size= CGSizeMake(newSize.width-20, newSize.height);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.width*(image.size.width/image.size.height))];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return viewItemImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Cell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.imgView setImage:viewItemImages[indexPath.row]];
    cell.imgView.layer.cornerRadius= 10.0f;
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
