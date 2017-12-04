//
//  ScheduleTimeCell.m
//  Booking
//
//  Created by Cau Ca on 12/3/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import FontAwesomeKit;

#import "ScheduleTimeCell.h"

@implementation ScheduleTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.pointView.layer.cornerRadius = self.pointView.frame.size.width / 2;
    self.pointView.layer.borderWidth = 1;
    self.pointView.layer.borderColor = self.pointView.backgroundColor.CGColor;
    self.pointView.layer.masksToBounds = YES;
    
    FAKIonIcons *icon = [FAKIonIcons iosCalendarOutlineIconWithSize:self.timeBlockImage.frame.size.width];
    [icon setAttributes:@{NSForegroundColorAttributeName : self.timeBlockLabel.textColor}];
    self.timeBlockImage.image = [icon imageWithSize:self.timeBlockImage.frame.size];
    
    icon = [FAKIonIcons androidCheckmarkCircleIconWithSize:self.checkImage.frame.size.width];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    self.checkImage.image = [icon imageWithSize:self.checkImage.frame.size];
    self.serviceTypeLabel.text = @"";
}
- (void)setColorPicked
{
    FAKIonIcons *icon = [FAKIonIcons androidCheckmarkCircleIconWithSize:self.checkImage.frame.size.width];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    self.checkImage.image = [icon imageWithSize:self.checkImage.frame.size];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDisable:(BOOL)disable {
    self.timeLabel.alpha = disable ? 0.5 : 1;
    self.timeBlockLabel.alpha = disable ? 0.5 : 1;
    self.serviceTypeLabel.alpha = disable ? 0.5 : 1;
}

@end
