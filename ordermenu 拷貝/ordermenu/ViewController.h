//
//  ViewController.h
//  ordermenu
//
//  Created by nacldustin on 2014/10/27.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+MD5.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *memberButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *storeButton;

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UISlider *slideShowTimeIntervalSlider;
@property (weak, nonatomic) IBOutlet UIImageView *showNewProduct;
@property (strong,nonatomic) NSTimer *timerForChangePhotos;
@property (assign,nonatomic) CFTimeInterval slideShowTimeInterval;
@property (assign,nonatomic) NSInteger nCurrentIndex;
@property (assign,nonatomic) CFTimeInterval lastPhotoUpdateTime;
@property NSMutableArray* photos;
@end

