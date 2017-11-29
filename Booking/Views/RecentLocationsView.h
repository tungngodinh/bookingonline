//
//  RecentLocationsView.h
//  Booking
//
//  Created by Cau Ca on 11/29/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentLocationsView : UIView

- (void)setSnippet:(NSString *)snippet phone:(NSString *)phone distance:(double)distance estimateWidth:(CGFloat)width;

@property (nonatomic, copy) void (^viewTappedBlock)(void);

@end
