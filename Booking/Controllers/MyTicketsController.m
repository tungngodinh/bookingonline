//
//  MyTicketsController.m
//  Booking
//
//  Created by Cau Ca on 12/1/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import NSString_Color;
@import SVProgressHUD;
@import DZNEmptyDataSet;
@import FontAwesomeKit;

#import "MyTicketsController.h"
#import "TicketCell.h"
#import "TicketModel.h"
#import "NSDate+TimeAgo.h"
#import "TicketDetailController.h"
#import "ScheduceTimeController.h"

@interface MyTicketsController ()<UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<TicketModel *> *dataSource;
@property (nonatomic, strong) NSDateFormatter *dateFormater;

@end

@implementation MyTicketsController

- (void)viewDidLoad {
    [super viewDidLoad];

 
//    dispatch_async(dispatch_get_main_queue(), ^{
//       NSTimer *m_timer = [NSTimer scheduledTimerWithTimeInterval:2.0f
//                                                   target:self
//                                                 selector:@selector(initData)
//                                                 userInfo:nil
//                                                  repeats:NO];
//        [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSRunLoopCommonModes];
//    });
    _dataSource = [[NSMutableArray alloc]init];
    self.title = @"My tickets";
    [self.tableView registerNib:[UINib nibWithNibName:kTiketCellIdentifier bundle:nil] forCellReuseIdentifier:kTiketCellIdentifier];
}
- (void) initData
{
    [self getListTimePicked:@"a349"] ;
    [self getListTimePicked:@"a091"] ;
    [self getListTimePicked:@"s052"] ;
    [self getListTimePicked:@"s021"] ;
    [self getListTimePicked:@"s020"] ;
    [self getListTimePicked:@"s062"] ;
    [self getListTimePicked:@"s101"] ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
-(void) getListTimePicked : (NSString *)pdgID {
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
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            [SVProgressHUD dismiss];
        } else {
            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSMutableArray *dataRespond = [responseDict valueForKey:@"data"] ;
            if ([dataRespond count] > 0)
            {
                for (NSInteger i = 0 ; i < [dataRespond count]; i ++){
                    [_dataSource addObject:[TicketModel tickeWithCode:[NSString stringWithFormat:@"%@", dataRespond[i][@"reserve_code"]] status: [self statusCodeTicket :dataRespond[i][@"state"]]  branch: [self nameFromBrandID:dataRespond[i][@"branch_id"]]  time:[self.dateFormater dateFromString:[NSString stringWithFormat:@"%ld/11/2017 10:11", i] ]idBooking: dataRespond[i][@"id"] serviceID:dataRespond[i][@"service_id"]]];
                }
                NSInteger iz = 21 ;
                 [_dataSource addObject:[TicketModel tickeWithCode:[NSString stringWithFormat:@"%@",@"007"] status: 3  branch:@"Miraway Ticket"  time:[self.dateFormater dateFromString:[NSString stringWithFormat:@"%ld/11/2017 10:11", iz] ]idBooking: @"1001" serviceID:@"Mở ATM"]];
                [_dataSource addObject:[TicketModel tickeWithCode:[NSString stringWithFormat:@"%@",@"009"] status: 1  branch:@"Miraway Ticket"  time:[self.dateFormater dateFromString:[NSString stringWithFormat:@"%ld/11/2017 10:11", iz] ]idBooking: @"1000" serviceID:@"ATM"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
          
        }
    }];
}
- (NSInteger) statusCodeTicket : (NSString*) str_statuscode
{
    if ([str_statuscode isEqualToString:@"created"]) return 0 ;
    else if ([str_statuscode isEqualToString:@"cancelled"]) return 2;
    else return 1 ;
}

- (void)deleteTicket : (NSString *)idBooking {
    NSDictionary *dict = @{
                           @"id" : idBooking
                           };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    /// NSLog(jsonString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://123.31.12.147:3000/api/online/booking/cancel"]];
    
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
    if ([[jsonDict valueForKey:@"status"] isEqualToString:@"error"]){
        
    }
    else{
    }
}
- (NSString *)nameFromBrandID : (NSString*) branchID
{
    if ([branchID isEqualToString:@"a349"]) return @"349 Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam";
    if ([branchID isEqualToString:@"a091"]) return @"91, Nguyễn Chí Thanh, Phường Láng Hạ, Quận Đống Đa, Láng Hạ, Ba Đình, Hà Nội, Việt Nam";
    if ([branchID isEqualToString:@"s052"]) return @"52 Nguyễn Chí Thanh, Láng Thượng, Hà Nội, Việt Nam";
    if ([branchID isEqualToString:@"s021"]) return @"21 Chùa Láng, Láng Thượng, Hà Nội, Việt Nam";
    if ([branchID isEqualToString:@"s020"]) return @"21 Huỳnh Thúc Kháng, Khu tập thể Nam Thành Công, Láng Hạ, Ba Đình, Hà Nội, Việt Nam";
    if ([branchID isEqualToString:@"s062"]) return @"62 Nguyễn Thị Định, Trung Hoà, Cầu Giấy, Hà Nội, Việt Nam";
    if ([branchID isEqualToString:@"s101"]) return @"101 Láng Hạ, Hà Nội, Việt Nam";
    else return @"Chi nhánh Techcom Bank" ;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:kTiketCellIdentifier forIndexPath:indexPath];
    TicketModel *mode = _dataSource[indexPath.row];
    cell.documentCode.text = mode.code;
    switch (mode.status) {
        case 0: {
            cell.statusLabel.text = @"Chờ xử lý";
            cell.statusLabel.textColor = [UIColor redColor];
            break;
        }
        case 1: {
            cell.statusLabel.text = @"Đang làm việc";
            cell.statusLabel.textColor = [@"#4BA157" representedColor];
            break;
        }
        case 2: {
            cell.statusLabel.text = @"Hủy vé";
            cell.statusLabel.textColor = [UIColor lightGrayColor];
            break;
        }
        default: {
            cell.statusLabel.text = @"Hoàn thành";
            cell.statusLabel.textColor = [UIColor lightGrayColor];
            break;
        }
    }
    cell.branchLabel.text = mode.branch;
    cell.timeLabel.text = [self.dateFormater stringFromDate:mode.date];
    cell.timeAgoLabel.text = [mode.date formattedAsTimeAgo];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketModel *model = _dataSource[indexPath.row];
    return model.status == 2 || model.status == 0;
}

