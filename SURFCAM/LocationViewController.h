//
//  LocationViewController.h
//  SURFCAM
//
//  Created by Andreas Vestergaard on 21/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface LocationViewController : UIViewController

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (strong,nonatomic) CLLocation *location;

+ (LocationViewController *)sharedSingleton;


@end
