//
//  MenuHeaderView.m
//  Booking
//
//  Created by Cau Ca on 11/30/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import "TicketCell.h"

@implementation TicketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.containerView.layer.cornerRadius = 5;
    self.containerView.layer.borderWidth = 1/[[UIScreen mainScreen] scale];
    self.containerView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.containerView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
