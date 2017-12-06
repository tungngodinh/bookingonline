//
//  ChooseBranchController.m
//  Booking
//
//  Created by Cau Ca on 12/3/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import STPopup;

#import "ChooseBranchController.h"
#import "BranchCell.h"
#import "MyFeedBackVC.h"

@interface ChooseBranchController ()<UITableViewDataSource, UITableViewDelegate>;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChooseBranchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Chọn chi nhánh" ;
    // Do any additional setup after loading the view.
    
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (NSString*) stringFromlocationMap : (NSInteger )i
{
    NSString *str = @"";
    switch (i) {
        case 0:
            str = @"349 Đội Cấn, Liễu Giai, Ba Đình, Hà Nội";
            break;
        case 1:
            str = @"91 Nguyễn Chí Thanh, Phường Láng Hạ,Quận Đống Đa, Láng Hạ, Ba Đình";
            break;
        case 2:
            str = @"52 Nguyễn Chí Thanh, Láng Thượng, Hà Nội";
            break;
        case 3:
            str = @"21 Chùa Láng, Láng Thượng, Hà Nội";
            break;
        case 4:
            str = @"21 Huỳnh Thúc Kháng, Khu tập thể Nam Thành Công, Láng Hạ, Ba Đình";
            break;
        case 5:
            str = @"62 Nguyễn Thị Định, Trung Hoà, Cầu Giấy, Hà Nội";
            break;
        case 6:
            str = @"101 Láng Hạ, Hà Nội, Việt Nam";
            break;
        default:
            break;
    }
    return str ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BranchCell *cell = [tableView dequeueReusableCellWithIdentifier:kBranchCellIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"Chi nhánh %@", [self stringFromlocationMap:indexPath.row ]];
<<<<<<< HEAD
    // đoạn này data cho lên nhìn hãm vãi hàng :D 
=======
    // đoạn này data cho lên nhìn hãm vãi hàng :D
>>>>>>> filldata cho chi nhánh %ld
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyFeedBackVC *controller = [storyboard instantiateViewControllerWithIdentifier:@"MyFeedBackVC"];
    controller.contentSizeInPopup = self.contentSizeInPopup;
    [self showViewController:controller sender:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, self.contentSizeInPopup.width, self.contentSizeInPopup.height);
        _tableView = [[UITableView alloc] initWithFrame:frame];
        [_tableView registerNib:[UINib nibWithNibName:kBranchCellIdentifier bundle:nil] forCellReuseIdentifier:kBranchCellIdentifier];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [UIView new];
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
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
