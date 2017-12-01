//
//  TicketModel.m
//  Booking
//
//  Created by Cau Ca on 12/1/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import "TicketModel.h"

@implementation TicketModel

+ (TicketModel *)tickeWithCode:(NSString *)code status:(NSInteger)status branch:(NSString *)branch time:(NSDate *)date {
    TicketModel *model = [[TicketModel alloc] init];
    model.code = code;
    model.status = status;
    model.branch = branch;
    model.date = date;
    return model;
}

@end
