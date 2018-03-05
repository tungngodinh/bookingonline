
//
//  WeGoClient.m
//  wego24
//
//  Created by doduong on 7/13/16.
//  Copyright © 2016 vmb. All rights reserved.
//

#import "WeGoClient.h"
#import "WGLocationManager.h"
#import "AppDelegate.h"
@import AFNetworking ;

//
//#import <AFImageDownloader.h>
//#import <FirebaseCore/FirebaseCore.h>

#define WGFLog(fname,error) NSLog(@"Fail %s: %@",fname,error)
#define WGSLog(fname,response) NSLog(@"Success %s: %@",fname,response)
#define BASE_URL @"http://123.31.12.147:8888"
@implementation WeGoClient

+(instancetype)sharedClient{
    static WeGoClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        client = [[WeGoClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        
    });
    
    return client;
}

#pragma mark - Wrapper
- (NSURLSessionDataTask *)WGGET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    
    return [self GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            success(task,responseObject);
        }else{
            success(task,@{});
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]) {
            failure(task,[self errorWithCode:100 object:@{@"error": @"Không có kết nối mạng!"}]);
        }else if ([error.localizedDescription isEqualToString:@"Request failed: unauthorized (401)"]) {
          
        
            failure(task,[self errorWithCode:100 object:@{@"error": @"Thao tác không hợp lệ, vui lòng đăng nhập lại!"}]);
        }else{
            failure(task,[self errorWithCode:100 object:@{@"error": error.localizedDescription}]);
            

        }
    }];
}
- (NSURLSessionDataTask *)WGPOST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    return [self POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]){
            success(task,responseObject);
        }else{
            success(task,@{});
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]) {
            failure(task,[self errorWithCode:100 object:@{@"error": @"Không có kết nối mạng!"}]);
        }else if ([error.localizedDescription isEqualToString:@"Request failed: unauthorized (401)"]) {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [WeGoClient saveLoginFlag:NO];
            [WeGoClient saveAccessToken:@""];
      
            failure(task,[self errorWithCode:100 object:@{@"error": @"Thao tác không hợp lệ, vui lòng đăng nhập lại!"}]);
        }else{
            failure(task,[self errorWithCode:100 object:@{@"error": error.localizedDescription}]);
        }
    }];
}

- (NSError *)errorWithCode:(NSInteger)code object:(id)object {
    NSDictionary *userInfo = nil;
    NSString *errorMessage = [object isKindOfClass:[NSDictionary class]] ? object[@"error"] : NSLocalizedString(@"Unexpected error occurred", nil);
    if (!errorMessage) errorMessage = NSLocalizedString(@"Unexpected error occurred", nil);
    
    if (object) {
        userInfo = @{@"object" : object,
                     @"error":errorMessage};
    }
    return [NSError errorWithDomain:@"com.wego" code:code userInfo:object];
}


-(void)getAllService:(void(^)(NSArray *result))success
                    failure:(void(^)(NSError *error))failure
{
    NSString *endPoint = @"/room/booking/search_services";
    
    [self WGGET:endPoint parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        WGSLog(__FUNCTION__, responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WGFLog(__FUNCTION__, error);
        failure(error);
    }];
}
-(void)searchBank:(NSString *)token success:(void(^)(BOOL result))success failure:(void(^)(NSError *error))failure{
    NSString *endpoint = [NSString stringWithFormat:@"/room/booking/search_banks"];
    
    NSDictionary *param = @{
                            @"lat":@(0),
                            @"long":@(0)
                            };
    NSDictionary *param1 = @{
                            @"lat":@(0),
                            @"long":@(0)
                            };
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:param,param1, nil];
    
    [self WGPOST:endpoint parameters:array progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        NSLog(@"Success") ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"fail asdugasduas") ;
    }];
}
-(void)getDataBank:(void(^)(NSArray *result))success
             failure:(void(^)(NSError *error))failure
{
    NSString *endPoint = @"/room/booking/search_bank";
    NSDictionary *param = @{
                            @"branch_id":@"bra_rOPRuaS4LT8MbAcbpi5J"
                            };
    [self WGGET:endPoint parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        WGSLog(__FUNCTION__, responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WGFLog(__FUNCTION__, error);
        failure(error);
    }];
}


#pragma mark - Chat


#pragma mark - Notify
-(void)sendUserToken:(NSString *)token success:(void(^)(BOOL result))success failure:(void(^)(NSError *error))failure{
    NSString *endpoint = [NSString stringWithFormat:@"/api/noti/register"];
    
    NSDictionary *param = @{
                            @"push_token":token?:@"",
                            };
    
    [self WGPOST:endpoint parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([responseObject[@"status"] isEqualToString:@"success"]){
            success(true);
        }else if([responseObject[@"status"] isEqualToString:@"error"]){
            failure([self errorWithCode:100 object:responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WGFLog(__FUNCTION__, error);
        failure(error);
    }];
}


@end
