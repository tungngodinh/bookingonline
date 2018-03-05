//
//  BookingServiceVC.m
//  Booking
//
//  Created by LuongTheDung on 3/5/18.
//  Copyright © 2018 Cau Ca. All rights reserved.
//

#import "BookingServiceVC.h"

@interface BookingServiceVC ()

@end

@implementation BookingServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testAPI] ;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)testAPI
{
    [[WeGoClient sharedClient]getAllService:^(NSArray *result) {
        NSLog(@"GetAPi success") ;
    } failure:^(NSError *error) {
        NSLog(@"API fail ");
    }];
    [[WeGoClient sharedClient]searchBank:@"" success:^(BOOL result) {
        NSLog(@"GetAPi success search bank") ;
    } failure:^(NSError *error) {
        NSLog(@"API fail ");
    }];
    
    [[WeGoClient sharedClient] getDataBank:^(NSArray *result) {
        NSLog(@"Get data bank success") ;
    } failure:^(NSError *error) {
         NSLog(@"Get data bank fail") ;
    }];
//    WeGoClient *client = [[WeGoClient sharedClient] lo];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
