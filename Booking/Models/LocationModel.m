//
//  LocationModel.m
//  Booking
//
//  Created by Cau Ca on 11/29/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel
+ (instancetype)locationWith:(NSString *)title snippet:(NSString *)snippet position:(CLLocation *)position {
    LocationModel *location = [[LocationModel alloc] init];
    location.title = title;
    location.snippet = snippet;
    location.position = position;
    return location;
}

@end
