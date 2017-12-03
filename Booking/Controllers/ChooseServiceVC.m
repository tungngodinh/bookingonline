//
//  ChooseServiceVC.m
//  Booking
//
//  Created by LuongTheDung on 12/3/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import STPopup;

#import "ChooseServiceVC.h"
#import "ScheduceTimeController.h"

@interface ChooseServiceVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ChooseServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnContinue:(id)sender {
    // Chọn xong dịch vụ thì ấn tiếp tục . Anh đang không biết bố trí UI màn này thế nào cho hợp lý . 
    ScheduceTimeController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduceTimeController"];
        controller.ticketId = 1;
        [self.navigationController showViewController:controller sender:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Mở ATM";
            break;
        case 1:
            cell.textLabel.text = @"Chuyển khoản giao dịch";
            break;
        case 2:
            cell.textLabel.text = @"Vay tín chấp";
            break;
        case 3:
            cell.textLabel.text = @"Nộp tiền vào tài khoản";
            break;
        default:
            break;
    }
    cell.accessoryType = self.selectedService == indexPath.row ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.popupController dismissWithCompletion:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(didChoseService:timeIndex:)]) {
            [self.delegate didChoseService:indexPath.row timeIndex:self.timeIndex];
        }
    }];
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
