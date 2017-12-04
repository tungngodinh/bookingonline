//
//  TicketModel.m
//  Booking
//
//  Created by Cau Ca on 12/1/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import "TicketModel.h"

@implementation TicketModel

+ (TicketModel *)tickeWithCode:(NSString *)code status:(NSInteger)status branch:(NSString *)branch time:(NSDate *)date idBooking : (NSString*)idBooking serviceID :(NSString*) serviceID{
    TicketModel *model = [[TicketModel alloc] init];
    model.code = code;
    model.status = status;
    model.branch = branch;
    model.date = date;
    model.idBooking = idBooking;
    model.serviceID = serviceID ;
    return model;
}

@end
