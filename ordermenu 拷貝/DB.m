//
//  DB.m
//  ordermenu
//
//  Created by nacldustin on 2014/11/7.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import "DB.h"
#import "Reachability.h"
#import "AFNetworking.h"

#pragma mark - API URL
static NSString * const hostName = @"nacldustin.000space.com";
static NSString * const imgHost = @"http://nacldustin.000space.com/API/";

static NSString * const loginJSON = @"http://nacldustin.000space.com/API/memberlogin.php";
static NSString * const updateUserJSON = @"http://nacldustin.000space.com/API/setMemberDetail.php";
static NSString * const getMemberDetailJSON = @"http://nacldustin.000space.com/API/showMembers.php";
static NSString * const showproductsJSON = @"http://nacldustin.000space.com/API/showProductDetail.php";
static NSString * const sendOrders = @"http://nacldustin.000space.com/API/sendOrder.php";
static NSString * const getAllOrders =@"http://nacldustin.000space.com/API/showOrders.php";
static NSString * const newMember =@"http://nacldustin.000space.com/API/registNewMember.php";

/*static NSString * const hostName = @"10.120.166.19";
static NSString * const imgHost = @"http://10.120.166.19/store1/";

static NSString * const loginJSON = @"http://10.120.166.19/store1/API/memberlogin.php";
static NSString * const registJSON = @"http://10.120.166.19/store1/member.php";
static NSString * const updateUserJSON = @"http://10.120.166.19/store1/API/setMemberDetail.php";
static NSString * const getMemberDetailJSON = @"http://10.120.166.19/store1/API/showMembers.php";
static NSString * const showproductsJSON = @"http://10.120.166.19/store1/API/showProductDetail.php";
static NSString * const sendOrders = @"http://10.120.166.19/store1/API/sendOrder.php";
static NSString * const getAllOrders =@"http://10.120.166.19/store1/API/showOrders.php";
*/
#pragma mark - Action check
static NSInteger const getProductFromMySQL = 0;
static NSInteger const startlogin = 1;
static NSInteger const setMember = 2;
static NSInteger const getMember = 3;
static NSInteger const sendOrder = 4;
static NSInteger const getOrder = 5;
static NSInteger const registNewMember = 6;
#pragma mark -
@interface DB()
-(NSString*)checkNetStatus:(NSInteger)actionInfo;
-(void)getProduct:(NSURL*)url;
-(void)startSetMember:(NSURL*)url;
-(void)startGetMember:(NSURL*)url;
-(void)starSendOrder:(NSURL*)url;
-(void)getOrders:(NSURL*)url;
-(void)startRegist:(NSURL*)url;
@end
DB *sharedInstance;
@implementation DB

