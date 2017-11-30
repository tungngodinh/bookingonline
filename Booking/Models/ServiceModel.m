//
//  ServiceModel.m
//  Booking
//
//  Created by Cau Ca on 11/30/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel

+ (instancetype)serviceWithName:(NSString *)name address:(NSString *)address peopleCount:(NSInteger)count likeCount:(NSInteger)like distance:(double)distance {
    ServiceModel *model = [[ServiceModel alloc] init];
    model.name = name;
    model.address = address;
    model.peopleCount = count;
    model.likeCount = like;
    model.distance = distance;
    return model;
}

@end
