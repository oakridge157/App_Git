//
//  Stores_ViewController.h
//  ordermenu
//
//  Created by nacldustin on 2014/11/4.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface Stores_ViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *theLabel;
@property (weak, nonatomic) IBOutlet MKMapView *theMapView;

@end