+(DB *)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[DB alloc] init];
    }
    return sharedInstance;
}
-(NSMutableArray*)_photos{
    return _photos;
}
-(NSMutableArray*)_productDatas{
    return _productDatas;
}
-(NSString*)checkNetStatus:(NSInteger)actionInfo{
    NSString *checkStatus = @"無可用網路";
    Reachability *reach = [Reachability reachabilityWithHostName:hostName];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus != NotReachable) {
        switch (actionInfo) {
            case getProductFromMySQL:
                [self getProduct:[NSURL URLWithString:showproductsJSON]];
                break;
            case startlogin:
                [self startLogin:[NSURL URLWithString:loginJSON]];
                break;
            case setMember:
                [self startSetMember:[NSURL URLWithString:updateUserJSON]];
                break;
            case getMember:
                [self startGetMember:[NSURL URLWithString:getMemberDetailJSON]];
                break;
            case sendOrder:
                [self starSendOrder:[NSURL URLWithString:sendOrders]];
                break;
            case getOrder:
                [self getOrders:[NSURL URLWithString:getAllOrders]];
                break;
            case registNewMember:
                [self startRegist:[NSURL URLWithString:newMember]];
            default:
                break;
        }
        checkStatus=@"";
        return checkStatus;
    }else{
        return checkStatus;
    }
}
-(void)getProduct:(NSURL*)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];    
    
     NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
        if ([data length]>0) {
            //收到正確的資料，而且連線沒有錯誤
            NSArray *ary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                if (!_photos) {
                    _photos = [NSMutableArray arrayWithCapacity:0];
                }
                if (!_productDatas) {
                    _productDatas = [NSMutableArray arrayWithCapacity:0];
                }
                for (NSDictionary *dictTemp in ary) {
                    NSString *urlTemp = [NSString stringWithFormat:@"%@%@",imgHost,[dictTemp objectForKey:@"url"]];
                    [_photos addObject:urlTemp];
                    [_productDatas addObject:[NSDictionary dictionaryWithObjectsAndKeys:[dictTemp objectForKey:@"productName"],@"productName",[dictTemp objectForKey:@"price"],@"price", nil]];
                }
        } else if ([data length]==0) {
            //沒有資料，而且連線沒有錯誤
        }
}
-(NSString*)getProductsInfo{
    NSString *status = [self checkNetStatus:getProductFromMySQL];
    return status;
}
-(void)startLogin:(NSURL*)url{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSData *data  = [NSJSONSerialization dataWithJSONObject:_user options:kNilOptions error:nil];
    [request setHTTPBody:data];
    NSData *dataResult = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    _resultOfLogin = [[NSString alloc] initWithData:dataResult encoding:NSUTF8StringEncoding];

}
-(NSString*)login:(NSDictionary*)acount{
    _user = [NSMutableDictionary dictionaryWithDictionary:acount];
    NSString *status = [self checkNetStatus:startlogin];
    return status;
}
-(void)startSetMember:(NSURL*)url{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:_userDetail options:kNilOptions error:nil];
    [request setHTTPBody:data];
    NSData *dataResult = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    _resultOfUpdateUser = [[NSString alloc] initWithData:dataResult encoding:NSUTF8StringEncoding];
}
-(void)setMemberDetail:(NSString*)account details:(NSDictionary *)details{
    _userDetail = [NSMutableDictionary dictionaryWithDictionary:details];
    [self checkNetStatus:setMember];
}
-(void)startGetMember:(NSURL*)url{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSDictionary *userAccount = [NSDictionary dictionaryWithObject:_account forKey:@"account"];
    NSData *data  = [NSJSONSerialization dataWithJSONObject:userAccount options:kNilOptions error:nil];
    [request setHTTPBody:data];
    NSData *dataResult = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ([dataResult length]>0) {
        //收到正確的資料，而且連線沒有錯誤
        NSArray *ary = [NSJSONSerialization JSONObjectWithData:dataResult options:NSJSONReadingAllowFragments error:nil];
        if (!_userDetail) {
            _userDetail = [NSMutableDictionary dictionaryWithCapacity:0];
        }
        for (NSDictionary *dictTemp in ary) {
            _userDetail = [NSMutableDictionary dictionaryWithDictionary:dictTemp];
        }
    } else if ([data length]==0) {
        //沒有資料，而且連線沒有錯誤
    }
}
-(NSMutableDictionary*)getMemberDetail{
    [self checkNetStatus:getMember];
    return _userDetail;
}
-(void)starSendOrder:(NSURL *)url{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSData *data  = [NSJSONSerialization dataWithJSONObject:_order options:kNilOptions error:nil];
    [request setHTTPBody:data];
    NSData *dataResult = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    _resultOfSendOrder = [[NSString alloc] initWithData:dataResult encoding:NSUTF8StringEncoding];
    NSLog(@"%@",_resultOfSendOrder );
}
-(void)sendOrder{
    _order = [NSMutableDictionary dictionaryWithCapacity:0];
    [_order setObject:_account forKey:@"account"];
    [_order setObject:_shoppingCar forKey:@"detail"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
//    NSLog(@"%@", strDate);
    [_order setObject:strDate forKey:@"saleTime"];
//    NSLog(@"%@",_order);
    [self checkNetStatus:sendOrder];
}
-(void)newMember{
    NSURL *url;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:_userDetail options:kNilOptions error:nil];
    [request setHTTPBody:data];
    NSData *dataResult = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    _resultOfUpdateUser = [[NSString alloc] initWithData:dataResult encoding:NSUTF8StringEncoding];
}


-(void)startRegist:(NSURL*)url{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSData *data  = [NSJSONSerialization dataWithJSONObject:_user options:kNilOptions error:nil];
    [request setHTTPBody:data];
    NSData *dataResult = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    _resultOfRegist = [[NSString alloc] initWithData:dataResult encoding:NSUTF8StringEncoding];
    NSLog(@"%@",_resultOfRegist);
    if ([_resultOfRegist isEqualToString:@"success\t"]) {
        _account = [_user objectForKey:@"account"];
        [self setMemberDetail:_account details:_userDetail];
    }
    
}
-(NSString*)Regist:(NSDictionary*)acount details:(NSDictionary*)details{
    _user = [NSMutableDictionary dictionaryWithDictionary:acount];
    _userDetail = [NSMutableDictionary dictionaryWithDictionary:details];
    NSString *status = [self checkNetStatus:registNewMember];
    return status;
}

-(void)getOrders:(NSURL*)url{
   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"account=%@",_account];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
//    NSString *ary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"%@",ary);
    
        if ([data length]>0) {
        NSArray *ary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (!_showOrders) {
            _showOrders = [NSMutableArray arrayWithCapacity:0];
        }
        _showOrders = [NSMutableArray arrayWithArray:ary];
    } else if ([data length]==0) {
//        沒有資料，而且連線沒有錯誤
    }
    NSLog(@"%@",_showOrders);
}
-(NSString*)getAllOrder{
    NSString *status = [self checkNetStatus:getOrder];
    return status;
}



 














@end
