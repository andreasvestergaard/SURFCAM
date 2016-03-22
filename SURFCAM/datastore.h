//
//  datastore.h
//  SURFCAM
//
//  Created by Andreas Vestergaard on 10/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface datastore : NSObject

@property (nonatomic, strong) NSMutableArray *feedArray;
@property (nonatomic, strong) NSMutableArray *videoURLArray;
@property (nonatomic, strong) NSMutableArray *locationArray;


+ (instancetype)sharedDatastore;


@end
