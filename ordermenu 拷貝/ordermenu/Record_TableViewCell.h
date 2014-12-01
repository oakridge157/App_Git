//
//  Record_TableViewCell.h
//  ordermenu
//
//  Created by nacldustin on 2014/11/10.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Record_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;

@end
