//
//  WGLocationManager.h
//  wego24
//
//  Created by doduong on 7/5/16.
//  Copyright © 2016 vmb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "WeGoClient.h"

@interface WGLocationManager : NSObject<CLLocationManagerDelegate>{
    
}

@property (strong, nonatomic) CLLocation *userLocation;
@property (strong, nonatomic) CLLocationManager *clManager;
@property (copy, nonatomic) void(^locationDidChange)(CLLocation *userLocation);
@property (strong, nonatomic) NSMutableArray *marrShiper;
@property (strong, nonatomic) NSMutableArray *marrLocations;
@property (copy, nonatomic) void(^finishSendLocation)(BOOL result,int value);
@property (assign, nonatomic) int maxDistance;
@property (assign, nonatomic) int minDistance;
@property (assign, nonatomic) int onhand_price;
@property (assign, nonatomic) int max_distance_on_create_two;
@property (assign , nonatomic) int km_promotion;
@property (assign , nonatomic) double deposit_shop_freelancer;
@property ( assign , nonatomic ) double percent_shipment_to_shop ;

+(instancetype) sharedInstance;

#pragma mark - Track location
-(void) getAddressFromLocation:(CLLocation *)loc Complete:(void(^)(NSString *address,NSString *errMsg))completionBlock;

-(void) getAddressFromLocation:(CLLocation *)loc : (NSString*) key Complete:(void(^)(NSString *address,NSString *errMsg))completionBlock;
#pragma mark - Chat
-(void) sendTo:(NSString *)userId Message:(NSString *)message ForShipment:(NSString *)shipmentId;

#pragma mark - WG WebSocket
-(void)startWebSocket;
-(void)stopWebSocket;
-(void)echoTest;
-(void)getNearPartner:(CLLocationCoordinate2D)location complete:(void(^)(NSArray *arrPartner))completeBlock;
-(void)getLocationOfShiper:(NSString *)sId complete:(void(^)(NSDictionary *dict))completeBlock;

@end








