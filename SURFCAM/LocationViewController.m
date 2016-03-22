//
//  LocationViewController.m
//  SURFCAM
//
//  Created by Andreas Vestergaard on 21/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import "LocationViewController.h"


@interface LocationViewController() <CLLocationManagerDelegate>

//@property (strong, nonatomic) CLLocationManager *LocationManager;

@end


@implementation LocationViewController

@synthesize locationManager;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        [self.locationManager  requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

-(void)viewDidLoad {
    
}


+ (LocationViewController *)sharedSingleton {
    static LocationViewController* sharedSingleton;
    if(!sharedSingleton) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedSingleton = [LocationViewController new];
        });
    }
        return sharedSingleton;
}
                      
                      
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"%f", self.locationManager.location.coordinate.latitude);
    NSLog(@"%f", self.locationManager.location.coordinate.longitude);
    
    self.location = self.locationManager.location;
    
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Fail %@", error);
}



@end




