//
//  ServiceModel.h
//  Booking
//
//  Created by Cau Ca on 11/30/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) NSInteger peopleCount;
@property (nonatomic, assign) NSUInteger likeCount;
@property (nonatomic, assign) double distance;

+ (instancetype)serviceWithName:(NSString *)name address:(NSString *)address peopleCount:(NSInteger)count likeCount:(NSInteger)like distance:(double)distance;

@end
