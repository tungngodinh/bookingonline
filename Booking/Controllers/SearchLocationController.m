//
//  SearchLocationController.m
//  Booking
//
//  Created by Cau Ca on 12/6/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import FontAwesomeKit;

#import "SearchLocationController.h"

@interface SearchLocationController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) NSArray<ServiceModel *> *dataSource;

@end

@implementation SearchLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.backButton setImage:[[FAKIonIcons iosArrowLeftIconWithSize:25] imageWithSize:CGSizeMake(25, 25)] forState:UIControlStateNormal];
}

- (void)loadFakeData {
    _dataSource = @[[ServiceModel serviceWithName: @"Techcombank Liễu Giai" address: @"349 Đội Cấn, Liễu Giai, Ba Đình, Hà Nội" peopleCount:2 likeCount:3 distance:1],
                    [ServiceModel serviceWithName: @"Techcombank 91 Nguyễn Chí Thanh" address: @"91, Nguyễn Chí Thanh, Phường Láng Hạ, Quận Đống Đa, Láng Hạ, Ba Đình, Hà Nội" peopleCount:2 likeCount:3 distance:1],
                    [ServiceModel serviceWithName: @"Techcombank 52 Nguyễn Chí Thanh" address: @"52, Nguyễn Chí Thanh, Phường Láng Hạ, Quận Đống Đa, Láng Hạ, Ba Đình, Hà Nội" peopleCount:2 likeCount:3 distance:1],
                    [ServiceModel serviceWithName: @"Techcombank 21 Chùa Láng" address: @"21 Chùa Láng, Láng Thượng, Hà Nội" peopleCount:2 likeCount:3 distance:1],
                    [ServiceModel serviceWithName: @"Techcombank 21 Huỳnh Thúc Kháng" address: @"21 Huỳnh Thúc Kháng, Khu tập thể Nam Thành Công, Láng Hạ, Ba Đình, Hà Nội" peopleCount:2 likeCount:3 distance:1],
                    [ServiceModel serviceWithName: @"Techcombank 101 Láng Hạ" address: @"101 Láng Hạ, Hà Nội" peopleCount:2 likeCount:3 distance:1]];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    NSMutableArray *indextPahts = [[NSMutableArray alloc] initWithCapacity:_dataSource.count];
    for (NSInteger i = 0; i < _dataSource.count; i++) {
        [indextPahts addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indextPahts withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self loadFakeData];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.detailTextLabel.preferredMaxLayoutWidth = tableView.frame.size.width * 0.8;
        cell.imageView.image = [[FAKIonIcons homeIconWithSize:25] imageWithSize:CGSizeMake(25, 25)];
    }
    ServiceModel *model = _dataSource[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectService:)]) {
        [self.delegate didSelectService:_dataSource[indexPath.row]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
