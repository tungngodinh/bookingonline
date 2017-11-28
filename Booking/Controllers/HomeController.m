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

#import "HomeController.h"
#import "MakerInfoView.h"
#import "ScheduceTimeController.h"

@interface HomeController ()<GMSMapViewDelegate>

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadView];
}

- (void)loadView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    mapView.delegate = self;
    
    // Creates a marker in the center of the map.
    NSArray* arrMarkerData = @[
                               @{@"title": @"Sydney", @"snippet": @"Australia", @"position": [[CLLocation alloc]initWithLatitude:-33.86 longitude:151.20]},
                               @{@"title": @"Other location", @"snippet": @"other snippet", @"position": [[CLLocation alloc]initWithLatitude:17.398932 longitude:78.472718]}
                               ];
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
    [view setName:marker.title address:@"92a Yet Kieu Stress" peopleCount:2 timeWait:10];
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
