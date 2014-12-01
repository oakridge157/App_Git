//
//  ShoppingCar_ViewController.m
//  ordermenu
//
//  Created by nacldustin on 2014/11/5.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import "ShoppingCar_ViewController.h"
#import "ShoppingCar_TableViewCell.h"
#import "DB.h"

static NSString * const product = @"productName";
static NSString * const price = @"price";
static NSString * const quentity = @"quentity";
@interface ShoppingCar_ViewController ()
{
    DB *myDB;
    NSMutableArray *shoppingCar;
    UIAlertView *alert;
    UITextField *userTextFiled;
    UITextField *passwordTextField;
}
@end

@implementation ShoppingCar_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myDB = [DB sharedInstance];
    shoppingCar = [myDB shoppingCar];
    
}
- (IBAction)sureButton:(id)sender {
    NSLog(@"%@",myDB.account);
    if (![myDB account]) {
        alert =[[UIAlertView alloc] initWithTitle:@"登入" message:@"" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
        alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        userTextFiled= [alert textFieldAtIndex:0];
        passwordTextField= [alert textFieldAtIndex:1];
        [alert show];
    }else{
        NSLog(@"%@",[myDB account]);
        [myDB sendOrder];
        myDB.shoppingCar = nil;
        shoppingCar = nil;
        [self.tableView reloadData];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString* loginResult;
    NSDictionary *account;
    NSString *netStatus;
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            account = [NSDictionary dictionaryWithObjectsAndKeys:userTextFiled.text,@"account",passwordTextField.text,@"password", nil];
            netStatus = [myDB login:account];
            if ([netStatus isEqualToString:@""]) {
                loginResult = myDB.resultOfLogin;
                if ([loginResult isEqualToString:@"登入成功\t"]) {
                    myDB.account = userTextFiled.text;
                    [self showAlertWithTitle:@"登入" message:loginResult delegate:self alertViewStyle:UIAlertViewStyleDefault];
                    [myDB sendOrder];
                    myDB.shoppingCar = nil;
                    shoppingCar = nil;
                    [self.tableView reloadData];
                }else {
                    [self showAlertWithTitle:@"登入錯誤" message:loginResult delegate:self alertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
                }
            }
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

- (IBAction)clearButton:(id)sender {
    shoppingCar = [NSMutableArray arrayWithCapacity:0];
    myDB.shoppingCar = [NSMutableArray arrayWithArray:shoppingCar];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [shoppingCar count];
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0;
}
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section{
    return 30.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 30)];
    [label1 setFont:[UIFont boldSystemFontOfSize:17]];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 70, 30)];
    [label2 setFont:[UIFont boldSystemFontOfSize:17]];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 70, 30)];
    [label3 setFont:[UIFont boldSystemFontOfSize:17]];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 70, 30)];
    [label4 setFont:[UIFont boldSystemFontOfSize:17]];
    
    label1.text = @"品名";
    label2.text = @"數量";
    label3.text = @"單價";
    label4.text = @"小計";

    
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:0.9]];
    [view addSubview:label1];
    [view addSubview:label2];
    [view addSubview:label3];
    [view addSubview:label4];
    return view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 70, 30)];
    [label5 setFont:[UIFont boldSystemFontOfSize:17]];
    label5.text = @"共計：";
    NSInteger total = 0;
    for (NSDictionary *dict in shoppingCar) {
        total =total + [[dict objectForKey:price] integerValue]*[[dict objectForKey:quentity] integerValue];
    }
    
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 70, 30)];
    [label6 setFont:[UIFont boldSystemFontOfSize:17]];
    label6.text = [NSString stringWithFormat:@"%ld 元",total ];

    [view addSubview:label5];
    [view addSubview:label6];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:0.9]];
    return view;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 ShoppingCar_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
     NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[shoppingCar objectAtIndex:indexPath.row]];
     NSInteger priceOfproduct = [[dict objectForKey:price] integerValue];
     NSInteger quentities = [[dict objectForKey:quentity] integerValue];
     cell.detailLabel.text = [dict objectForKey:product];
     cell.quentityLabel.text = [dict objectForKey:quentity];
     cell.priceLabel.text = [dict objectForKey:price];
     cell.caculLabel.text = [NSString stringWithFormat:@"%ld",priceOfproduct * quentities];
 // Configure the cell...
 
 return cell;
 }

 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [shoppingCar removeObjectAtIndex:indexPath.row];
        myDB.shoppingCar = shoppingCar;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
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
