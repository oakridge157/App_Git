//
//  menu_mainViewController.h
//  ordermenu
//
//  Created by nacldustin on 2014/10/27.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+MD5.h"

@interface menu_mainViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *showImage;
@property (weak, nonatomic) IBOutlet UILabel *theDiscripe;
@property (weak, nonatomic) IBOutlet UIScrollView *theScrollView;

@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIView *showText_View;
@property (weak, nonatomic) IBOutlet UIButton *addToCarButton;

- (IBAction)minusButton:(id)sender;
- (IBAction)plusButton:(id)sender;
- (IBAction)addToCarButton:(id)sender;
- (IBAction)goToCarButton:(id)sender;

@end
