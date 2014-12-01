//
//  Stores_ViewController.m
//  ordermenu
//
//  Created by nacldustin on 2014/11/4.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import "Stores_ViewController.h"

@interface Stores_ViewController ()
{
    CLLocationManager *locationManager;
}
@end

@implementation Stores_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    locationManager = [CLLocationManager new];
    
    //先確認有沒有支援此方法  有才執行 (因為ios版本不同 有的有支援)
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
    }
    //中壢夜市
    CLLocationCoordinate2D location;

    location.latitude = 24.961790;
    location.longitude = 121.216710;
    
    //設定地圖可見範圍, 以「中壢夜市」為中心
    MKCoordinateRegion viewRegion =
    MKCoordinateRegionMakeWithDistance(location,100,100);
    
    [_theMapView setRegion:viewRegion];
    
    // 在中壢夜市插針
    MyAnnotation *annoTrainStation = [[MyAnnotation alloc] initWithTitle:@"中壢夜市" andSubTitle:@"" andCoordinate:location];
    [_theMapView addAnnotation:annoTrainStation];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
