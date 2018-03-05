//
//  WGLocationManager.m
//  wego24
//
//  Created by doduong on 7/5/16.
//  Copyright © 2016 vmb. All rights reserved.
//
@import AFNetworking;
@import SVProgressHUD;


#import "WGLocationManager.h"


@implementation WGLocationManager

+(instancetype) sharedInstance
{
    static WGLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WGLocationManager alloc] init];
        manager.marrShiper = [[NSMutableArray alloc] init];
        manager.marrLocations = [[NSMutableArray alloc] init];
        [manager initManagerLocation];
        manager.maxDistance = 10000;
        manager.minDistance = 200;
        manager.max_distance_on_create_two = 15000;
        manager.onhand_price = 5000;
        manager.km_promotion = 10 ;
        manager.deposit_shop_freelancer = 500000 ;
        manager.percent_shipment_to_shop = 0.8 ; 
        [manager getConfig];
        [manager getLocalConfig];
        
    });
    
    return manager;
}

- (void)getConfig{
    [[WeGoClient sharedClient] getDistanceConfig:^(NSDictionary *dic) {
        if ([dic[@"max_distance"] intValue] > 0 && [dic[@"min_distance"] intValue] > 0) {
            [self saveConfig:dic];
            [self getLocalConfig];
        }
        if ([dic[@"direction_api_key"] count] > 0)
        {
            [self direction_api_key:dic];
        }
        if ([dic[@"map_api_key"] count] > 0)
        {
            [self map_api_key:dic] ;
        }
         if ([dic[@"percent_shipment_to_shop"] doubleValue] >0)
         {
             [self percent_shipment_to_shop: dic];
         }
    } failure:^(NSError *error) {
        
    }];
}
- (void)percent_shipment_to_shop : (NSDictionary *)dic
{
    NSNumber *percent_shipment_to_shop = [dic valueForKey:@"percent_shipment_to_shop"];
    
    //[array_google sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"at" ascending:YES]]];
    [[NSUserDefaults standardUserDefaults] setObject:percent_shipment_to_shop forKey:@"percent_shipment_to_shop"] ;
    [[NSUserDefaults standardUserDefaults]synchronize] ;
    
}

- (void)direction_api_key : (NSDictionary *)dic
{
    NSMutableArray *array_google = [dic valueForKey:@"direction_api_key"];
    //[array_google sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"at" ascending:YES]]];
    [[NSUserDefaults standardUserDefaults] setObject:array_google forKey:@"com.user.direction_api_key"] ;
    [[NSUserDefaults standardUserDefaults]synchronize] ;
    
}
- (void)map_api_key : (NSDictionary *)dic
{
    NSMutableArray *array_google = [dic valueForKey:@"map_api_key"];
    [[NSUserDefaults standardUserDefaults] setObject:array_google forKey:@"com.user.map_api_key"] ;
    [[NSUserDefaults standardUserDefaults]synchronize] ;
    
}
- (void) saveConfig:(NSDictionary*)dic{
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"com.user.config"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary*) getLocalConfig{
    NSDictionary *config = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"com.user.config"];
    if (config) {
        self.maxDistance = [config[@"max_distance"] intValue];
        self.minDistance = [config[@"min_distance"] intValue];
        self.max_distance_on_create_two = [config[@"max_distance_on_create_two"] intValue];
        self.onhand_price = [config[@"onhand_price"] intValue];
        self.deposit_shop_freelancer = [config[@"deposit_shop_freelancer"] doubleValue];
        self.km_promotion = [config[@"km_promotion"] intValue] ;
        
    }
    return config;
}

-(void) getAddressFromLocation:(CLLocation *)loc : (NSString*) key Complete:(void(^)(NSString *address,NSString *errMsg))completionBlock{
    CLGeocoder *gcoder = [[CLGeocoder alloc] init];
    [gcoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if(!error){
            CLPlacemark *place = [placemarks count]?placemarks[0]:nil;
            
            if(place != nil){
                NSLog(@"Name:%@\nInLandWater: %@\nSea: %@",place.name,place.inlandWater,place.ocean);
                
                NSString *locatedAt = [[place.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                completionBlock?completionBlock(locatedAt,nil):0;
            }else{
                completionBlock?completionBlock(nil,@"Không tìm thấy địa chỉ!"):0;
            }
        }else{
            NSMutableArray *arra = [[NSUserDefaults standardUserDefaults] valueForKey:@"com.user.map_api_key"];
            NSString *key = [arra valueForKey:@"key"] ;
            [arra removeObjectAtIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:arra forKey:@"com.user.map_api_key"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[WeGoClient sharedClient] postExp:key success:^(BOOL result) {
                
            } failure:^(NSError *error) {
                
            }];
            
            
            completionBlock?completionBlock(nil,error.description):0;
        }
    }];
}

-(void) getLocationFromAddress:(NSString *)address Complete:(void(^)(CLLocation *loc,NSString *errMsg))completionBlock{
    CLGeocoder *gcoder = [[CLGeocoder alloc] init];
    
    [gcoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if(!error)
        {
            CLPlacemark *place = [placemarks count]?placemarks[0]:nil;
            if(place != nil){
                completionBlock?completionBlock(place.location,nil):0;
            }else{
                completionBlock?completionBlock(nil,@"No place found!"):0;
            }
        }
        else
        {
            completionBlock?completionBlock(nil,error.description):0;
        }
        
    }];
}

-(void)initManagerLocation
{
    _clManager = [[CLLocationManager alloc] init];
    _clManager.delegate = self;
    _clManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
}

#pragma mark - CLLocationManager
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(locations.count >0){
        CLLocation *loc = locations[0];
        _userLocation = loc;
        _locationDidChange?_locationDidChange(loc):0;
    }
    
}

#pragma mark - WS

-(void) logLocation
{
    if(_userLocation)
    {
        [_marrLocations addObject:@{
                                    @"lat":@(_userLocation.coordinate.latitude),
                                    @"lng":@(_userLocation.coordinate.longitude),
                                    @"time":@((int)[[NSDate date] timeIntervalSince1970]),
                                    }];
    }
    
    if(_marrLocations.count>6)
    {
        [_marrLocations removeObjectAtIndex:0];
    }
    
    [self stopLogLocation]; // make sure only one perform selector logLocation is scheduled.
    [self performSelector:@selector(logLocation) withObject:nil afterDelay:3];
}

-(void)stopLogLocation
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(logLocation) object:nil];
}



-(void)stopReportLocation
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reportLocation) object:nil];
}



-(void)getLocationOfShiper:(NSString *)sId complete:(void(^)(NSDictionary *dict))completeBlock{
    AFHTTPSessionManager *man = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    
    NSString *endpoint = @"wmap/carrier/location";
    
    NSDictionary *param = @{
                            @"carrier_id":sId?:@"",
                            };
    
    [man GET:endpoint parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([responseObject[@"data"] isKindOfClass:[NSArray class]]){
            completeBlock?completeBlock([responseObject[@"data"] firstObject]):0;
        }else{
            completeBlock?completeBlock(nil):0;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"__FUNCTION__: %@",error);
        completeBlock?completeBlock(nil):0;
    }];
}







@end
