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
        [_dataSource addObject:[TicketModel tickeWithCode:[NSString stringWithFormat:@"BKO000%ld", i] status:i%3 branch:@"90, Đường Có Tên, Phố Có Tên, Hà nội" time:[self.dateFormater dateFromString:[NSString stringWithFormat:@"%ld/11/2017 10:11", i]]]];
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
            cell.statusLabel.text = @"Watting";
            cell.statusLabel.textColor = [UIColor redColor];
            break;
        }
        case 1: {
            cell.statusLabel.text = @"Inprogess";
            cell.statusLabel.textColor = [@"#4BA157" representedColor];
            break;
        }
        case 2: {
            cell.statusLabel.text = @"Cancel";
            cell.statusLabel.textColor = [UIColor lightGrayColor];
            break;
        }
        default:
            break;
    }
    cell.timeLabel.text = [self.dateFormater stringFromDate:mode.date];
    cell.timeAgoLabel.text = [mode.date formattedAsTimeAgo];
    return cell;
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
