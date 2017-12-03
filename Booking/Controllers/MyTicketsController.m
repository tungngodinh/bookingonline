//
//  MyTicketsController.m
//  Booking
//
//  Created by Cau Ca on 12/1/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import NSString_Color;

#import "MyTicketsController.h"
#import "TicketCell.h"
#import "TicketModel.h"
#import "NSDate+TimeAgo.h"

@interface MyTicketsController ()<UITableViewDataSource, UITabBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<TicketModel *> *dataSource;
@property (nonatomic, strong) NSDateFormatter *dateFormater;

@end

@implementation MyTicketsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"My tickets";
    [self.tableView registerNib:[UINib nibWithNibName:kTiketCellIdentifier bundle:nil] forCellReuseIdentifier:kTiketCellIdentifier];
    _dataSource = [[NSMutableArray alloc] initWithCapacity:20];
    for (NSInteger i = 1; i < 20; i++) {
        [_dataSource addObject:[TicketModel tickeWithCode:[NSString stringWithFormat:@"BKO000%ld", i] status:i%4 branch:@"90, Đường Có Tên, Phố Có Tên, Hà nội" time:[self.dateFormater dateFromString:[NSString stringWithFormat:@"%ld/11/2017 10:11", i]]]];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
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
            cell.statusLabel.text = @"Hủy";
            cell.statusLabel.textColor = [UIColor lightGrayColor];
            break;
        }
        default: {
            cell.statusLabel.text = @"Hoàn thành";
            cell.statusLabel.textColor = [UIColor lightGrayColor];
            break;
        }
    }
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
        [_dataSource removeObjectAtIndex:indexPath.row];
        [tableView endUpdates];
    }];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    delete.backgroundEffect = effect;
    // Chờ xử lý
    if (_dataSource[indexPath.row].status == 0) {
        UITableViewRowAction *cancel = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Hủy" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            _dataSource[indexPath.row].status = 2;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        return @[delete, cancel];
    }
    return @[delete];
}

- (NSDateFormatter *)dateFormater {
    if (!_dateFormater) {
        _dateFormater = [[NSDateFormatter alloc] init];
        _dateFormater.dateFormat = @"dd/MM/yyyy HH:mm";
    }
    return _dateFormater;
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
