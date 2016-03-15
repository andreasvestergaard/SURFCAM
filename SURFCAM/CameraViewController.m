//
//  CameraViewController.m
//  SURFCAM
//
//  Created by Andreas Vestergaard on 10/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import "CameraViewController.h"


@interface CameraViewController ()

@property (nonatomic, retain) AVPlayerViewController *avPlayerViewcontroller;


@end

@implementation CameraViewController

- (void)viewDidLoad {

//    datastore *sharedDatastore = [datastore sharedDatastore];
//    
//    
//    [sharedDatastore.feedArray addObject: @"1"];
//    NSLog(@"%li", sharedDatastore.feedArray.count);
//    
    
}

- (IBAction)camera:(id)sender {
    // UIIMAGEPICKER VERSION
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];

    
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    self.imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidLoad];
}

//-(void)playVideo{
//    
//    //create playvideo with url function (using block?)
//    
//    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
//    playerViewController.player = [AVPlayer playerWithURL:self.videoURL];
//    self.avPlayerViewcontroller = playerViewController;
//    playerViewController.showsPlaybackControls = YES;
//    [self resizePlayerToViewSize];
//    [self.view addSubview:playerViewController.view];
//    self.view.autoresizesSubviews = TRUE;
//}

-(void)playVideofromURL:(NSURL *)url{

        AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
        playerViewController.player = [AVPlayer playerWithURL:url];
        self.avPlayerViewcontroller = playerViewController;
        playerViewController.showsPlaybackControls = YES;
        [self resizePlayerToViewSize];
        [self.view addSubview:playerViewController.view];
        self.view.autoresizesSubviews = TRUE;
}




- (void) resizePlayerToViewSize
{
    CGRect frame = self.view.frame;
    NSLog(@"frame size %d, %d", (int)frame.size.width, (int)frame.size.height);
    self.avPlayerViewcontroller.view.frame = frame;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    self.videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSURL *urlForVideo = (NSURL *)[info objectForKey:UIImagePickerControllerMediaURL];
    
    //[self playVideo];
  
    //save url to array:
    datastore *sharedDatastore = [datastore sharedDatastore];
    [sharedDatastore.videoURLArray addObject: urlForVideo];
    [picker dismissViewControllerAnimated:YES completion:NULL];
   
    AVAsset *asset = [AVAsset assetWithURL:urlForVideo];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime time = CMTimeMake(1, 1);
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationRight];
    
    
    [sharedDatastore.feedArray addObject: image];
    [picker dismissViewControllerAnimated:YES completion:nil];

    
    NSLog(@"%@",self.videoURL);

    
    
//    Save image to array

//    UIImage *newImage = info[UIImagePickerControllerOriginalImage];
//    datastore *sharedDatastore = [datastore sharedDatastore];
//    [sharedDatastore.feedArray addObject: newImage];
//    [picker dismissViewControllerAnimated:YES completion:NULL];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
