//
//  CameraViewController.m
//  SURFCAM
//
//  Created by Andreas Vestergaard on 10/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import "CameraViewController.h"
#import "feedTablevView.h"
#import "LocationViewController.h"

@interface CameraViewController ()

@property (nonatomic, retain) AVPlayerViewController *avPlayerViewcontroller;
@property(nonatomic, readwrite) CGRect videoBounds;

@end
@implementation CameraViewController

- (void)viewDidLoad {
    LocationViewController *sharedLocationVC =[LocationViewController sharedSingleton];
    NSLog(@"location viewDidLoad im camVC:%@", sharedLocationVC.location);
    
}


- (IBAction)updateLocation:(id)sender {
    LocationViewController *sharedLocationVC =[LocationViewController sharedSingleton];
    
    //get location when it is updated (locationDidUpdate finishes)
    
    NSLog(@"location in camVC:%@", sharedLocationVC.location);
}

- (IBAction)camera:(id)sender {
    // UIIMAGEPICKER Capture video
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        LocationViewController *sharedLocationVC =[LocationViewController sharedSingleton];
        [sharedLocationVC.locationManager startUpdatingLocation];
    }];

   

    
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
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidLoad];
}

-(void)playVideofromURL:(NSURL *)url{
    
    //Initialize AVplayer
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:url];
    playerViewController.player = [AVPlayer playerWithPlayerItem:playerItem];
    
    //Setup AVplayer
    playerViewController.showsPlaybackControls = NO;
    self.avPlayerViewcontroller = playerViewController;
    [self resizePlayerToViewSize];
   
    UIView *contentOverlayView =  [playerViewController contentOverlayView];
    contentOverlayView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:playerViewController.view];
   
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [contentOverlayView addGestureRecognizer:singleFingerTap];
    [self.view addSubview:contentOverlayView];
    self.view.autoresizesSubviews = TRUE;
    [playerViewController.player play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"tap in play");
    
     [self dismissViewControllerAnimated:NO completion:nil];
    //Do stuff here...
}

-(void)itemDidFinishPlaying:(NSNotification *) notification {
     [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) resizePlayerToViewSize {
    CGRect frame = self.view.bounds;
    self.avPlayerViewcontroller.view.frame = frame;
    NSLog(@"frame size %d, %d", (int)frame.size.width, (int)frame.size.height);
    self.avPlayerViewcontroller.videoGravity = @"AVLayerVideoGravityResizeAspectFill";
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //Get URL and save to array:
    self.videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSURL *urlForVideo = (NSURL *)[info objectForKey:UIImagePickerControllerMediaURL];
    datastore *sharedDatastore = [datastore sharedDatastore];
    [sharedDatastore.videoURLArray insertObject:urlForVideo atIndex:0];
    [picker dismissViewControllerAnimated:NO completion:NULL];
   
    //Generate Thumbnail and save to array
    AVAsset *asset = [AVAsset assetWithURL:urlForVideo];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    CMTime time = CMTimeMake(1, 1);
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:UIImageOrientationRight];
   
    [sharedDatastore.feedArray insertObject:image atIndex:0];
    
    //Get location and to array
    
    LocationViewController *sharedLocationVC =[LocationViewController sharedSingleton];
    
    CLLocation *locationAtSaveVideo = sharedLocationVC.location;

    [sharedDatastore.locationArray insertObject:locationAtSaveVideo atIndex:0];
    
    [self performSegueWithIdentifier:@"feedSugue1" sender:nil];
    
    
    //    Save image to array:
    
    //    UIImage *newImage = info[UIImagePickerControllerOriginalImage];
    //    datastore *sharedDatastore = [datastore sharedDatastore];
    //    [sharedDatastore.feedArray addObject: newImage];
    //    [picker dismissViewControllerAnimated:YES completion:NULL];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)showCamera {
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"feedSugue1"]) {
        feedTablevView *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
