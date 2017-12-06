//
//  ScheduceTimeController.m
//  Booking
//
//  Created by Cau Ca on 11/28/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import SVProgressHUD;
@import DateTools;
@import STPopup;

#import "ScheduceTimeController.h"
#import "ChooseServiceVC.h"
#import "ScheduleTimeCell.h"
#import "TicketDetailController.h"

@interface ScheduleTimeModel: NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger serviceType;


+ (ScheduleTimeModel *)scheduleTimeWithDate:(NSDate *)date;

@end

@implementation ScheduleTimeModel

+ (ScheduleTimeModel *)scheduleTimeWithDate:(NSDate *)date {
    ScheduleTimeModel *time = [[ScheduleTimeModel alloc] init];
    time.date = date;
    time.serviceType = -1;
    return time;
}

@end

@interface ScheduceTimeController ()<UITableViewDelegate, UITableViewDataSource, ChooseServiceVCDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<ScheduleTimeModel *> *dataSource;
@property (nonatomic, strong) NSDateFormatter *dayFormater;
@property (nonatomic, strong) NSDateFormatter *hoursFormater;
@property (nonatomic, strong) ScheduleTimeModel *picked ;

@end

@implementation ScheduceTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chọn khung giờ" ;
    
    [self.tableView registerNib:[UINib nibWithNibName:kScheduleTimeCellIdentifier bundle:nil] forCellReuseIdentifier:kScheduleTimeCellIdentifier];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleTimeModel *model = self.dataSource[indexPath.row];
    self.picked = model ;
    if (![self dateIsAvaiable:model.date]) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    ChooseServiceVC *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChooseServiceVC"];
    controller.delegate = self;
    controller.selectedService = model.serviceType;
    controller.timeIndex = indexPath.row;
    controller.contentSizeInPopup = CGSizeMake(self.view.frame.size.width, 300);
    STPopupController *popup = [[STPopupController alloc] initWithRootViewController:controller];
    popup.style = STPopupStyleBottomSheet;
    [popup presentInViewController:self];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:kScheduleTimeCellIdentifier forIndexPath:indexPath];
    ScheduleTimeModel *model = self.dataSource[indexPath.row];
    cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor groupTableViewBackgroundColor] : [UIColor whiteColor];
    cell.maskView.hidden = [self dateIsAvaiable:model.date];
    cell.timeLabel.text = [self.dayFormater stringFromDate:model.date];
    cell.timeBlockLabel.text =  [self.hoursFormater stringFromDate:model.date];
    NSMutableAttributedString *timeblock = [[NSMutableAttributedString alloc] initWithString:@"Khung giờ" attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    NSString *time = [NSString stringWithFormat:@" %@ đến %@", [self.hoursFormater stringFromDate:model.date], [self.hoursFormater stringFromDate:[model.date dateByAddingMinutes:30]]];
    [timeblock appendAttributedString:[[NSAttributedString alloc] initWithString:time attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}]];
    cell.timeBlockLabel.attributedText = timeblock;
//    for (int i = 0 ; i < [_dataPicked count]; i ++)
//    {
//        NSMutableDictionary *data = _dataPicked[i];
//        if ([self checkPicked:[self.hoursFormater stringFromDate:model.date] :data])
//        {
//            [timeblock appendAttributedString:[[NSAttributedString alloc] initWithString:time attributes:@{NSForegroundColorAttributeName : [UIColor redColor]}]];
//            cell.timeBlockLabel.attributedText = timeblock;
//        }
//    }
    

    cell.serviceTypeLabel.text = [self serviceTypeString:model.serviceType];
    return cell;
}
- (BOOL ) checkPicked : (NSString*)timeInput : (NSMutableDictionary*) data_picked
{
    for (int i = 0 ; i < [_dataPicked count]; i ++)
    {
        NSMutableDictionary *data = _dataPicked[i];
        NSString *timeDate = data[@"time"];
        if ([timeInput isEqualToString:timeDate])
        {
            return true ;
        }
    }
    return false ;
}
- (BOOL)dateIsAvaiable:(NSDate *)date {
    return [[date dateByAddingMinutes:30] minutesFrom:[NSDate date]] > 0;
}

