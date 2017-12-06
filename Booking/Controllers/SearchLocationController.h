//
//  SearchLocationController.h
//  Booking
//
//  Created by Cau Ca on 12/6/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ServiceModel.h"

@class SearchLocationController;

@protocol SearchLocationControllerDelegate <NSObject>

@optional

- (void)didSelectService:(ServiceModel *)service;

@end

@interface SearchLocationController : UIViewController

@property (nonatomic, weak) id<SearchLocationControllerDelegate> delegate;

@end
