//
//  MyFeedBackVC.m
//  Booking
//
//  Created by LuongTheDung on 11/29/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import STPopup;

#import "MyFeedBackVC.h"

@interface MyFeedBackVC ()
@property int variable_check ;
@end

@implementation MyFeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _variable_check = 0 ;
    
    self.title = @"Feed back";
    [self viewDidLayoutSubviews];
    CGSize size = [self.view systemLayoutSizeFittingSize:self.contentSizeInPopup withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, size.width, size.height);
    self.contentSizeInPopup = size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnAgree:(id)sender {
    if (_variable_check == 0){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Cảm ơn bạn đã bình chọn cho dịch vụ của chúng tôi" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Đồng Ý" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            _variable_check = 1 ;
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Huỷ Bỏ" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            _variable_check = 0 ;
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Bạn có muốn thay đổi bình chọn chất lượng dịch vụ" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Đồng Ý" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            _variable_check = 0 ;
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Huỷ Bỏ" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            _variable_check = 1 ;
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
   
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
