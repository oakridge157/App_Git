//
//  ShoppingCar_TableViewCell.h
//  ordermenu
//
//  Created by nacldustin on 2014/11/5.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCar_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *caculLabel;
@property (weak, nonatomic) IBOutlet UILabel *quentityLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end
