//
//  memberDetails_ViewController.m
//  ordermenu
//
//  Created by nacldustin on 2014/11/6.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import "memberDetails_ViewController.h"
#import "DB.h"

@interface memberDetails_ViewController ()
{
    DB *myDB;
    NSMutableDictionary *userDetail;
}
@end

@implementation memberDetails_ViewController
@synthesize account;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _accountViewLAbel.enabled = NO;
    myDB = [DB sharedInstance];
    account = [myDB account];
    [self reloadDatas];
}

-(void)reloadDatas{
    NSLog(@"%@",account);
    
    
    userDetail = [NSMutableDictionary dictionaryWithDictionary:[myDB getMemberDetail]];
    _accountViewLAbel.text = account;
    _telLabel.text = [userDetail objectForKey:@"telephone"];
    _addressLabel.text = [userDetail objectForKey:@"address"];
    _emailLabel.text = [userDetail objectForKey:@"email"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)sureButton:(id)sender {
    if ([myDB resultOfUpdateUser]) {
        myDB.resultOfUpdateUser = nil;
    }
    userDetail = [NSMutableDictionary dictionaryWithCapacity:0];
    [userDetail setValue:account forKey:@"account"];
    [userDetail setValue:_telLabel.text forKey:@"telephone"];
    [userDetail setValue:_addressLabel.text forKey:@"address"];
    [userDetail setValue:_emailLabel.text forKey:@"email"];
    [myDB setMemberDetail:account details:userDetail];
    NSString *result = [myDB resultOfUpdateUser];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"會員資料" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
- (IBAction)onTouchEnd:(id)sender {
    [_accountViewLAbel resignFirstResponder];
    [_addressLabel resignFirstResponder];
    [_telLabel resignFirstResponder];
    [_emailLabel resignFirstResponder];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
