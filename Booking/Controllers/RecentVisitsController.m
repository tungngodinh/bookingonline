//
//  RecentVisitsController.m
//  Booking
//
//  Created by Cau Ca on 11/30/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import "RecentVisitsController.h"
#import "ServiceCell.h"
#import "ServiceModel.h"
#import "WebViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface RecentVisitsController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<ServiceModel *> *dataSource;

@end

@implementation RecentVisitsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:kServiceCellIdentifier bundle:nil] forCellReuseIdentifier:kServiceCellIdentifier];
    self.title = @"Recent Visits";
    _dataSource = @[[ServiceModel serviceWithName: @"Techcombank Liễu Giai" address: @"349 Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam" peopleCount:2 likeCount:3 distance:1],
                    [ServiceModel serviceWithName: @"Techcombank 91 Nguyễn Chí Thanh" address: @"91, Nguyễn Chí Thanh, Phường Láng Hạ, Quận Đống Đa, Láng Hạ, Ba Đình, Hà Nội, Việt Nam" peopleCount:2 likeCount:3 distance:1],
                    [ServiceModel serviceWithName: @"Techcombank 52 Nguyễn Chí Thanh" address: @"52, Nguyễn Chí Thanh, Phường Láng Hạ, Quận Đống Đa, Láng Hạ, Ba Đình, Hà Nội, Việt Nam" peopleCount:2 likeCount:3 distance:1],
                    [ServiceModel serviceWithName: @"Techcombank 21 Chùa Láng" address: @"21 Chùa Láng, Láng Thượng, Hà Nội, Việt Nam" peopleCount:2 likeCount:3 distance:1],
                    [ServiceModel serviceWithName: @"Techcombank 21 Huỳnh Thúc Kháng" address: @"21 Huỳnh Thúc Kháng, Khu tập thể Nam Thành Công, Láng Hạ, Ba Đình, Hà Nội, Việt Nam" peopleCount:2 likeCount:3 distance:1],
                    [ServiceModel serviceWithName: @"Techcombank 101 Láng Hạ" address: @"101 Láng Hạ, Hà Nội, Việt Nam" peopleCount:2 likeCount:3 distance:1]];
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
    ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:kServiceCellIdentifier forIndexPath:indexPath];
    ServiceModel *model = self.dataSource[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.addressLabel.text = model.address;
    cell.peopleLabel.text = [NSString stringWithFormat:@"%ld", model.peopleCount];
    cell.likeLabel.text = [NSString stringWithFormat:@"%ld", model.likeCount];
    cell.distanceLabel.text = [NSString stringWithFormat:@"~ %.0f km", model.distance];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WebViewController *controller = [WebViewController new];
    controller.link = @"https://www.techcombank.com.vn/";
    [self showViewController:controller sender:nil];
}
-(void)viewWillAppear:(BOOL)animated {
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
