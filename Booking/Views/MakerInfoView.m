//
//  MakerInfoView.m
//  Booking
//
//  Created by Cau Ca on 11/28/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import Masonry;
@import FontAwesomeKit;
@import NSString_Color;

#import "MakerInfoView.h"

@interface MakerInfoView()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *countImageView;
@property (nonatomic, strong) UIImageView *timeImageView;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIImageView *distanceImageView;
@property (nonatomic, strong) UIButton *takeTiketButton;

@end

@implementation MakerInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _takeTiketButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _distanceImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _countImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _timeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    
    [self addSubview:_nameLabel];
    [self addSubview:_addressLabel];
    [self addSubview:_distanceLabel];
    [self addSubview:_countLabel];
    [self addSubview:_timeLabel];
    [self addSubview:_takeTiketButton];
    [self addSubview:_countImageView];
    [self addSubview:_timeImageView];
    [self addSubview:_distanceImageView];
    
    self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    self.layer.cornerRadius = 5;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithWhite:0.1 alpha:1].CGColor;
    self.layer.masksToBounds = YES;
    
    _nameLabel.numberOfLines = 0;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leadingMargin);
        make.top.equalTo(self.mas_topMargin);
        make.trailing.equalTo(self.mas_trailingMargin);
    }];
    
    _addressLabel.numberOfLines = 0;
    _addressLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    _addressLabel.font = [UIFont systemFontOfSize:13];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_leading);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
        make.trailing.equalTo(self.mas_trailing);
    }];
    
    
    FAKIonIcons *icon = [FAKIonIcons modelSIconWithSize:15];
    [icon setAttributes:@{NSForegroundColorAttributeName: [UIColor greenColor]}];
    _distanceImageView.contentMode = UIViewContentModeScaleAspectFit;
    _distanceImageView.image = [icon imageWithSize:CGSizeMake(15, 15)];
    [_distanceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.leading.equalTo(_nameLabel.mas_leading);
        make.top.equalTo(_addressLabel.mas_bottom).offset(8);
    }];
    
    _distanceLabel.textColor = [UIColor greenColor];
    _distanceLabel.font = [UIFont systemFontOfSize:13];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_distanceImageView.mas_trailing).offset(5);
        make.centerY.equalTo(_distanceImageView.mas_centerY);
        make.trailing.equalTo(self.mas_trailingMargin);
    }];
    
    icon = [FAKIonIcons iosPeopleOutlineIconWithSize:15];
    [icon setAttributes:@{NSForegroundColorAttributeName: [UIColor greenColor]}];
    _countImageView.contentMode = UIViewContentModeScaleAspectFit;
    _countImageView.image = [icon imageWithSize:CGSizeMake(15, 15)];
    [_countImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.leading.equalTo(_distanceImageView.mas_leading);
        make.top.equalTo(_distanceImageView.mas_bottom).offset(5);
    }];
    
    _countLabel.textColor = [UIColor greenColor];
    _countLabel.font = [UIFont systemFontOfSize:13];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_countImageView.mas_trailing).offset(5);
        make.centerY.equalTo(_countImageView.mas_centerY);
        make.trailing.equalTo(self.mas_trailingMargin);
    }];
    
    icon = [FAKIonIcons iosClockOutlineIconWithSize:15];
    [icon setAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _timeImageView.contentMode = UIViewContentModeScaleAspectFit;
    _timeImageView.image = [icon imageWithSize:CGSizeMake(15, 15)];
    [_timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.leading.equalTo(_nameLabel.mas_leading);
        make.top.equalTo(_countImageView.mas_bottom).offset(8);
    }];
    
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_timeImageView.mas_trailing).offset(5);
        make.centerY.equalTo(_timeImageView.mas_centerY);
        make.trailing.equalTo(self.mas_trailingMargin);
    }];
    
    _takeTiketButton.backgroundColor = [@"#4BA157" representedColor];
    [_takeTiketButton setTintColor:[UIColor whiteColor]];
    [_takeTiketButton setTitle:@"Take ticket" forState:UIControlStateNormal];
    [_takeTiketButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(20);
        make.trailing.equalTo(self.mas_trailing).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_timeLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(30).priority(750);
    }];
    
    return self;
}

- (void)setName:(NSString *)name
        address:(NSString *)address
    peopleCount:(NSInteger)count
       timeWait:(NSInteger)minute
       distance:(double)distance{
    _nameLabel.text = name;
    _addressLabel.text = address;
    _countLabel.text = [NSString stringWithFormat:@"%ld people", count];
    _timeLabel.text = [NSString stringWithFormat:@"~ %ld minute wait", minute];
    _distanceLabel.text = [NSString stringWithFormat:@"About ~ %0.00f km", distance];
    CGSize size = [self systemLayoutSizeFittingSize:CGSizeMake(220, 220) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    self.frame = frame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
