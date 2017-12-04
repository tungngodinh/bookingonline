//
//  TicketDetailController.h
//  Booking
//
//  Created by Cau Ca on 12/3/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TicketModel.h"

@interface TicketDetailController : UIViewController

@property (nonatomic, weak) TicketModel *ticket;
@property NSString *ticketnumberString ;

@end
