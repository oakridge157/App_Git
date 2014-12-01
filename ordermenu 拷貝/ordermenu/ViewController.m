//
//  ViewController.m
//  ordermenu
//
//  Created by nacldustin on 2014/10/27.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import "ViewController.h"
#import "DB.h"
#import "LoadImage.h"
#import "memberDetails_ViewController.h"
#import "Record_TableViewController.h"

@interface ViewController (){
    DB *myDB;
    UIAlertView *alert;
    UITextField *userTextFiled;
    UITextField *passwordTextField;
    NSString *segueID;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    UIImageView *background=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order.png"]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    background.frame=self.view.bounds;
     */
    // Do any additional setup after loading the view, typically from a nib.
    myDB = [DB sharedInstance];
    
    _photos = [NSMutableArray arrayWithCapacity:0];
    NSString *netStatus = [myDB getProductsInfo];

    if ([netStatus isEqualToString:@""]) {
        if ([myDB photos]) {
            _photos = [NSMutableArray arrayWithArray:[myDB photos
                                                      ]];
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
            dispatch_async(queue, ^{
                
                for (NSString *urlString in _photos) {
                        NSURL *url = [NSURL URLWithString:urlString];
                        NSString *key = [urlString MD5Hash];
                        NSData *data = [LoadImage objectForKey:key];
                        if (!data) {
                            data = [NSData dataWithContentsOfURL:url];
                            [LoadImage setObject:data forKey:key];
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *urlString = [_photos objectAtIndex:0];
                        NSString *key = [urlString MD5Hash];
                        NSData * imgData = [LoadImage objectForKey:key];
                        UIImage *img = [UIImage imageWithData:imgData];
                        [self.showNewProduct setImage:img];
                        _timerForChangePhotos = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                                                 target: self
                                                                               selector: @selector(handleTimer:)
                                                                               userInfo: nil
                                                                                repeats: YES];
                        _slideShowTimeInterval=1.0;
                        [_slideShowTimeIntervalSlider setHidden:YES];
                    });
                });
    
            }else{
               [self showAlertWithTitle:@"連線有誤" message:@"請確認網路狀態" delegate:nil alertViewStyle:UIAlertViewStyleDefault];
            }
    }
 
}
- (IBAction)checkLogined:(UIButton*)sender {
 
    switch (sender.tag) {
        case 1:
            segueID = @"goToMemberDetail";
            break;
        case 2:
            segueID = @"goToRecord";
            break;
        default:
            break;
    }

    if (![myDB account]) {
        alert =[[UIAlertView alloc] initWithTitle:@"登入" message:@"" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok",@"註冊" ,nil];
        alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        userTextFiled= [alert textFieldAtIndex:0];
        passwordTextField= [alert textFieldAtIndex:1];
        [alert show];
    }else{
        [self performSegueWithIdentifier:segueID sender:nil];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString* loginResult;
    NSDictionary *account;
    NSString *netStatus;
    switch (buttonIndex) {
        case 0:
            if (myDB.account) {
                [self performSegueWithIdentifier:segueID sender:nil];
            }
            break;
        case 1:
            account = [NSDictionary dictionaryWithObjectsAndKeys:userTextFiled.text,@"account",passwordTextField.text,@"password", nil];
            netStatus = [myDB login:account];
            if ([netStatus isEqualToString:@""]) {
                loginResult = myDB.resultOfLogin;
                if ([loginResult isEqualToString:@"登入成功\t"]) {
                    myDB.account = userTextFiled.text;
                    [self showAlertWithTitle:@"登入" message:loginResult delegate:self alertViewStyle:UIAlertViewStyleDefault];
                }else {
                    alert =[[UIAlertView alloc] initWithTitle:@"登入" message:@"" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
                    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
                    userTextFiled= [alert textFieldAtIndex:0];
                    passwordTextField= [alert textFieldAtIndex:1];
                    [alert show];
                }
            }
            break;
         case 2:
            [self performSegueWithIdentifier:@"newMember" sender:self];
            break;
        default:
            break;
    }
}
-(void)showAlertWithTitle:(NSString*)title message:(NSString*)message delegate:(id)delegate alertViewStyle:(UIAlertViewStyle)style{
    alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"確定" otherButtonTitles:nil];
    alert.alertViewStyle = style;
    userTextFiled= [alert textFieldAtIndex:0];
    passwordTextField= [alert textFieldAtIndex:1];
    [alert show];
}

- (void) handleTimer: (NSTimer *) timer
{
 
    if(CACurrentMediaTime()-_lastPhotoUpdateTime>_slideShowTimeInterval)
    {

        // Change Photo with Aimation
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        // Random to choose the method of animation
        switch (arc4random()%4) {
            case 0:
                transition.type=kCATransitionFade;
                break;
            case 1:
                transition.type=kCATransitionMoveIn;
                break;
            case 2:
                transition.type=kCATransitionPush;
                break;
            case 3:
                transition.type=kCATransitionReveal;
                break;
                
            default:
                break;
        }
        // Random to choose the From
        switch (arc4random()%4) {
            case 0:
                transition.subtype=kCATransitionFromRight;
                break;
            case 1:
                transition.subtype=kCATransitionFromLeft;
                break;
            case 2:
                transition.subtype=kCATransitionFromTop;
                break;
            case 3:
                transition.subtype=kCATransitionFromBottom;
                break;
            default:
                break;
        }
        transition.delegate = self;
        _nCurrentIndex++;
        if(_nCurrentIndex>=[_photos count])
        {
            _nCurrentIndex=0;
        }
        
        NSString *urlString = [_photos objectAtIndex:_nCurrentIndex];
        NSString *key = [urlString MD5Hash];
        NSData * imgData = [LoadImage objectForKey:key];
        UIImage *img = [UIImage imageWithData:imgData];

        [self.showNewProduct setImage:img];
        [self.showNewProduct.layer addAnimation:transition forKey:nil];
        _lastPhotoUpdateTime=CACurrentMediaTime();
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}


@end