- (NSString *)serviceTypeString:(NSInteger)serviceType {
    switch (serviceType) {
        case 0:
            return @"Mở ATM";
        case 1:
            return @"Chuyển khoản giao dịch";
        case 2:
            return @"Vay tín chấp";
        case 3:
            return @"Nộp tiền vào tài khoản";
        default:
            return @"";
    }
}
- (NSMutableArray<ScheduleTimeModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        NSDate *now = [NSDate date];
        NSDate *date = [[NSDate dateWithYear:now.year month:now.month day:now.day] dateByAddingHours:8];
        for (NSInteger i = 0; i < 16; i++) {
            [_dataSource addObject:[ScheduleTimeModel scheduleTimeWithDate:[date dateByAddingMinutes:i*30]]];
        }
    }
    return _dataSource;
}

- (NSDateFormatter *)dayFormater {
    if (!_dayFormater) {
        _dayFormater = [[NSDateFormatter alloc] init];
        _dayFormater.dateStyle = NSDateFormatterMediumStyle;
    }
    return _dayFormater;
}

- (NSDateFormatter *)hoursFormater {
    if (!_hoursFormater) {
        _hoursFormater = [[NSDateFormatter alloc] init];
        _hoursFormater.dateFormat = @"HH:mm";
    }
    return _hoursFormater;
}
- (NSString *)updateTicket : (NSString*)idBooking pdg :(NSString*)idPGD service:(NSString*)serviceID date : (NSString*)date hour: (NSString*)hour {
    NSDictionary *dict = @{
                           @"full_name" : @"Luong The Dung",
                           @"branch_id"  : idPGD,
                           @"service_id" : serviceID,
                           @"phone_number" : @"0936108955",
                           @"email" : @"dunglt@miraway.vn",
                           @"customer_code" : @"100973612",
                           @"date" : date ,
                           @"time":hour ,
                           @"id": idBooking
                           };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
 
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        /// NSLog(jsonString);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://123.31.12.147:3000/api/online/booking/update"]];
        
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
        
        return reserve_code ;
}
- (NSString *)getReverseCode : (NSString*)fullname idPGD : (NSString*)idPDG idService :(NSString*)idService phoneNumber:(NSString*) phoneNumber email :(NSString*)email idCard :(NSString*)idCard hour :(NSString*)hour {
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *startDate =[dateFormatter stringFromDate:now] ;
    
    NSDictionary *dict = @{
                           @"full_name" : fullname,
                           @"branch_id"  : idPDG,
                           @"service_id" : idService,
                           @"phone_number" : phoneNumber,
                           @"email" : email,
                           @"customer_code" : idCard,
                           @"date" : startDate ,
                           @"time":hour
                           };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        return @"Mã phục vụ lỗi . Vui lòng đặt lịch lại" ;
    } else {
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
        NSError *error;
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:webData options:0 error:&error];
        NSDictionary *dataSer = [jsonDict valueForKey:@"data"] ;
        NSString *reserve_code = [dataSer valueForKey:@"reserve_code"];
        [SVProgressHUD dismiss] ;
        return reserve_code ;
    }
}
- (void)didChoseService:(NSInteger)seriveType timeIndex:(NSInteger)index {
    self.dataSource[index].serviceType = seriveType;
    [self.tableView reloadData];
    NSString *typeID = [self serviceTypeString:seriveType];
    [SVProgressHUD showWithStatus:@"Đang lấy vé . Xin chờ trong giây lát"];
    [SVProgressHUD dismissWithCompletion:^{
        NSString *reverseCode = [self getReverseCode:@"Luong The Dung" idPGD:_pgdID idService:typeID phoneNumber:@"0936108955" email:@"dunglt@miraway.vn" idCard:@"100973612" hour:[self.hoursFormater stringFromDate:_picked.date] ];
        NSLog(@"Log reverseCOde: %@ ",reverseCode) ;
        TicketDetailController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TicketDetailController"];
        controller.ticketnumberString = reverseCode ;
        controller.serviceChoose =  typeID ;
        
        [self.navigationController showViewController:controller sender:nil];
    }] ;
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
