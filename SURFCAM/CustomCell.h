//
//  CustomCell.h
//  SURFCAM
//
//  Created by Andreas Vestergaard on 11/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *shadowView;
@property (strong, nonatomic) IBOutlet UIImageView *customImage;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;



@end
