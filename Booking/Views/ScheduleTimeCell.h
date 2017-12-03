//
//  ScheduleTimeCell.h
//  Booking
//
//  Created by Cau Ca on 12/3/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * kScheduleTimeCellIdentifier = @"ScheduleTimeCell";

@interface ScheduleTimeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeBlockLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timeBlockImage;
@property (weak, nonatomic) IBOutlet UIImageView *checkImage;
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *serviceTypeLabel;

- (void)setDisable:(BOOL)disable;

@end
