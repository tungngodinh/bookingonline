//
//  MakerInfoView.h
//  Booking
//
//  Created by Cau Ca on 11/28/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakerInfoView : UIView

- (void)setName:(NSString *)name
        address:(NSString *)address
    peopleCount:(NSInteger)count
       timeWait:(NSInteger)time
       distance:(double)distance;

@end
