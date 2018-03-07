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
@import SVProgressHUD;

#import <CoreLocation/CoreLocation.h>
#import "MapsDirectionController.h"
#import "MakerInfoView.h"
#import "ScheduceTimeController.h"
#import "LocationModel.h"
#import "RecentLocationsView.h"
#import "ChooseServiceVC.h"
#import "SearchLocationController.h"

@interface MapsDirectionController ()<GMSMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate, SearchLocationControllerDelegate, UITableViewDelegate , UITableViewDataSource> {
    CLLocationManager *locationManager;
@protected BOOL getLocation;
    __weak IBOutlet UITableView *listOfficer;
    
}
@property (nonatomic, strong) NSArray<LocationModel *> *locationsData;

@property CLLocation *myLocation;
@property NSMutableArray *datapgd1 ;
@property NSMutableArray *datapgd2 ;
@property NSMutableArray *datapgd3 ;
@property NSMutableArray *datapgd4 ;
@property NSMutableArray *datapgd5 ;
@property NSMutableArray *datapgd6 ;
@property NSMutableArray *datapgd7 ;
@property NSMutableDictionary *dataPgd ;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end

@implementation MapsDirectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    self.title = @"Hệ thống CN/PGD";
    
    FAKIonIcons *icon = [FAKIonIcons iosSearchIconWithSize:25];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:[icon imageWithSize:CGSizeMake(25, 25)] style:UIBarButtonItemStylePlain target:self action:@selector(onSearchButtonTapped)];
    self.navigationItem.rightBarButtonItem = searchButton;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return  cell ; 
}
- (void)onSearchButtonTapped {
    SearchLocationController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchLocationController"];
    controller.delegate = self;
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

- (NSMutableArray*) data4pgd : (NSInteger ) i
{
       NSMutableArray *arrayData = [[NSMutableArray alloc]init];
    switch (i) {
         
        case 0:
            arrayData =_datapgd1 ;
            break;
        case 1:
            arrayData =_datapgd2 ;
            break;
        case 2:
            arrayData =_datapgd3 ;
            break;
        case 3:
            arrayData =_datapgd4 ;
            break;
        case 4:
            arrayData =_datapgd5 ;
            break;
        case 5:
            arrayData =_datapgd6 ;
            break;
        case 6:
            arrayData =_datapgd7 ;
            break;
            
        default:
            break;
    }
    return arrayData ;
}
-(void)viewWillAppear:(BOOL)animated
{
    _datapgd1 = [[NSMutableArray alloc]init];
    _datapgd2 = [[NSMutableArray alloc]init];
    _datapgd3 = [[NSMutableArray alloc]init];
    _datapgd4 = [[NSMutableArray alloc]init];
    _datapgd5 = [[NSMutableArray alloc]init];
    _datapgd6 = [[NSMutableArray alloc]init];
    _datapgd7 = [[NSMutableArray alloc]init];
    _datapgd1 = [self getListTimePicked:@"a349"];
    _datapgd2 = [self getListTimePicked:@"a091"] ;
    _datapgd3 = [self getListTimePicked:@"s052"] ;
    _datapgd4 = [self getListTimePicked:@"s021"] ;
    _datapgd5 = [self getListTimePicked:@"s020"] ;
    _datapgd6 = [self getListTimePicked:@"s062"] ;
    _datapgd7 = [self getListTimePicked:@"s101"] ;
    [self loadMapView];
    [SVProgressHUD dismiss];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);

    UIAlertController *allert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to Get Your Location" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [allert addAction:cancel];
    [self presentViewController:allert animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    _myLocation = newLocation;
    [_mapView animateToLocation:CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)];
    
    [_mapView animateToZoom:15];
    [self showRecentLocations];
}
-(NSMutableArray*) getListTimePicked : (NSString *)pdgID{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *startDate =[dateFormatter stringFromDate:now] ;
    int daysToAdd = 1;
    NSDate *tomorrowDate = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    NSString *endDate = [dateFormatter stringFromDate:tomorrowDate];
    NSString *urlAsString = [NSString stringWithFormat:@"http://123.31.12.147:3000/api/online/booking/search?branch_id=%@&start_date=%@&end_date=%@",pdgID,startDate,endDate] ;
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    NSString *jsonString = [[NSString alloc] initWithData:[NSData dataWithData:NULL] encoding:NSUTF8StringEncoding];
    NSString *stringData =  jsonString ;
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;
    // Create url connection and fire request
    //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData *response = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
    NSLog(@"Response: %@",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]);
    NSString *jsonReturn = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding] ;
    NSData *webData = [jsonReturn dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:webData options:0 error:&error];
    NSMutableArray *dataSer = [jsonDict valueForKey:@"data"] ;
    return dataSer ;

}
- (void)loadMapView {
    self.mapView.myLocationEnabled = YES;
   
    self.mapView.delegate = self;
    FAKIonIcons *icon = [FAKIonIcons iosLocationIconWithSize:40];
    for (int i = 0 ; i < [self.locationsData count] ; i ++)
    {
        GMSMarker *marker = [[GMSMarker alloc] init];
        LocationModel *lc = [self.locationsData objectAtIndex:i];
        marker.position = [lc.position coordinate];
        marker.title = lc.title;
        marker.snippet = lc.snippet;
        
        NSMutableArray *data4PDG = [self data4pgd:i];
        NSInteger numberPicket = [data4PDG count] ;
        NSLog(@"Number of ticket pickerd :%ld" , numberPicket);
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = self.mapView;
        if (numberPicket < 2)
        {
            [icon setAttributes:@{NSForegroundColorAttributeName : [@"#4BA157" representedColor]}];
            marker.icon = [icon imageWithSize:CGSizeMake(40, 40)];
        }else if (numberPicket < 12)
        {
            [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]}];
            marker.icon = [icon imageWithSize:CGSizeMake(40, 40)];
        }
        else
        {
            [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
            marker.icon = [icon imageWithSize:CGSizeMake(40, 40)];
        }
        UILabel *labelTag = [[UILabel alloc] init];
        labelTag.tag = i ;
        NSLog(@"Log i :%d" , i);
       // [marker.map addSubview:labelTag];
        marker.map.tag = i ;
    }
    [self showRecentLocations];
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
    if (!_myLocation) {
        return;
    }
    CGFloat width = self.view.frame.size.width * 0.8;
    NSInteger viewtag = 1111;
    RecentLocationsView *view = [[RecentLocationsView alloc] initWithFrame:CGRectMake(0, 0, width, 300)];
    LocationModel *location = [self estimateRecentLocations];
    [view setSnippet:location.snippet phone:@"1800 588 822" distance:[_myLocation distanceFromLocation:location.position] / 1000 estimateWidth:width];
    CGFloat x = (self.view.frame.size.width - width) / 2;
    CGFloat y = self.view.frame.size.height - view.frame.size.height - 5;
    view.frame = CGRectMake(x, y, view.frame.size.width, view.frame.size.height);
    view.tag = viewtag;
    __weak typeof(self) weakSelf = self;
    
    view.viewTappedBlock = ^{
        
        for (UIView *rview in [weakSelf.mapView subviews]) {
            if (rview.tag == viewtag) {
                [rview removeFromSuperview];
            }
        }
        [weakSelf.mapView animateToLocation:CLLocationCoordinate2DMake(location.position.coordinate.latitude, location.position.coordinate.longitude)];
        
        [weakSelf.mapView animateToZoom:15];
        
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
    LocationModel *model = [_locationsData objectAtIndex:marker.map.tag ] ;
    NSLog(@"log :%ld" , marker.map.tag);
    NSString *idPGD = [self idStringPGD:marker.snippet];
    NSLog(@"pgd piecked :%@", model.idPGD) ;
    NSInteger indexPgd = [self getds:idPGD];
    controller.pgdID = idPGD ;
    controller.dataPicked = [self data4pgd:indexPgd] ;
    //controller.hour = model
    [self.navigationController showViewController:controller sender:nil];
    
}
- (NSArray<LocationModel *> *)locationsData {
  
    if (!_locationsData) {
        _locationsData = @[[LocationModel locationWith: @"Chi nhánh Techcombank" snippet: @"349 Đội Cấn, Liễu Giai, Ba Đình, Hà Nội" position: [[CLLocation alloc] initWithLatitude:21.037218 longitude:105.815297] idPGD:@"a349"],
                           [LocationModel locationWith: @"Chi nhánh Techcombank" snippet: @"91, Nguyễn Chí Thanh, Phường Láng Hạ, Quận Đống Đa, Láng Hạ, Ba Đình, Hà Nội" position: [[CLLocation alloc] initWithLatitude:21.020003 longitude:105.808728] idPGD:@"a091"],
                           [LocationModel locationWith: @"Chi nhánh Techcombank" snippet: @"52 Nguyễn Chí Thanh, Láng Thượng, Hà Nội" position: [[CLLocation alloc]initWithLatitude:21.024392 longitude:105.810554] idPGD:@"s052"],
                           [LocationModel locationWith: @"Chi nhánh Techcombank" snippet: @"21 Chùa Láng, Láng Thượng, Hà Nội" position: [[CLLocation alloc]initWithLatitude:21.023014 longitude:105.810554] idPGD:@"s021" ],
                           [LocationModel locationWith: @"Chi nhánh Techcombank" snippet: @"21 Huỳnh Thúc Kháng, Khu tập thể Nam Thành Công, Láng Hạ, Ba Đình, Hà Nội" position: [[CLLocation alloc]initWithLatitude:21.017801 longitude:105.812087]idPGD:@"s020"],
                           [LocationModel locationWith: @"Chi nhánh Techcombank" snippet: @"62 Nguyễn Thị Định, Trung Hoà, Cầu Giấy, Hà Nội" position: [[CLLocation alloc]initWithLatitude:21.008594 longitude:105.812087]idPGD:@"s062"],
                           [LocationModel locationWith: @"Chi nhánh Techcombank" snippet: @"101 Láng Hạ, Hà Nội" position: [[CLLocation alloc]initWithLatitude:21.014116 longitude:105.813553]idPGD:@"s101"]];}
    return _locationsData;
}
- (NSInteger) getds : (NSString*) str_input
{
    if ([str_input isEqualToString:@"a349"]) return 0 ;
    if ([str_input isEqualToString:@"a091"]) return 1 ;
    if ([str_input isEqualToString:@"s052"]) return 2 ;
    if ([str_input isEqualToString:@"s021"]) return 3 ;
    if ([str_input isEqualToString:@"s020"]) return 4 ;
    if ([str_input isEqualToString:@"s062"]) return 5 ;
    if ([str_input isEqualToString:@"s101"]) return 6 ;
    else return 10 ;
}
- (NSString*)idStringPGD : (NSString*)intputString
{
    if ([intputString isEqualToString:@"349 Đội Cấn, Liễu Giai, Ba Đình, Hà Nội"]) return @"a349";
    if ([intputString isEqualToString:@"91, Nguyễn Chí Thanh, Phường Láng Hạ, Quận Đống Đa, Láng Hạ, Ba Đình, Hà Nội"]) return @"a091";
      if ([intputString isEqualToString:@"52 Nguyễn Chí Thanh, Láng Thượng, Hà Nội"]) return @"s052";
      if ([intputString isEqualToString:@"21 Chùa Láng, Láng Thượng, Hà Nội"]) return @"s021";
      if ([intputString isEqualToString:@"21 Huỳnh Thúc Kháng, Khu tập thể Nam Thành Công, Láng Hạ, Ba Đình, Hà Nội"]) return @"s020";
      if ([intputString isEqualToString:@"62 Nguyễn Thị Định, Trung Hoà, Cầu Giấy, Hà Nội"]) return @"s062";
      if ([intputString isEqualToString:@"101 Láng Hạ, Hà Nội"]) return @"s101";
      else return @"" ;
    
    
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

- (GMSMapView *)mapView {
    if (!_mapView) {
        CLLocation *location = _myLocation ? _myLocation : self.locationsData[0].position;
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                                longitude:location.coordinate.longitude
                                                                     zoom:12];
        _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    }
    return _mapView;
}

- (void)didSelectService:(ServiceModel *)service {
    NSInteger index = [self.locationsData indexOfObjectPassingTest:^BOOL(LocationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [obj.snippet containsString:service.address];
    }];
    if (index != NSNotFound) {
        LocationModel *location = self.locationsData[index];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.mapView animateToLocation:CLLocationCoordinate2DMake(location.position.coordinate.latitude, location.position.coordinate.longitude)];
        } completion:^(BOOL finished) {
            [self.mapView animateToZoom:18];
        }];
        
    }
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

