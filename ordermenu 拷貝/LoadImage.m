//
//  LoadImage.m
//  ordermenu
//
//  Created by nacldustin on 2014/11/12.
//  Copyright (c) 2014年 Dustin. All rights reserved.
//

#import "LoadImage.h"
static NSTimeInterval cacheTime =  (double)604800;
@implementation LoadImage
+ (void) resetImageFile {
    [[NSFileManager defaultManager] removeItemAtPath:[LoadImage fileDirectory] error:nil];
}

+ (NSString*) fileDirectory {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fileDirectory = [paths objectAtIndex:0];
    fileDirectory = [fileDirectory stringByAppendingPathComponent:@"Images"];
    return fileDirectory;
}

+ (NSData*) objectForKey:(NSString*)key {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filename = [self.fileDirectory stringByAppendingPathComponent:key];
    
    if ([fileManager fileExistsAtPath:filename])
    {
        NSDate *modificationDate = [[fileManager attributesOfItemAtPath:filename error:nil] objectForKey:NSFileModificationDate];
        if ([modificationDate timeIntervalSinceNow] > cacheTime) {
            [fileManager removeItemAtPath:filename error:nil];
        } else {
            NSData *data = [NSData dataWithContentsOfFile:filename];
            return data;
        }
    }
    return nil;
}

+ (void) setObject:(NSData*)data forKey:(NSString*)key {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filename = [self.fileDirectory stringByAppendingPathComponent:key];
    
    BOOL isDir = YES;
    if (![fileManager fileExistsAtPath:self.fileDirectory isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:self.fileDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSError *error;
    @try {
        [data writeToFile:filename options:NSDataWritingAtomic error:&error];
    }
    @catch (NSException * e) {
        //TODO: error handling maybe
    }
}

@end
