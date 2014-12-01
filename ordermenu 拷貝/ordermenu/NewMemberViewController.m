//
//  NewMemberViewController.m
//  ordermenu
//
//  Created by Jacky Lin on 2014/11/21.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import "NewMemberViewController.h"
#import "DB.h"
@interface NewMemberViewController ()
{
    DB *myDB;
    NSMutableDictionary *userDetail;
    NSMutableDictionary *user;
}
@end

@implementation NewMemberViewController
@synthesize account;
- (void)viewDidLoad {
    [super viewDidLoad];
    myDB = [DB sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)AddNewMemberAction:(id)sender {
    user =[NSMutableDictionary dictionaryWithCapacity:0];
    userDetail = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *accountString =_AccountText.text;
    NSString *psdString =_PasswordText.text;
    NSString *addressString =_AddressText.text;
    NSString *telString =_TelText.text;
    NSString *emailString =_emailText.text;
    bool cango = YES;
    if ([accountString isEqualToString:@""]) {
        _AccountText.placeholder = @"請輸入帳號   *";
//        cango = NO;
    }
    if ([psdString isEqualToString:@""]) {
        _PasswordText.placeholder = @"請輸入密碼   *";
//        cango = NO;
    }
    if ([addressString isEqualToString:@""]) {
        _AddressText.placeholder = @"請輸入地址   *";
//        cango = NO;
    }
    if ([telString isEqualToString:@""]) {
        _TelText.placeholder = @"請輸入電話   *";
//        cango = NO;
    }
    if ([emailString isEqualToString:@""]) {
        _emailText.placeholder = @"請輸入E-mail   *";
//            cango = NO;
    }
    if (cango) {
        [user setValue:_AccountText.text forKey:@"account"];
        [user setValue:_PasswordText.text forKey:@"password"];
        
        [userDetail setValue:_TelText.text forKey:@"telephone"];
        [userDetail setValue:_AddressText.text forKey:@"address"];
        [userDetail setValue:_emailText.text forKey:@"email"];
        [myDB setMemberDetail:account details:userDetail];
        
        [myDB Regist:user details:userDetail];
        if ([[myDB resultOfRegist] isEqualToString:@"success"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Regist" message:@"Regist Success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}
- (IBAction)onTouchEnd:(id)sender {
    [_AccountText resignFirstResponder];
    [_PasswordText resignFirstResponder];
    [_TelText resignFirstResponder];
    [_emailText resignFirstResponder];
    [_AddressText resignFirstResponder];
    
}

/*j
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
