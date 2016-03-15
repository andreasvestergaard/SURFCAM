//
//  CameraViewController.h
//  SURFCAM
//
//  Created by Andreas Vestergaard on 10/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "feedTablevView.h"
#import "datastore.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>







@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *videoView;

@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,strong) NSURL *videoURL;

-(void)playVideofromURL:(NSURL *)url;


@end
