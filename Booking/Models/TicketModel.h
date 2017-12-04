//
//  TicketModel.h
//  Booking
//
//  Created by Cau Ca on 12/1/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketModel : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *branch;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *idBooking;
@property (nonatomic, assign) NSString *ticketNumber;
@property ( nonatomic, strong)NSString *serviceID ;

+ (TicketModel *)tickeWithCode:(NSString *)code status:(NSInteger)status branch:(NSString *)branch time:(NSDate *)date idBooking : (NSString*)idBooking serviceID :(NSString*) serviceID;

@end
