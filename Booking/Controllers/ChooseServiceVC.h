//
//  ChooseServiceVC.h
//  Booking
//
//  Created by LuongTheDung on 12/3/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseServiceVC;

@protocol ChooseServiceVCDelegate <NSObject>

@optional

- (void)didChoseService:(NSInteger)seriveType timeIndex:(NSInteger)index;

@end

@interface ChooseServiceVC : UIViewController

@property (nonatomic, assign) NSInteger timeIndex;
@property (nonatomic, assign) NSInteger selectedService;
@property (nonatomic, weak) id<ChooseServiceVCDelegate> delegate;

@end
