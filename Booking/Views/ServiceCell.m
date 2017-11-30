//
//  ServiceCell.m
//  Booking
//
//  Created by LuongTheDung on 11/30/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import FontAwesomeKit;
@import NSString_Color;

#import "ServiceCell.h"

@implementation ServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat iconsize = 20;
    FAKIonIcons *icon = [FAKIonIcons iosPeopleOutlineIconWithSize:iconsize];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    self.peopleImage.image = [icon imageWithSize:CGSizeMake(iconsize, iconsize)];
    
    icon = [FAKIonIcons thumbsupIconWithSize:iconsize];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    self.likelImage.image = [icon imageWithSize:CGSizeMake(iconsize, iconsize)];
    
    icon = [FAKIonIcons androidCarIconWithSize:iconsize];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    self.distanceImage.image = [icon imageWithSize:CGSizeMake(iconsize, iconsize)];
    
    icon = [FAKIonIcons cashIconWithSize:50];
    [icon setAttributes:@{NSForegroundColorAttributeName : [@"#76D6FF" representedColor]}];
    self.logoImage.image = [icon imageWithSize:CGSizeMake(60, 60)];
    
    self.logoImage.layer.cornerRadius = 30;
    self.logoImage.layer.borderWidth = 1 /[[UIScreen mainScreen] scale];
    self.logoImage.layer.borderColor = [@"#76D6FF" representedColor].CGColor;
    self.logoImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
