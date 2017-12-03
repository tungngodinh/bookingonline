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
    cell.serviceTypeLabel.text = [self serviceTypeString:model.serviceType];
    return cell;
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

- (void)didChoseService:(NSInteger)seriveType timeIndex:(NSInteger)index {
    self.dataSource[index].serviceType = seriveType;
    [self.tableView reloadData];
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
