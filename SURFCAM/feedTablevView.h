//
//  feedTablevView.h
//  SURFCAM
//
//  Created by Andreas Vestergaard on 04/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "datastore.h"   
#import "CameraViewController.h"
#import <CoreLocation/CoreLocation.h>



@interface feedTablevView : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) NSMutableArray *localFeedArray;
@property (nonatomic,strong) NSMutableArray *localVideoURLArray;
@property (nonatomic,strong) NSMutableArray *localLocationArray;

@property (nonatomic, strong) id <feedTablevViewDelegate> delegate;

@end
