//
//  NewMemberViewController.h
//  ordermenu
//
//  Created by Jacky Lin on 2014/11/21.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMemberViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *AccountText;
@property (weak, nonatomic) IBOutlet UITextField *TelText;
@property (weak, nonatomic) IBOutlet UITextField *AddressText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *PasswordText;
@property (strong, nonatomic)NSString *account;

@end
