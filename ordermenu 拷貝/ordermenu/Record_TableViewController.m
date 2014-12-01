//
//  Record_TableViewController.m
//  ordermenu
//
//  Created by nacldustin on 2014/11/4.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import "Record_TableViewController.h"
#import "Record_TableViewCell.h"
#import "Detail_TableViewController.h"
#import "DB.h"
@interface Record_TableViewController ()
{
    DB *myDB;
    NSMutableArray *orders;
}
@end

@implementation Record_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myDB = [DB sharedInstance];
    [myDB getAllOrder];
    orders = myDB.showOrders;
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 144, 30)];
    [label1 setFont:[UIFont boldSystemFontOfSize:17]];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 144, 30)];
    [label2 setFont:[UIFont boldSystemFontOfSize:17]];
    label1.text = @"交易序號";
    label2.text = @"交易時間";
    
    
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:0.9]];
    [view addSubview:label1];
    [view addSubview:label2];
    return view;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    return 0;
    return [orders count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Record_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary * ord = [NSDictionary dictionaryWithDictionary:[orders objectAtIndex:indexPath.row]];
    NSLog(@"%@",ord);
    cell.numLabel.text = [ord objectForKey:@"id"];
    cell.timeLabel.text = [ord objectForKey:@"saleTime"];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSInteger index = indexPath.row;
    [[segue destinationViewController] setIndex:index];
}


@end
