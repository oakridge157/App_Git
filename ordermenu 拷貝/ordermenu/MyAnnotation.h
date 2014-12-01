//
//  MyAnnotation.h
//  MapKit_Image
//
//  Created by Stronger Shen on 13/7/1.
//  Copyright (c) 2013年 MobileIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic) MKPinAnnotationColor pinColor;

-(id)initWithTitle:(NSString *)theTitle andSubTitle:(NSString *)theSubTitle andCoordinate:(CLLocationCoordinate2D)theCoordinate;

@end
