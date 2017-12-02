//
//  ServiceCell.h
//  Booking
//
//  Created by LuongTheDung on 11/30/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kServiceCellIdentifier = @"ServiceCell";

@interface ServiceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *peopleImage;
@property (weak, nonatomic) IBOutlet UIImageView *likelImage;
@property (weak, nonatomic) IBOutlet UIImageView *distanceImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (nonatomic, weak) IBOutlet UIView *containerView;

@end
