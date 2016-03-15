//
//  datastore.m
//  SURFCAM
//
//  Created by Andreas Vestergaard on 10/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import "datastore.h"

@implementation datastore


+ (instancetype)sharedDatastore {
    static datastore *_sharedDatastore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDatastore = [[datastore alloc] init];
    });
    return _sharedDatastore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _feedArray = [[NSMutableArray alloc] init];
        _videoURLArray = [[NSMutableArray alloc]init];
    }
    return self;
}



@end
