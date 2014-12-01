//
//  DB.h
//  ordermenu
//
//  Created by nacldustin on 2014/11/7.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DB : NSObject
#pragma mark - User account
@property(strong, nonatomic)NSString *account;

#pragma mark - Products descriptions
@property(strong, nonatomic)NSMutableArray *photos;
@property(strong, nonatomic)NSMutableArray *productDatas;

#pragma mark - User descriptions
@property(strong, nonatomic)NSMutableDictionary *user;
@property(strong, nonatomic)NSMutableDictionary *userDetail;

#pragma mark - Shopping Car description
@property(strong, nonatomic)NSMutableArray *shoppingCar;
@property(strong, nonatomic)NSMutableDictionary *order;

#pragma mark - about orders
@property(strong, nonatomic)NSMutableArray *showOrders;

#pragma mark - Result of status
@property(strong, nonatomic)NSString *resultOfLogin;
@property(strong, nonatomic)NSString *resultOfRegist;
@property(strong, nonatomic)NSString *resultOfUpdateUser;
@property(strong, nonatomic)NSString *resultOfGetUser;
@property(strong, nonatomic)NSString *resultOfSendOrder;

#pragma mark - methods
+(DB *)sharedInstance;
-(NSMutableArray*)photos;
-(NSMutableArray*)productDatas;
-(NSString*)login:(NSDictionary*)acount;
-(NSString*)getProductsInfo;
-(NSMutableDictionary*)getMemberDetail;
-(void)setMemberDetail:(NSString*)account details:(NSDictionary *)details;
-(void)sendOrder;
-(NSString*)getAllOrder;
-(NSString*)Regist:(NSDictionary*)acount details:(NSDictionary*)details;
@end
