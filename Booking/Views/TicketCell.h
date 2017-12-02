//
//  TiketCell.h
//  Booking
//
//  Created by Cau Ca on 11/30/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * kTiketCellIdentifier = @"TicketCell";

@interface TicketCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *documentCode;
@property (nonatomic, weak) IBOutlet UILabel *branchLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeAgoLabel;
@property (nonatomic, weak) IBOutlet UIView *containerView;

@end
