//
//  BranchCell.h
//  Booking
//
//  Created by Cau Ca on 12/3/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kBranchCellIdentifier = @"BranchCell";

@interface BranchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
