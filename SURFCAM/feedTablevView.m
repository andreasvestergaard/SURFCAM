//
//  feedTablevView.m
//  SURFCAM
//
//  Created by Andreas Vestergaard on 04/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import "feedTablevView.h"
#import "CustomCell.h"

@implementation feedTablevView

-(void)viewDidLoad{
    [super viewDidLoad];
    datastore *sharedDatastore = [datastore sharedDatastore];
    self.localFeedArray = sharedDatastore.feedArray;
    self.localVideoURLArray = sharedDatastore.videoURLArray;
}

-(void)viewDidAppear:(BOOL)animated {
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.localVideoURLArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.customImage.image = self.localFeedArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSURL *selectedVideoURL = self.localVideoURLArray[indexPath.row];
        CameraViewController *newCamVC = [CameraViewController new];
        [self presentViewController:newCamVC animated:NO completion:^{
            [newCamVC playVideofromURL:selectedVideoURL];
        }];
        
    }];
}


@end
