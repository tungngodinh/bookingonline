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
@import NSString_Color;
@import AFNetworking;

#import <CoreLocation/CoreLocation.h>
#import "MapsDirectionController.h"
#import "MakerInfoView.h"
#import "ScheduceTimeController.h"
#import "LocationModel.h"
#import "RecentLocationsView.h"

@interface MapsDirectionController ()<GMSMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate>{
    CLLocationManager *locationManager;
@protected BOOL getLocation;

}
@property (nonatomic, strong) NSArray<LocationModel *> *locationsData;
@property (nonatomic, strong) GMSMapView *mapView;
@property CLLocation *myLocation;
@end

@implementation MapsDirectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    self.title = @"Bản đồ các đơn vị thành viên";
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);

    UIAlertController *allert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to Get Your Location" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    _myLocation = [weakSelf.locationsData firstObject].position;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_myLocation.coordinate.latitude
                                                            longitude:_myLocation.coordinate.longitude
                                                                 zoom:40];
    [self.mapView setCamera:camera];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [allert addAction:cancel];
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
    [self showRecentLocations];
}

- (void)loadView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_myLocation.coordinate.latitude
                                                            longitude:_myLocation.coordinate.longitude
                                                                 zoom:12];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.view = self.mapView;
    self.mapView.delegate = self;
    
    FAKIonIcons *icon = [FAKIonIcons iosLocationIconWithSize:40];
    [icon setAttributes:@{NSForegroundColorAttributeName : [@"#4BA157" representedColor]}];
    for (LocationModel* lc in self.locationsData) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.icon = [icon imageWithSize:CGSizeMake(40, 40)];
        marker.position = [lc.position coordinate];
        marker.title = lc.title;
        marker.snippet = lc.snippet;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = self.mapView;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LocationModel *)estimateRecentLocations {
    double distance = DBL_MAX;
    LocationModel *location;
    for (LocationModel *lc in self.locationsData) {
        double newdistance = [_myLocation distanceFromLocation:lc.position];
        if (distance > newdistance) {
            distance = newdistance;
            location = lc;
        }
    }
    return location;
}

- (void)showRecentLocations {
    CGFloat width = self.view.frame.size.width * 0.8;
    RecentLocationsView *view = [[RecentLocationsView alloc] initWithFrame:CGRectMake(0, 0, width, 300)];
    LocationModel *location = [self estimateRecentLocations];
    [view setSnippet:location.snippet phone:@"19001900" distance:[_myLocation distanceFromLocation:location.position] / 1000 estimateWidth:width];
    CGFloat x = (self.view.frame.size.width - width) / 2;
    CGFloat y = self.view.frame.size.height - view.frame.size.height - 5;
    view.frame = CGRectMake(x, y, view.frame.size.width, view.frame.size.height);
    __weak typeof(self) weakSelf = self;
    view.viewTappedBlock = ^{
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.position.coordinate.latitude
                                                                longitude:location.position.coordinate.longitude
                                                                     zoom:15];
        [weakSelf.mapView setCamera:camera];
        [weakSelf getDirect:location.position block:^(GMSMutablePath *path) {
            GMSPolyline *line = [GMSPolyline polylineWithPath:path];
            line.map = weakSelf.mapView;
            line.strokeColor = [UIColor redColor];
            line.strokeWidth = 3.0f;
        }];
    };
    [self.mapView addSubview:view];
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    MakerInfoView *view = [[MakerInfoView alloc] initWithFrame:CGRectMake(0, 0, 200, 140)];
    double distance = [_myLocation distanceFromLocation:[[CLLocation alloc] initWithLatitude:marker.position.latitude longitude:marker.position.longitude]];
    [view setName:marker.title address:marker.snippet peopleCount:2 timeWait:10 distance:distance / 1000];
    return view;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    ScheduceTimeController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduceTimeController"];
    controller.ticketId = 1;
    [self.navigationController showViewController:controller sender:nil];
    
}

- (NSArray<LocationModel *> *)locationsData {
    if (!_locationsData) {
        _locationsData = @[[LocationModel locationWith: @"ATM Techcombank" snippet: @"349 Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam" position: [[CLLocation alloc] initWithLatitude:21.037218 longitude:105.815297]],
                           [LocationModel locationWith: @"ATM Techcombank" snippet: @"91, Nguyễn Chí Thanh, Phường Láng Hạ, Quận Đống Đa, Láng Hạ, Ba Đình, Hà Nội, Việt Nam" position: [[CLLocation alloc] initWithLatitude:21.020003 longitude:105.808728]],
                           [LocationModel locationWith: @"ATM Techcombank" snippet: @"52 Nguyễn Chí Thanh, Láng Thượng, Hà Nội, Việt Nam" position: [[CLLocation alloc]initWithLatitude:21.024392 longitude:105.810554]],
                           [LocationModel locationWith: @"ATM Techcombank" snippet: @"21 Chùa Láng, Láng Thượng, Hà Nội, Việt Nam" position: [[CLLocation alloc]initWithLatitude:21.023014 longitude:105.810554]],
                           [LocationModel locationWith: @"ATM Techcombank" snippet: @"21 Huỳnh Thúc Kháng, Khu tập thể Nam Thành Công, Láng Hạ, Ba Đình, Hà Nội, Việt Nam" position: [[CLLocation alloc]initWithLatitude:21.017801 longitude:105.812087]],
                           [LocationModel locationWith: @"ATM Techcombank" snippet: @"62 Nguyễn Thị Định, Trung Hoà, Cầu Giấy, Hà Nội, Việt Nam" position: [[CLLocation alloc]initWithLatitude:21.008594 longitude:105.812087]],
                           [LocationModel locationWith: @"ATM Techcombank" snippet: @"101 Láng Hạ, Hà Nội, Việt Nam" position: [[CLLocation alloc]initWithLatitude:21.014116 longitude:105.813553]]];
    }
    return _locationsData;
}

- (void)getDirect:(CLLocation *)destination block:(void (^)(GMSMutablePath *))completeBlock {
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@,%@&destination=%@,%@&key=AIzaSyB97VVt35nwQeA3GN7k_Hd6oxzL9QxLnmg", @(_myLocation.coordinate.latitude), @(_myLocation.coordinate.longitude), @(destination.coordinate.latitude), @(destination.coordinate.longitude)];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        id steps = [[responseObject[@"routes"] firstObject][@"legs"] firstObject][@"steps"];
        GMSMutablePath *path = [GMSMutablePath path];
        for (id step in steps) {
            id start = step[@"start_location"];
            CLLocationDegrees lat = [start[@"lat"] doubleValue];
            CLLocationDegrees lng = [start[@"lng"] doubleValue];
            CLLocationCoordinate2D p = CLLocationCoordinate2DMake(lat, lng);
            [path addCoordinate:p];
            id end = step[@"end_location"];
            lat = [end[@"lat"] doubleValue];
            lng = [end[@"lng"] doubleValue];
            p = CLLocationCoordinate2DMake(lat, lng);
            [path addCoordinate:p];
        }
        completeBlock(path);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
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

