//
//  ScheduceTimeController.h
//  Booking
//
//  Created by Cau Ca on 11/28/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduceTimeController : UIViewController

@property (nonatomic, assign) NSInteger ticketId;
@property ( nonatomic , assign) NSString *pgdID ;
@property (nonatomic, assign) NSString *hour ;
@property NSMutableArray *dataPicked;
@property NSInteger typeOfTicket ;  // 0 is created , 1 is updated ticket 
@end
