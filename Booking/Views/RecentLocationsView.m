//
//  RecentLocationsView.m
//  Booking
//
//  Created by Cau Ca on 11/29/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import FontAwesomeKit;
@import Masonry;
@import NSString_Color;

#import "RecentLocationsView.h"

@interface RecentLocationsView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *snippetLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIImageView *locationImage;

@end

@implementation RecentLocationsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = YES;
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _snippetLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _locationImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:_titleLabel];
    [self addSubview:_snippetLabel];
    [self addSubview:_phoneLabel];
    [self addSubview:_distanceLabel];
    [self addSubview:_locationImage];
    
    _locationImage.contentMode = UIViewContentModeScaleAspectFit;
    FAKIonIcons *icon = [FAKIonIcons iosNavigateOutlineIconWithSize:20];
    [icon setAttributes:@{NSForegroundColorAttributeName: [@"#5757d6" representedColor]}];
    _locationImage.image = [icon imageWithSize:CGSizeMake(20, 20)];
    [_locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).offset(12);
        make.top.equalTo(self.mas_top).offset(12);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"Recen location";
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_locationImage.mas_centerY);
        make.leading.equalTo(_locationImage.mas_trailing).offset(8);
    }];
    
    _snippetLabel.font = [UIFont systemFontOfSize:16];
    _snippetLabel.numberOfLines = 0;
    [_snippetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_locationImage.mas_leading);
        make.top.equalTo(_locationImage.mas_bottom).offset(5);
        make.trailing.equalTo(self.mas_trailing).offset(-10);
    }];
    
    _phoneLabel.textColor = [@"#34a9dc" representedColor];
    _phoneLabel.font = [UIFont systemFontOfSize:14];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_locationImage.mas_leading);
        make.top.equalTo(_snippetLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    _distanceLabel.textColor = [UIColor redColor];
    _distanceLabel.font = [UIFont systemFontOfSize:14];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing).offset(-10);
        make.top.equalTo(_phoneLabel.mas_top);
    }];
    return self;
}

- (void)setSnippet:(NSString *)snippet phone:(NSString *)phone distance:(double)distance estimateWidth:(CGFloat)width {
    _snippetLabel.text = snippet;
    _phoneLabel.text = phone;
    _distanceLabel.text = [NSString stringWithFormat:@"~ %0.00fkm", distance];
    CGSize size = [self systemLayoutSizeFittingSize:CGSizeMake(width, 200) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [button addTarget:self action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}


- (void)onButtonTapped:(UIButton *)button {
    if (self.viewTappedBlock) {
        self.viewTappedBlock();
    }
}

@end