-  (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Xóa" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [SVProgressHUD showWithStatus:@"Đang thực hiện xoá vé . Xin chờ trong giây lát"] ;
        [SVProgressHUD dismissWithDelay:4.0f];
        [SVProgressHUD dismissWithCompletion:^{
            TicketModel *ticketModel = [_dataSource objectAtIndex:indexPath.row] ;
            [self deleteTicket:ticketModel.idBooking];
            [SVProgressHUD showWithStatus:@"Đã xoá vé thành công ."] ;
            [SVProgressHUD dismissWithDelay:4.0f];
        }];
        
        [_dataSource removeObjectAtIndex:indexPath.row];
        [tableView endUpdates];
    }];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    delete.backgroundEffect = effect;
    // Chờ xử lý
    if (_dataSource[indexPath.row].status == 0) {
        UITableViewRowAction *cancel = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Đặt lại vé" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            ScheduceTimeController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduceTimeController"];
              TicketModel *ticketModel = [_dataSource objectAtIndex:indexPath.row] ;
            controller.pgdID = ticketModel.branch ;
            controller.typeOfTicket = 1 ;
            controller.idUpdatePGD = ticketModel.branch ;
            controller.idBooking = ticketModel.idBooking;
            
            [self.navigationController showViewController:controller sender:nil];
        }];
        return @[delete, cancel];
    }
    return @[delete];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketDetailController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TicketDetailController"];
    controller.ticket = self.dataSource[indexPath.row];
    [self showViewController:controller sender:nil];
}

- (NSDateFormatter *)dateFormater {
    if (!_dateFormater) {
        _dateFormater = [[NSDateFormatter alloc] init];
        _dateFormater.dateFormat = @"dd/MM/yyyy HH:mm";
    }
    return _dateFormater;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    FAKIonIcons *icon = [FAKIonIcons iosComposeOutlineIconWithSize:80];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    return [icon imageWithSize:CGSizeMake(80, 80)];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [[NSAttributedString alloc] initWithString:@"Bạn chưa có phiếu đặt nào" attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize: 17]}];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self initData];
    [SVProgressHUD dismiss];
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
