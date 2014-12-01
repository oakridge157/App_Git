//
//  memberDetails_ViewController.h
//  ordermenu
//
//  Created by nacldustin on 2014/11/6.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface memberDetails_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *accountViewLAbel;
@property (weak, nonatomic) IBOutlet UITextField *telLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (strong, nonatomic)NSString *account;
@end
