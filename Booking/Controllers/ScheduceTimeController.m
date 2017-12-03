//
//  ScheduceTimeController.m
//  Booking
//
//  Created by Cau Ca on 11/28/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import "ScheduceTimeController.h"
#import "WCSTimelineCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ScheduceTimeController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview_list;
@property (nonatomic, strong) NSMutableArray * timelineData;
@property NSMutableDictionary *dicPicked ;
@property NSMutableArray *dataPicked ;
@end

@implementation ScheduceTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview_list.dataSource = self ;
    self.tableview_list.delegate = self;
    self.title = @"Chọn khung giờ" ;
    //self.navigationController.navigationBarHidden = true ;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self buildInterface];
    _dicPicked = [[NSMutableDictionary alloc]init];
    _dicPicked = [[NSUserDefaults standardUserDefaults]valueForKey:@"d_dic"];
    NSMutableArray *arr_data_piecked = [_dicPicked valueForKey:@"data"];
    _dataPicked = arr_data_piecked ;
    
}
- (void)buildInterface
{
    //self.title = NSLocalizedString(@"WCSTimeline", nil);
    self.tableview_list.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //  self.refreshControl = [[UIRefreshControl alloc] init];
    //self.tableView.refreshControl = self.refreshControl;
    //[self.refreshControl addTarget:self action:@selector(reloadTimeline) forControlEvents:UIControlEventValueChanged];
    
    [self reloadTimeline];
}
- (NSDate *) chooseDate : (NSInteger )i
{
    NSDate* now = [NSDate date];
    NSDate *date = [self beginningOfDay:now];
    NSDate *add90Min = [date dateByAddingTimeInterval:(30*60*i)];
    
    
    //8-8.5 9 9.5 10 10.5 11 11.5 12 13.5 14 14.5 15 15.5 16 16.5 17 17.5
    return add90Min ;
}
-(NSDate *)beginningOfDay:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
    
    [components setHour:8];
    [components setMinute:0];
    [components setSecond:0];
    [components setDay:15];
    
    
    return [cal dateFromComponents:components];
    
}
- (void)reloadTimeline
{
    self.timelineData = nil;
    self.timelineData = [NSMutableArray new];
    _dicPicked = [[NSUserDefaults standardUserDefaults]valueForKey:@"d_dic"];
    NSMutableArray *arr_data_piecked = [_dicPicked valueForKey:@"data"];
    for ( NSInteger i = 0; i < 16; i++ )
    {
        WCSTimelineModel * model = [WCSTimelineModel new];
        model.icon = [UIImage imageNamed:@"event"];
        NSDate *date =[self chooseDate:i] ;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss";
        
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSString *str_out = [dateFormatter stringFromDate:date];
        model.time = [self chooseDate:i];
        model.event = [NSString stringWithFormat:@"Block %li Time :%@", (long)i ,str_out];
        
        //  NSLog(@"str_out is :%@",str_out);
        if ([self checkStatusCell:arr_data_piecked :str_out ])
        {
            model.state = WCSStateActive ;
        }
        else
        {
            model.state = WCSStateInactive ;
        }
        
        model.content = @"";
        [self.timelineData addObject:model];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"kLastRefresh"];
        //  self.refreshControl.attributedTitle = [self attributedRefreshTitle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //    [self.refreshControl endRefreshing];
            //  [self.tableView reloadData];
        });
    });
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // return 10 ;
    return self.timelineData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCSTimelineModel * model = self.timelineData[indexPath.row];
    return model.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WCSTimelineCell *timelineCell = [tableView cellForRowAtIndexPath:indexPath];
    WCSTimelineModel * model = self.timelineData[indexPath.row];
    if (indexPath.row == self.timelineData.count - 1 ) {
        model.isLast = true;
    }
    if (model.state == WCSStateActive)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Khung giờ đã được chọn" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    else
    {
        model.state = WCSStateActive ;
        timelineCell.model = model;
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"YYYY-MM-dd";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSString *startDate =[dateFormatter stringFromDate:now] ;
        [SVProgressHUD showWithStatus:@"Đang lấy vé. Xin chờ trong giây lát"] ;
        [SVProgressHUD dismissWithDelay:5.0f completion:^{
            NSString *reverseCode = [self getReverseCode:@"Luong The Dung" pdgID:@"a091" serviceID:@"123" phone:@"0936108955" email:@"dunglt@miraway.vn" idCard:@"100973612" startDate:startDate hour:@"08:30"];
            NSString *messageInform = [NSString stringWithFormat:@"Bạn đã booked vé thành công . Mã vé là %@",reverseCode];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:messageInform delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            [alert show];
        }];
        
//        [[NSUserDefaults standardUserDefaults]setObject:model.time forKey:@"d_time"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
       
        //    [[NSUserDefaults standardUserDefaults]setstri:(indexPath.row + 1) forKey:@"key_choose"];
        //    [[NSUserDefaults standardUserDefaults] synchronize] ;
   //     [self.navigationController popViewControllerAnimated:YES] ;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"WCSTimelineCell";
    WCSTimelineCell * timelineCell = timelineCell = [[WCSTimelineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    timelineCell.selectionStyle = UITableViewCellSelectionStyleNone;
    timelineCell.backgroundColor = ( indexPath.row % 2 == 0 ? [self hex:@"f2f1f1" alpha:1.f] : [self hex:@"ffffff" alpha:1.f] );
    
    WCSTimelineModel * model = self.timelineData[indexPath.row];
    if (indexPath.row == self.timelineData.count - 1 ) {
        model.isLast = true;
    }
    
    
    timelineCell.model = model;
    
    return timelineCell;
}
- (BOOL ) checkStatusCell : (NSMutableArray *) dataPicked : (NSString *)timeInput
{
    for (int i = 0 ; i < [dataPicked count] ; i ++)
    {
        NSDictionary *dic = [dataPicked objectAtIndex:i] ;
        NSString *time = [dic valueForKey:@"time"] ;
        NSLog(@"time is : %@ and time_input : %@", time , timeInput);
        if ([time isEqualToString:timeInput])
        {
            return true ;
        }
    }
    return false ;
}
- (UIColor*)hex:(NSString*)hex alpha:(float)alpha
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) return [UIColor grayColor];
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString length] != 6) return  [UIColor grayColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}
#pragma GetTicket
- (NSString *)getReverseCode :(NSString*)fullname pdgID:(NSString*)pdgID serviceID:(NSString*) serviceId phone:(NSString*)phonenumber email: (NSString*)email idCard:(NSString*)idCard startDate :(NSString*) startDate hour : (NSString*)hour
{
   
    
    NSDictionary *dict = @{
                           @"full_name" : fullname,
                           @"branch_id"  : pdgID,
                           @"service_id" : serviceId,
                           @"phone_number" : phonenumber,
                           @"email" : email,
                           @"customer_code" : idCard,
                           @"date" : startDate ,
                           @"time":hour
           
                           };
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        /// NSLog(jsonString);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://123.31.12.147:3000/api/online/booking/create"]];
        
        // Specify that it will be a POST request
        request.HTTPMethod = @"POST";
        
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
    
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:webData options:0 error:&error];
        NSDictionary *dataSer = [jsonDict valueForKey:@"data"] ;
        NSString *reserve_code = [dataSer valueForKey:@"reserve_code"];
        [SVProgressHUD dismiss] ;
       // _id_booking = [dataSer valueForKey:@"id"];
        //   NSLog(@"Log resert : %@" , reserve_code);
        return reserve_code ;
    
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
