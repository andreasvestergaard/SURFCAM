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
    
    self.backgroundColor = [UIColor clearColor];
    
    self.customImage.layer.cornerRadius = roundf(self.customImage.frame.size.width/15.0);
    self.customImage.layer.masksToBounds = YES;
    
    self.shadowView.layer.cornerRadius = roundf(self.customImage.frame.size.width/15.0);
    self.shadowView.layer.masksToBounds = NO;
    self.shadowView.layer.shadowRadius  = 10.f;
    self.shadowView.layer.shadowColor   = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset  = CGSizeMake(0.f, 5.f);
    self.shadowView.layer.shadowOpacity = 1.f;
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRoundedRect:self.customImage.bounds cornerRadius:roundf(self.customImage.frame.size.width/15.0)];
    
    self.shadowView.layer.shadowPath = shadowPath.CGPath;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
