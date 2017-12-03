//
//  ChooseServiceVC.m
//  Booking
//
//  Created by LuongTheDung on 12/3/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import "ChooseServiceVC.h"
#import "ScheduceTimeController.h"

@interface ChooseServiceVC ()

@end

@implementation ChooseServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
