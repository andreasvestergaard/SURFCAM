//
//  feedTablevView.m
//  SURFCAM
//
//  Created by Andreas Vestergaard on 04/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import "feedTablevView.h"
#import "CustomCell.h"
#

@implementation feedTablevView

-(void)viewDidLoad{
    [super viewDidLoad];
    datastore *sharedDatastore = [datastore sharedDatastore];
    self.localFeedArray = sharedDatastore.feedArray;
    self.localVideoURLArray = sharedDatastore.videoURLArray;
    self.localLocationArray = sharedDatastore.locationArray;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundImage2.png"]];
    imageView.contentMode = UIViewContentModeCenter;
    self.tableView.backgroundView = imageView;
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    [self.navigationController setNavigationBarHidden:YES];
}


- (IBAction)swipeBack:(id)sender {
    NSLog(@"swiped");
    
    [self dismissViewControllerAnimated:NO completion:^{
        [self.delegate showCamera];
    }];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


-(void)viewDidAppear:(BOOL)animated {
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.localVideoURLArray.count;;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.customImage.image = self.localFeedArray[indexPath.section];
    
    CLLocation *location = self.localLocationArray[indexPath.section];

    cell.locationLabel.text = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
   
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSURL *selectedVideoURL = self.localVideoURLArray[indexPath.section];
        CameraViewController *newCamVC = [CameraViewController new];
        [self presentViewController:newCamVC animated:NO completion:^{
            [newCamVC playVideofromURL:selectedVideoURL];
        }];
        
    }];
}


@end
