//
//  BookingServiceVC.m
//  Booking
//
//  Created by LuongTheDung on 3/5/18.
//  Copyright © 2018 Cau Ca. All rights reserved.
//

#import "BookingServiceVC.h"

@interface BookingServiceVC ()
{
    WSCalendarView *calendarView;
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;
}
@property (weak, nonatomic) IBOutlet UIView *scheduleChoose;

@end

@implementation BookingServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    calendarViewEvent = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    calendarViewEvent.calendarStyle = WSCalendarStyleView;
    calendarViewEvent.isShowEvent=true;
    calendarViewEvent.tappedDayBackgroundColor=[UIColor blackColor];
    calendarViewEvent.frame = CGRectMake(0, 0, self.scheduleChoose.frame.size.width, self.scheduleChoose.frame.size.height);
    [calendarViewEvent setupAppearance];
    calendarViewEvent.delegate=self;
    [self.scheduleChoose addSubview:calendarViewEvent];
    
    
    eventArray=[[NSMutableArray alloc] init];
    NSDate *lastDate;
    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
    for (int i=0; i<10; i++) {
        
        if (!lastDate) {
            lastDate=[NSDate date];
        }
        else{
            [dateComponent setDay:1];
        }
        NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:lastDate options:0];
        lastDate=datein;
        [eventArray addObject:datein];
    }
    [calendarViewEvent reloadCalendar];
    
    NSLog(@"%@",[eventArray description]);
    
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
