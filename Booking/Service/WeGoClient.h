//
//  WeGoClient.h
//  wego24
//
//  Created by doduong on 7/13/16.
//  Copyright © 2016 vmb. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
@import CoreLocation;

@interface WeGoClient : AFHTTPSessionManager <CLLocationManagerDelegate>



@property (strong, nonatomic) NSMutableDictionary *mdictDealImages;
@property (strong, nonatomic) NSMutableDictionary *mdictDeals;

+(instancetype)sharedClient;

-(void) clearDealWithStatus:(NSString*)dealStatus;


#pragma mark - Shop Favorite Recipient 
-(void)getFavouriteRecipient:(NSString*)shopID success:(void(^)(BOOL result))success
                     failure:(void(^)(NSError *error))failure;

#pragma mark - Booking Online

-(void)getAllService:(void(^)(NSArray *result))success
             failure:(void(^)(NSError *error))failure ;
-(void)searchBank:(NSString *)token success:(void(^)(BOOL result))success failure:(void(^)(NSError *error))failure ;
-(void)getDataBank:(void(^)(NSArray *result))success
           failure:(void(^)(NSError *error))failure ;





#pragma mark - Authen


-(void)resetPassword:(NSString *)phone
             success:(void(^)(BOOL result))success
             failure:(void(^)(NSError *error))failure;




-(void)createDeal:(NSDictionary*)od
          success:(void(^)(NSString *shipmentID))success
          failure:(void(^)(NSError *error))failure;
-(void)updateDeal:(NSDictionary*)od
          success:(void(^)(id shipmentID))success
          failure:(void(^)(NSError *error))failure;
-(void)confirmUpdateItems:(NSDictionary*)od
          success:(void(^)(id shipmentID))success
          failure:(void(^)(NSError *error))failure;

-(void)cancelDeal:(NSString *)sId withMessage:(NSString *)message
          success:(void(^)(BOOL result))success
          failure:(void(^)(NSError *error))failure;;
-(void)acceptShiper:(NSString *)sId ForDeal:(NSString *)dealId
            success:(void(^)(BOOL result))success
            failure:(void(^)(NSError *error))failure;
-(void)cancelShiper:(NSString *)sId ForDeal:(NSString *)dealId
            success:(void(^)(BOOL result))success
            failure:(void(^)(NSError *error))failure;
- (void) getPendingRateDealSuccess:(void(^)(NSArray *results))success
                           failure:(void(^)(NSError *error))failure;
-(void)getPriceSuggestFrom:(NSArray *)locations withCode:(NSString *)code andDeposit: (double) deposit
                   success:(void(^)(NSDictionary *priceInfomation))success
                   failure:(void(^)(NSError *error))failure;
-(void)getDistanceConfig:(void(^)(NSDictionary *dic))success failure:(void(^)(NSError *error))failure;
-(void)postExp:(NSString*)key success:(void(^)(BOOL result))success failure:(void(^)(NSError *error))failure;
#pragma mark - Chat
-(void)getChatHistoryforDeal:(NSString *)dealId withShiper:(NSString *)sId atTime:(int)timeStamp
                     success:(void(^)(NSArray *results))success
                     failure:(void(^)(NSError *error))failure;

#pragma mark - Notify
-(void)sendUserToken:(NSString *)token
             success:(void(^)(BOOL result))success
             failure:(void(^)(NSError *error))failure;

#pragma mark - ServerNotify
-(void)serverNotifyListFromIndex:(int)count withType:(NSString *)type_of_data success:(void(^)(NSArray *results))success
                         failure:(void(^)(NSError *error))failure;
-(void)readNotificationWithID:(NSString*)noti_id success:(void(^)(BOOL result))success failure:(void(^)(NSError *error))failure;
-(void)getUnReadNotificationSuccess:(void(^)(int result))success failure:(void(^)(NSError *error))failure;
-(void)sendFeedback:(NSString*)content success:(void(^)(bool result))success failure:(void(^)(NSError *error))failure;
#pragma mark - local storage
+(void) saveLoginFlag:(BOOL)haveLogin;
+(BOOL) getLoginFlag;

+(void) saveAccessToken:(NSString *)token;
+(NSString *) getAccessToken;
-(void)checkVersion: (NSString *)version_id : (NSString*)buildVersion : (NSString *) userID : (NSString *) deviceID;
@end
