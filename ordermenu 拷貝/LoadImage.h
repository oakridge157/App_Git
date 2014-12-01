//
//  LoadImage.h
//  ordermenu
//
//  Created by nacldustin on 2014/11/12.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadImage : NSObject

+ (void) resetImageFile;

+ (void) setObject:(NSData*)data forKey:(NSString*)key;
+ (id) objectForKey:(NSString*)key;

@end
