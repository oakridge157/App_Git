//
//  menu_mainViewController.m
//  ordermenu
//
//  Created by nacldustin on 2014/10/27.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import "menu_mainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DB.h"
#import "LoadImage.h"
static NSString * const product = @"productName";
static NSString * const price = @"price";
static NSString * const qtt = @"quentity";
@interface menu_mainViewController ()
{
    DB *myDB;
    NSMutableArray *quantity;
    NSMutableArray *shoppingCar;
    
}
@property NSMutableArray *dataArray;
@property NSMutableArray *photos;
@property NSMutableArray *descriptForPhotos;
@property (assign,nonatomic) NSInteger nCurrentIndex;
@end

@implementation menu_mainViewController

- (void)viewWillAppear:(BOOL)animated{
    
    myDB = [DB sharedInstance];
    _photos = [NSMutableArray arrayWithCapacity:0];
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    _photos = [NSMutableArray arrayWithArray:[myDB photos]];
    _dataArray = [NSMutableArray arrayWithArray:[myDB productDatas]];

    if (![myDB shoppingCar]) {
        shoppingCar = [NSMutableArray arrayWithArray:[myDB shoppingCar]];
        quantity = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0 ;i<[_photos count];i++) {
            [quantity insertObject:@"0" atIndex:i];
        }
    }else{
        quantity = [NSMutableArray arrayWithCapacity:0];
        NSLog(@"%@",[myDB shoppingCar]);
        for (int i = 0 ;i<[_photos count];i++) {
            [quantity insertObject:@"0" atIndex:i];
        }
        for (NSDictionary *products in [myDB shoppingCar]) {
            NSString *pString = [products objectForKey:@"productName"];
            for (int i=0 ; i<[_dataArray count]; i++) {
                if ([pString isEqualToString:[[_dataArray objectAtIndex:i] objectForKey:@"productName"]
                     ]) {
                    [quantity replaceObjectAtIndex:i withObject:[products objectForKey:@"quentity"]];
                }
            }
        }
    }
    [self configureView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _theScrollView.delegate = self;
#pragma mark - add Gesture
    UISwipeGestureRecognizer *rightGesture=[[UISwipeGestureRecognizer alloc] init];
    rightGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [rightGesture addTarget:self action:@selector(doRightAction)];
    [_theScrollView addGestureRecognizer:rightGesture];
    
    UISwipeGestureRecognizer *leftGesture=[[UISwipeGestureRecognizer alloc] init];
    leftGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [leftGesture addTarget:self action:@selector(doLeftAction)];
    [_theScrollView addGestureRecognizer:leftGesture];
#pragma mark -
}

- (void) doRightAction {
    // Change Photo with Aimation

    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type=kCATransitionPush;
    transition.subtype=kCATransitionFromLeft;
    _nCurrentIndex--;
    if(_nCurrentIndex<0)
        _nCurrentIndex=[_photos count]-1;
    [self configureView];
    [_showImage.layer addAnimation:transition forKey:nil];
}

- (void)configureView{

    
    if (_photos) {
        NSString *urlString = [_photos objectAtIndex:_nCurrentIndex];
        NSString *key = [urlString MD5Hash];
        NSData *data = [LoadImage objectForKey:key];
        UIImage *image = [UIImage imageWithData:data];
        [_showImage setImage:image];
    }
 
//    if (_photos) {
//        NSString *urlString = [_photos objectAtIndex:_nCurrentIndex];
//            NSURL *url = [NSURL URLWithString:urlString];
//            NSString *key = [urlString MD5Hash];
//            NSData *data = [LoadImage objectForKey:key];
//            if (data) {
//                UIImage *image = [UIImage imageWithData:data];
//                [_showImage setImage:image];
//            } else {
//                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
//                dispatch_async(queue, ^{
//                    NSData *data = [NSData dataWithContentsOfURL:url];
//                    [LoadImage setObject:data forKey:key];
//                    UIImage *image = [UIImage imageWithData:data];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [_showImage setImage:image];
//                    });
//                });
//            }
//        
//    }

    _showImage.contentMode=UIViewContentModeScaleAspectFit;
    
    _theDiscripe.contentMode=UIViewContentModeScaleAspectFit;
    _theDiscripe.text = [[_dataArray objectAtIndex:_nCurrentIndex] objectForKey:@"productName"];
#pragma mark - text Animation
    CGRect newFrame = _showText_View.frame;
    newFrame.origin.x = newFrame.origin.x + 100;
    _showText_View.frame = newFrame;
    
    [UIView transitionWithView:_theDiscripe duration:0.2
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        CGRect newFrame = _showText_View.frame;
                        newFrame.origin.x = newFrame.origin.x - 100;
                        _showText_View.frame = newFrame;
                    }
                    completion:^(BOOL finished) {
                        //
                    }];
    _quantityLabel.text = [quantity objectAtIndex:_nCurrentIndex];
#pragma mark -
}

- (void) doLeftAction {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type=kCATransitionPush;
    transition.subtype=kCATransitionFromRight;
    _nCurrentIndex++;
    if(_nCurrentIndex>=[_photos count])
        _nCurrentIndex=0;
    [self configureView];
    [_showImage.layer addAnimation:transition forKey:nil];
}

- (IBAction)minusButton:(id)sender {
    int count = [[quantity objectAtIndex:_nCurrentIndex] intValue];
    if (count > 0) {
        count--;
    }
    [quantity replaceObjectAtIndex:_nCurrentIndex withObject:[NSString stringWithFormat:@"%d", count]];
        _quantityLabel.text = [NSString stringWithFormat:@"%d", count];
}

- (IBAction)plusButton:(id)sender {
    if ([quantity objectAtIndex:_nCurrentIndex] >= 0) {
        int count = [[quantity objectAtIndex:_nCurrentIndex] intValue];
        count++;
        [quantity replaceObjectAtIndex:_nCurrentIndex withObject:[NSString stringWithFormat:@"%d", count]];

        _quantityLabel.text = [NSString stringWithFormat:@"%d", count];
    }
}

- (IBAction)addToCarButton:(id)sender {
    shoppingCar = [NSMutableArray arrayWithCapacity:0];
    int i = 0;
    for (NSMutableDictionary *dict in _dataArray) {
        
        NSMutableDictionary *carTemp = [NSMutableDictionary dictionaryWithDictionary:dict];
        
        NSInteger count = [[quantity objectAtIndex:i] intValue];
        if (count != 0) {
            [carTemp setObject:[quantity objectAtIndex:i] forKey:qtt];
            [shoppingCar addObject:carTemp];
        }
        i++;
    }
}

- (IBAction)goToCarButton:(id)sender{
    myDB.shoppingCar = [NSMutableArray arrayWithArray:shoppingCar];
}


@end
