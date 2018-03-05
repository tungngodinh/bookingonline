//
//  GGMapClient.h
//  wego24
//
//  Created by doduong on 9/10/16.
//  Copyright © 2016 vmb. All rights reserved.
//
@import SVProgressHUD;

#import <AFNetworking/AFNetworking.h>



@interface GGMapClient : AFHTTPSessionManager


+(instancetype)sharedClient;

#pragma mark - Place
-(void)suggestPlace:(NSString *)key Complete:(void(^)(NSArray *arrSuggest,NSString *key))completionBlock;
-(void)searchPlace:(NSString *)key Complete:(void(^)(NSArray *arrResult,NSString *key))completionBlock;


@end
