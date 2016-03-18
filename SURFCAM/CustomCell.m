//
//  CustomCell.m
//  SURFCAM
//
//  Created by Andreas Vestergaard on 11/03/16.
//  Copyright © 2016 Andreas Vestergaard. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    
//   self.imageView.layer.shadowColor = [UIColor purpleColor].CGColor;
//    self.customImage.layer.shadowOffset = CGSizeMake(0, 1);
//    self.customImage.layer.shadowOpacity = 1;
//    self.customImage.layer.shadowRadius = 1.0;
//   self.customImage.clipsToBounds = NO;
// Initialization code
    
    
    self.customImage.layer.shadowOffset = CGSizeMake(0, 3); //default is (0.0, -3.0)
    self.customImage.layer.shadowColor = [UIColor blackColor].CGColor; //default is black
    self.customImage.layer.shadowRadius = 3.0; //default is 3.0
    self.customImage.layer.shadowOpacity = .5; //default is 0.0

    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
