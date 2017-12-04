//
//  LocationModel.h
//  Booking
//
//  Created by Cau Ca on 11/29/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *snippet;
@property (nonatomic, strong) CLLocation *position;
@property (nonatomic,strong) NSString *idPGD ;

+ (instancetype)locationWith:(NSString *)title snippet:(NSString *)snippet position:(CLLocation *)position idPGD:(NSString*)idPGD;

@end
