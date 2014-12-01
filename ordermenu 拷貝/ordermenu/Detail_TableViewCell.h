//
//  Detail_TableViewCell.h
//  ordermenu
//
//  Created by nacldustin on 2014/11/11.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detail_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTotalLabel;

@end
