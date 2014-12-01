//
//  Detail_TableViewController.m
//  ordermenu
//
//  Created by nacldustin on 2014/11/10.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import "Detail_TableViewController.h"
#import "Detail_TableViewCell.h"
#import "DB.h"

@interface Detail_TableViewController ()
{
    DB *myDB;
    NSMutableDictionary *order;
    NSMutableArray *orderDetails;
}
@end

@implementation Detail_TableViewController
@synthesize index;
- (void)viewDidLoad {
    [super viewDidLoad];
    myDB = [DB sharedInstance];
    if (![myDB showOrders]) {
        [myDB getAllOrder];
    }
    NSLog(@"%@",[myDB showOrders]);
    order = [[myDB showOrders] objectAtIndex:index];
    orderDetails = [order objectForKey:@"detail"];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


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
    for (NSDictionary *dict in orderDetails) {
        total =total + [[dict objectForKey:@"price"] integerValue]*[[dict objectForKey:@"quentity"] integerValue];
    }
    
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 70, 30)];
    [label6 setFont:[UIFont boldSystemFontOfSize:17]];
    label6.text = [NSString stringWithFormat:@"%ld 元",total ];
    
    [view addSubview:label5];
    [view addSubview:label6];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:0.9]];
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [orderDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Detail_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:[orderDetails objectAtIndex:indexPath.row]];
    NSString *product = [dict objectForKey:@"productName"];
    NSString *str = [product stringByReplacingOccurrencesOfString:@"u" withString:@"\\u"];
    
    NSString *convertedString = [str mutableCopy];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    
    NSLog(@"convertedString: %@", convertedString);

    
    
    
    cell.productLabel.text = convertedString;
    cell.priceLabel.text = [dict objectForKey:@"price"];
    cell.quantityLabel.text = [dict objectForKey:@"quentity"];
    cell.subTotalLabel.text = [NSString stringWithFormat:@"%ld",[cell.priceLabel.text integerValue] * [cell.quantityLabel.text integerValue] ];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
