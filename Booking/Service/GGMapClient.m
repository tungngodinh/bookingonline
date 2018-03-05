//
//  GGMapClient.m
//  wego24
//
//  Created by doduong on 9/10/16.
//  Copyright © 2016 vmb. All rights reserved.
//


#import "GGMapClient.h"
@import GoogleMaps ;
@import GooglePlaces ;




@implementation GGMapClient

+(instancetype)sharedClient{
    static GGMapClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //client = [[GGMapClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL_GGMAP]];
        client = [[GGMapClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
      //  [GMSServices provideAPIKey:kMapAPIKey];
    });
    
    return client;
}

#pragma mark - Location
//-(void)suggestPlace:(NSString *)key Complete:(void(^)(NSArray *arrSuggest,NSString *key))completionBlock{
//    CLLocationCoordinate2D coor = [[WGLocationManager sharedInstance].a.coordinate;]
//
//
//    NSString *endPoint = [NSString stringWithFormat:@"/gmap/auto/%.2f/%.2f/%d/%@",coor.latitude,coor.longitude,10000,[key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//    [self GET:endPoint parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        ;
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        //NSLog(@"%s:%@",__FUNCTION__,responseObject);
//
//        if(responseObject){
//
//            completionBlock?completionBlock(marr,key):0;
//        }
//        else{
//            completionBlock?completionBlock(@[],key):0;
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"suggestPlace %s:%@",__FUNCTION__,error);
//        completionBlock?completionBlock(@[],key):0;
//
//    }];
//}
//
//-(void)searchPlace:(NSString *)key Complete:(void(^)(NSArray *arrResult, NSString *key))completionBlock{
//    CLLocationCoordinate2D coor = [WGLocationManager sharedInstance].userLocation.coordinate;
//
//    NSString *endPoint = [NSString stringWithFormat:@"/gmap/search/%.2f/%.2f/%d/%@",coor.latitude,coor.longitude,10000,[key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//    [self GET:endPoint parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        ;
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSLog(@"searchPlace %s:%@",__FUNCTION__,responseObject);
//
//        if(responseObject)
//        {
//            NSMutableArray *marr = [[NSMutableArray alloc] init];
//
//            for(NSDictionary *info in responseObject[@"Results"])
//            {
//                ObjectPlace *op = [[ObjectPlace alloc] init];
//                [op copyFromDictionary:info];
//                [marr addObject:op];
//            }
//
//            completionBlock?completionBlock(marr,key):0;
//        }else{
//            completionBlock?completionBlock(@[],key):0;
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"searchPlace %s:%@",__FUNCTION__,error);
//        completionBlock?completionBlock(@[],key):0;
//
//    }];
//
//}
//
//-(void) getAddressFromLocation:(CLLocation *)loc  Complete:(void(^)(NSString *address,NSString *errMsg))completionBlock{
//    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f",loc.coordinate.latitude, loc.coordinate.longitude];
//    NSLog(@"%@", urlString);
//
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//    NSURL *URL = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            [self getAddressFromLocation:loc Complete:^(NSString *address, NSString *errMsg) {
//
//            }];
//        } else {
//            NSLog(@"%@", responseObject);
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                if ([responseObject[@"results"] isKindOfClass:[NSArray class]]) {
//                    NSDictionary *dic = [responseObject[@"results"] firstObject];
//                    completionBlock(dic[@"formatted_address"],nil);
//                }else{
//                    completionBlock(nil, nil);
//                }
//            }else{
//                completionBlock(nil, nil);
//            }
//        }
//    }];
//    [dataTask resume];
//}
//
//-(void) getAddressFromLocationWithOutServer:(CLLocation *)loc  Complete:(void(^)(NSString *address,NSString *errMsg))completionBlock{
//    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f",loc.coordinate.latitude, loc.coordinate.longitude];
//    NSLog(@"%@", urlString);
//
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//    NSURL *URL = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//            completionBlock(nil, nil);
//        } else {
//            NSLog(@"%@", responseObject);
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                if ([responseObject[@"results"] isKindOfClass:[NSArray class]]) {
//                    NSDictionary *dic = [responseObject[@"results"] firstObject];
//                    completionBlock(dic[@"formatted_address"],nil);
//                }else{
//                    completionBlock(nil, nil);
//                }
//            }else{
//                completionBlock(nil, nil);
//            }
//        }
//    }];
//    [dataTask resume];
//}
//
//-(void) optimizeRouteFromLocation:(NSDictionary *)start optimize:(BOOL )isOptimize andWayPoint:(NSArray *)waypoints Complete:(void(^)(NSArray *locations, CLLocationCoordinate2D center, long distance,NSArray *waypointOrder, NSString *errMsg))completionBlock{
//    if (!isOptimize) {
//        [self getRouteFromLocation:start optimize:isOptimize andWayPoint:waypoints Complete:^(NSArray *locations, CLLocationCoordinate2D center, long distance, NSArray *waypointOrder,NSString *errMsg) {
//            completionBlock(locations,center,distance,@[@(0)],errMsg);
//        }];
//        return;
//    }
//    if (waypoints.count == 2) {
//        [self getRouteFromLocation:start optimize:isOptimize andWayPoint:waypoints Complete:^(NSArray *locations1, CLLocationCoordinate2D center1, long distance1, NSArray *waypointOrder1,NSString *errMsg1) {
//            NSMutableArray *points1 = [NSMutableArray arrayWithArray:waypoints];
//            [points1 removeObjectAtIndex:0];
//            [points1 addObject:[waypoints objectAtIndex:0]];
//            [self getRouteFromLocation:start optimize:isOptimize andWayPoint:points1 Complete:^(NSArray *locations2, CLLocationCoordinate2D center2, long distance2, NSArray *waypointOrder2,NSString *errMsg2) {
//                if (distance2 < distance1) {
//                    completionBlock(locations2,center2,distance2,@[@(1),@(0)],errMsg2);
//                }else{
//                    completionBlock(locations1,center1,distance1,@[@(0),@(1)],errMsg1);
//                }
//            }];
//        }];
//    }else if (waypoints.count == 3){
//        [self getRouteFromLocation:start optimize:isOptimize andWayPoint:waypoints Complete:^(NSArray *locations1, CLLocationCoordinate2D center1, long distance1, NSArray *waypointOrder1,NSString *errMsg1) {
//            NSMutableArray *points1 = [NSMutableArray arrayWithArray:waypoints];
//            [points1 removeObjectAtIndex:0];
//            [points1 addObject:[waypoints objectAtIndex:0]];
//            [self getRouteFromLocation:start optimize:isOptimize andWayPoint:points1 Complete:^(NSArray *locations2, CLLocationCoordinate2D center2, long distance2, NSArray *waypointOrder2,NSString *errMsg2) {
//                NSMutableArray *points1 = [NSMutableArray arrayWithArray:waypoints];
//                [points1 removeObjectAtIndex:1];
//                [points1 addObject:[waypoints objectAtIndex:1]];
//                [self getRouteFromLocation:start optimize:isOptimize andWayPoint:points1 Complete:^(NSArray *locations3, CLLocationCoordinate2D center3, long distance3, NSArray *waypointOrder3,NSString *errMsg3) {
//                    if (distance1 <= distance2 && distance1 <= distance3) {
//                        if ([[waypointOrder1 firstObject] integerValue] == 0) {
//                            completionBlock(locations1, center1,distance1,@[@(0),@(1),@(2)],errMsg1);
//                        }else{
//                            completionBlock(locations1, center1,distance1,@[@(1),@(0),@(2)],errMsg1);
//                        }
//                    }else if (distance2 <= distance1 && distance2 <= distance3) {
//
//                        if ([[waypointOrder2 firstObject] integerValue] == 0) {
//                            completionBlock(locations2, center2,distance2,@[@(1),@(2),@(0)],errMsg2);
//                        }else{
//                            completionBlock(locations2, center2,distance2,@[@(2),@(1),@(0)],errMsg2);
//                        }
//                    }else{
//                        if ([[waypointOrder3 firstObject] integerValue] == 0) {
//                            completionBlock(locations3, center3,distance3,@[@(0),@(2),@(1)],errMsg3);
//                        }else{
//                            completionBlock(locations3, center3,distance3,@[@(2),@(0),@(1)],errMsg3);
//                        }
//                    }
//                }];
//            }];
//        }];
//    }else{
//        [self getRouteFromLocation:start optimize:isOptimize andWayPoint:waypoints Complete:^(NSArray *locations, CLLocationCoordinate2D center, long distance, NSArray *waypointOrder,NSString *errMsg) {
//            completionBlock(locations,center,distance,@[@(0)],errMsg);
//
//            //NSLog(@"Dunglt") ;
//        }];
//    }
//}
//-(void) optimizeRouteFromLocation1:(NSDictionary *)start optimize:(BOOL )isOptimize andWayPoint:(NSArray *)waypoints Complete:(void(^)(NSArray *locations, CLLocationCoordinate2D center, long distance,NSArray *waypointOrder, NSString *errMsg))completionBlock{
//    if (!isOptimize) {
//        [self getRouteFromLocation1:start optimize:isOptimize andWayPoint:waypoints Complete:^(NSArray *locations, CLLocationCoordinate2D center, long distance, NSArray *waypointOrder,NSString *errMsg) {
//            completionBlock(locations,center,distance,@[@(0)],errMsg);
//        }];
//        return;
//    }
//    if (waypoints.count == 2) {
//        [self getRouteFromLocation1:start optimize:isOptimize andWayPoint:waypoints Complete:^(NSArray *locations1, CLLocationCoordinate2D center1, long distance1, NSArray *waypointOrder1,NSString *errMsg1) {
//            NSMutableArray *points1 = [NSMutableArray arrayWithArray:waypoints];
//            [points1 removeObjectAtIndex:0];
//            [points1 addObject:[waypoints objectAtIndex:0]];
//            [self getRouteFromLocation:start optimize:isOptimize andWayPoint:points1 Complete:^(NSArray *locations2, CLLocationCoordinate2D center2, long distance2, NSArray *waypointOrder2,NSString *errMsg2) {
//                if (distance2 < distance1) {
//                    completionBlock(locations2,center2,distance2,@[@(1),@(0)],errMsg2);
//                }else{
//                    completionBlock(locations1,center1,distance1,@[@(0),@(1)],errMsg1);
//                }
//            }];
//        }];
//    }else if (waypoints.count == 3){
//        [self getRouteFromLocation1:start optimize:isOptimize andWayPoint:waypoints Complete:^(NSArray *locations1, CLLocationCoordinate2D center1, long distance1, NSArray *waypointOrder1,NSString *errMsg1) {
//            NSMutableArray *points1 = [NSMutableArray arrayWithArray:waypoints];
//            [points1 removeObjectAtIndex:0];
//            [points1 addObject:[waypoints objectAtIndex:0]];
//            [self getRouteFromLocation1:start optimize:isOptimize andWayPoint:points1 Complete:^(NSArray *locations2, CLLocationCoordinate2D center2, long distance2, NSArray *waypointOrder2,NSString *errMsg2) {
//                NSMutableArray *points1 = [NSMutableArray arrayWithArray:waypoints];
//                [points1 removeObjectAtIndex:1];
//                [points1 addObject:[waypoints objectAtIndex:1]];
//                [self getRouteFromLocation1:start optimize:isOptimize andWayPoint:points1 Complete:^(NSArray *locations3, CLLocationCoordinate2D center3, long distance3, NSArray *waypointOrder3,NSString *errMsg3) {
//                    if (distance1 <= distance2 && distance1 <= distance3) {
//                        if ([[waypointOrder1 firstObject] integerValue] == 0) {
//                            completionBlock(locations1, center1,distance1,@[@(0),@(1),@(2)],errMsg1);
//                        }else{
//                            completionBlock(locations1, center1,distance1,@[@(1),@(0),@(2)],errMsg1);
//                        }
//                    }else if (distance2 <= distance1 && distance2 <= distance3) {
//
//                        if ([[waypointOrder2 firstObject] integerValue] == 0) {
//                            completionBlock(locations2, center2,distance2,@[@(1),@(2),@(0)],errMsg2);
//                        }else{
//                            completionBlock(locations2, center2,distance2,@[@(2),@(1),@(0)],errMsg2);
//                        }
//                    }else{
//                        if ([[waypointOrder3 firstObject] integerValue] == 0) {
//                            completionBlock(locations3, center3,distance3,@[@(0),@(2),@(1)],errMsg3);
//                        }else{
//                            completionBlock(locations3, center3,distance3,@[@(2),@(0),@(1)],errMsg3);
//                        }
//                    }
//                }];
//            }];
//        }];
//    }else{
//        [self getRouteFromLocation1:start optimize:isOptimize andWayPoint:waypoints Complete:^(NSArray *locations, CLLocationCoordinate2D center, long distance, NSArray *waypointOrder,NSString *errMsg) {
//            completionBlock(locations,center,distance,@[@(0)],errMsg);
//
//            NSLog(@"Dunglt") ;
//        }];
//    }
//}
//
//-(void) getRouteFromLocation:(NSDictionary *)start optimize:(BOOL )isOptimize andWayPoint:(NSArray *)waypoints Complete:(void(^)(NSArray *locations, CLLocationCoordinate2D center, long distance, NSArray *waypointOrder, NSString *errMsg))completionBlock
//{
//
//    NSMutableArray *keyParam = [[NSUserDefaults standardUserDefaults] valueForKey:@"com.user.direction_api_key"];
//    if ([keyParam count] == 0) return ;
//    NSString *key = [keyParam[0]valueForKey:@"key"];
//
//    NSString *params = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?mode=driving&alternatives=true&origin=%@,%@",start[@"lat"],start[@"lng"]];
//    NSDictionary *end = [waypoints lastObject];
//
//
//    params = [params stringByAppendingString:[NSString stringWithFormat:@"&destination=%@,%@",end[@"destination"][@"lat"],end[@"destination"][@"lng"]]];
//
//    for (int i = 0; i < waypoints.count - 1; i++) {
//        NSDictionary *dic = waypoints[i];
//        if (i == 0) {
//            if (isOptimize) {
//                params = [params stringByAppendingString:[NSString stringWithFormat:@"&waypoints=optimize:true"]];
//            }else{
//                params = [params stringByAppendingString:[NSString stringWithFormat:@"&waypoints=optimize:false"]];
//            }
//        }
//        params = [params stringByAppendingString:[NSString stringWithFormat:@"|%@,%@",dic[@"destination"][@"lat"],dic[@"destination"][@"lng"]]];
//    }
//
//    params = [params stringByAppendingString:[NSString stringWithFormat:@"&key=%@",key]];
//
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//    NSURL *URL = [NSURL URLWithString:[params stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//            NSLog(@"Key GetRouteFromLocation Errorvvvv") ;
//            NSMutableArray *arraS = [[NSMutableArray alloc] init] ;
//
//            for (int i = 1 ; i < [keyParam count] ; i ++)
//            {
//                id keyAdd = [keyParam objectAtIndex:i] ;
//
//                [arraS addObject:keyAdd];
//            }
//            [[NSUserDefaults standardUserDefaults] setObject:arraS forKey:@"com.user.direction_api_key"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//            [[WeGoClient sharedClient] postExp:key success:^(BOOL result) {
//
//            } failure:^(NSError *error) {
//            }];
//            [self getRouteFromLocation:start optimize:isOptimize andWayPoint:waypoints Complete:^(NSArray *locations, CLLocationCoordinate2D center, long distance, NSArray *waypointOrder,NSString *errMsg) {
//                completionBlock(locations,center,distance,@[@(0)],errMsg);
//            }];
//            completionBlock(nil,CLLocationCoordinate2DMake(0, 0),0, nil,error.localizedDescription);
//        } else {
//            if ([responseObject valueForKey:@"error_message"]!= nil)
//            {
//                NSMutableArray *arraS = [[NSMutableArray alloc] init] ;
//
//                for (int i = 1 ; i < [keyParam count] ; i ++)
//                {
//                    id keyAdd = [keyParam objectAtIndex:i] ;
//
//                    [arraS addObject:keyAdd];
//                }
//                [[NSUserDefaults standardUserDefaults] setObject:arraS forKey:@"com.user.direction_api_key"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                [[WeGoClient sharedClient] postExp:key success:^(BOOL result) {
//
//                } failure:^(NSError *error) {
//
//                }];
//                [self getRouteFromLocation:start optimize:isOptimize andWayPoint:waypoints Complete:^(NSArray *locations, CLLocationCoordinate2D center, long distance, NSArray *waypointOrder,NSString *errMsg) {
//                    completionBlock(locations,center,distance,@[@(0)],errMsg);
//                }];
//
//            }
//            else
//            {
//
//                NSMutableArray *points = [NSMutableArray new];
//                long totalKM = 0;
//                NSArray *routes = responseObject[@"routes"];
//
//                NSInteger indexMinDistant = 0 ;
//                NSArray *waypointOrder;
//                long distant = 0 ;
//                CLLocationCoordinate2D center = CLLocationCoordinate2DMake(0, 0);
//                if (routes.count > 0) {
//                    NSInteger totalValueOfRoutes = [routes count] ;
//
//                    for (NSInteger i = 0 ; i < totalValueOfRoutes ; i ++)
//                    {
//                        long distantIn = 0 ;
//                        NSArray *legs = routes[i][@"legs"];
//                        for (NSDictionary *dic in legs) {
//                            distantIn = distantIn + [dic[@"distance"][@"value"] longValue];
//                        }
//                        if (i == 0 )
//                        {
//                            distant = distantIn ; indexMinDistant = i ;
//                        }
//                        else
//                        {
//                            if (distantIn < distant)
//                            {
//                                distant  = distantIn ; indexMinDistant = i ;
//                            }
//                        }
//                    }
//                    NSArray *legs = routes[indexMinDistant][@"legs"];
//                    waypointOrder = routes[indexMinDistant][@"waypoint_order"];
//                    [points addObject:routes[indexMinDistant][@"overview_polyline"][@"points"]];
//                    for (NSDictionary *dic in legs) {
//                        totalKM = totalKM + [dic[@"distance"][@"value"] longValue];
//                    }
//                    if (legs.count == 3) {
//                        NSArray *step = legs[1][@"steps"];
//                        if ([step count] > 0) {
//                            NSDictionary * dic = step[(int)[step count]/2];
//                            center = CLLocationCoordinate2DMake([dic[@"start_location"][@"lat"] floatValue], [dic[@"start_location"][@"lng"] floatValue]);
//                        }
//                    }else{
//                        NSArray *step = legs[0][@"steps"];
//                        if ([step count] > 0) {
//                            NSDictionary * dic = step[(int)[step count]/2];
//                            center = CLLocationCoordinate2DMake([dic[@"start_location"][@"lat"] floatValue], [dic[@"start_location"][@"lng"] floatValue]);
//                        }
//                    }
//
//                }
//                completionBlock(points, center, totalKM, waypointOrder,nil);
//            }
//        }
//
//
//    }];
//    [dataTask resume];
//}


@end
