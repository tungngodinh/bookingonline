//
//  MenuHeaderView.m
//  Booking
//
//  Created by Cau Ca on 11/30/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import Masonry;
@import FontAwesomeKit;

#import "MenuHeaderView.h"

@interface MenuHeaderView()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) UIImageView *logoImage;

@end

@implementation MenuHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _usernameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _emailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _logoImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_nameLabel];
    [self addSubview:_usernameLabel];
    [self addSubview:_emailLabel];
    [self addSubview:_logoImage];
    
    CGFloat iconsize = frame.size.width * 0.2;
    _logoImage.contentMode = UIViewContentModeScaleAspectFit;
    FAKIonIcons *icon = [FAKIonIcons calendarIconWithSize:iconsize];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    _logoImage.image = [icon imageWithSize:CGSizeMake(iconsize, iconsize)];
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(iconsize);
        make.height.mas_equalTo(iconsize);
        make.leading.equalTo(self.mas_leading).offset(iconsize * 0.2);
        make.top.equalTo(self.mas_top).offset(iconsize * 0.2);
    }];
    
    _nameLabel.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBold];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.text = @"Booking";
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_logoImage.mas_trailing).offset(10);
        make.top.equalTo(_logoImage.mas_top);
    }];
    
    _usernameLabel.font = [UIFont systemFontOfSize:15];
    _usernameLabel.textColor = [UIColor whiteColor];
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(10);
        make.top.equalTo(_logoImage.mas_bottom).offset(5);
        make.trailing.equalTo(self.mas_trailing);
        make.height.mas_greaterThanOrEqualTo(17);
    }];
    
    _emailLabel.font = [UIFont systemFontOfSize:13];
    _emailLabel.textColor = [UIColor whiteColor];
    [_emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_usernameLabel.mas_leading);
        make.top.equalTo(_usernameLabel.mas_bottom).offset(3);
        make.trailing.equalTo(self.mas_trailing);
        make.height.mas_greaterThanOrEqualTo(15);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    CGSize size = [self systemLayoutSizeFittingSize:frame.size withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, size.width, size.height);
    return self;
}

- (void)setUserName:(NSString *)name email:(NSString *)email {
    _usernameLabel.text = name;
    _emailLabel.text = email;
}

@end
