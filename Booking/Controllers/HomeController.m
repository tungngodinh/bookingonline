//
//  HomeController.m
//  Booking
//
//  Created by Cau Ca on 11/26/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import SlideMenuControllerOC;
@import GoogleMaps;
@import STPopup;
@import FontAwesomeKit;

#import <CoreLocation/CoreLocation.h>
#import "HomeController.h"
#import "MakerInfoView.h"
#import "ScheduceTime/ScheduceTimeController.h"

@interface HomeController ()<GMSMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
@protected BOOL getLocation ;
}

@property CLLocation *myLocation;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);

    UIAlertController *allert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to Get Your Location" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:allert animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    _myLocation = newLocation;
    if (!getLocation)
    { [self loadView];
        getLocation = TRUE ;
    }
}
- (void)loadView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_myLocation.coordinate.latitude
                                                            longitude:_myLocation.coordinate.longitude
                                                                 zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    mapView.delegate = self;
    
    // Creates a marker in the center of the map.
    NSArray* arrMarkerData = @[
                               @{@"title": @"ATM Techcombank", @"snippet": @"349 Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam", @"position": [[CLLocation alloc]initWithLatitude:21.037218 longitude:105.815297]},
                             @{@"title": @"ATM Techcombank", @"snippet": @"91, Nguyễn Chí Thanh, Phường Láng Hạ, Quận Đống Đa, Láng Hạ, Ba Đình, Hà Nội, Việt Nam", @"position": [[CLLocation alloc]initWithLatitude:21.020003 longitude:105.808728]},
                               @{@"title": @"ATM Techcombank", @"snippet": @"52 Nguyễn Chí Thanh, Láng Thượng, Hà Nội, Việt Nam", @"position": [[CLLocation alloc]initWithLatitude:21.024392 longitude:105.810554]},
                               @{@"title": @"ATM Techcombank", @"snippet": @"21 Chùa Láng, Láng Thượng, Hà Nội, Việt Nam", @"position": [[CLLocation alloc]initWithLatitude:21.023014 longitude:105.810554]},
                               @{@"title": @"ATM Techcombank", @"snippet": @"21 Huỳnh Thúc Kháng, Khu tập thể Nam Thành Công, Láng Hạ, Ba Đình, Hà Nội, Việt Nam", @"position": [[CLLocation alloc]initWithLatitude:21.017801 longitude:105.812087]},
                               @{@"title": @"ATM Techcombank", @"snippet": @"62 Nguyễn Thị Định, Trung Hoà, Cầu Giấy, Hà Nội, Việt Nam", @"position": [[CLLocation alloc]initWithLatitude:21.008594 longitude:105.812087]},
                               @{@"title": @"ATM Techcombank", @"snippet": @"101 Láng Hạ, Hà Nội, Việt Nam", @"position": [[CLLocation alloc]initWithLatitude:21.014116 longitude:105.813553]},
                               ];
    /*1. ATM Techcombank
     349 Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam
     21.037218, 105.815297
     
     2. ATM Techcombank
     91, Nguyễn Chí Thanh, Phường Láng Hạ, Quận Đống Đa, Láng Hạ, Ba Đình, Hà Nội, Việt Nam
     21.020003, 105.808728
     
     3. Techcombank
     52 Nguyễn Chí Thanh, Láng Thượng, Hà Nội, Việt Nam
     21.024392, 105.810554
     
     4. Techcombank
     21 Chùa Láng, Láng Thượng, Hà Nội, Việt Nam
     21.023014, 105.800926
     
     5. Techcombank Huỳnh Thúc Kháng
     21 Huỳnh Thúc Kháng, Khu tập thể Nam Thành Công, Láng Hạ, Ba Đình, Hà Nội, Việt Nam
     21.017801, 105.812087
     
     6. Techcombank
     62 Nguyễn Thị Định, Trung Hoà, Cầu Giấy, Hà Nội, Việt Nam
     21.008594, 105.804751
     
     7. Techcombank
     101 Láng Hạ, Hà Nội, Việt Nam
     21.014116, 105.813553

     */
    
    FAKIonIcons *icon = [FAKIonIcons iosLocationIconWithSize:40];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]}];
    for (NSDictionary* dict in arrMarkerData)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.icon = [icon imageWithSize:CGSizeMake(40, 40)];
        marker.position = [(CLLocation*)dict[@"position"] coordinate];
        marker.title = dict[@"title"];
        marker.snippet = dict[@"snippet"];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = mapView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    MakerInfoView *view = [[MakerInfoView alloc] initWithFrame:CGRectMake(0, 0, 200, 140)];
    [view setName:marker.title address:marker.snippet peopleCount:2 timeWait:10];
    CGSize size = [view systemLayoutSizeFittingSize:CGSizeMake(220, 220) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    view.frame = frame;
    return view;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    ScheduceTimeController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduceTimeController"];
    controller.ticketId = 1;
    [self.navigationController showViewController:controller sender:nil];
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

