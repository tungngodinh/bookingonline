//
//  ScheduceTimeController.m
//  Booking
//
//  Created by Cau Ca on 11/28/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import SVProgressHUD;

#import "ScheduceTimeController.h"
#import "WCSTimelineCell.h"
#import "ScheduleTimeCell.h"

@interface ScheduleTimeModel: NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger serviceType;

@end

@interface ScheduceTimeController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ScheduleTimeModel *> *dataSource;

@property (nonatomic, strong) NSMutableArray * timelineData;
@property NSMutableDictionary *dicPicked ;
@property NSMutableArray *dataPicked ;

@end

@implementation ScheduceTimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chọn khung giờ" ;
    
    [self.tableView registerNib:[UINib nibWithNibName:kScheduleTimeCellIdentifier bundle:nil] forCellReuseIdentifier:kScheduleTimeCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:kScheduleTimeCellIdentifier forIndexPath:indexPath];
    cell.containerView.backgroundColor = indexPath.row % 2 == 0 ? [UIColor groupTableViewBackgroundColor] : [UIColor whiteColor];
    cell.maskView.hidden = indexPath.row < 6;

    return cell;
}

- (NSMutableArray<ScheduleTimeModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 16; i++) {
            
        }
    }
    return _dataSource;
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
