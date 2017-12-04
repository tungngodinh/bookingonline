//
//  TicketDetailController.m
//  Booking
//
//  Created by Cau Ca on 12/3/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import FontAwesomeKit;
@import NSString_Color;

#import "TicketDetailController.h"

@interface TicketDetailController ()

@property (weak, nonatomic) IBOutlet UILabel *ticketNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *branchLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *peopleImage;
@property (weak, nonatomic) IBOutlet UIImageView *waitTimeImage;
@property (weak, nonatomic) IBOutlet UIImageView *branchImage;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;

@end

@implementation TicketDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void)configUI {
    self.title = @"Chi tiết đặt lịch";
    self.ticketNumberLabel.text = self.ticket.ticketNumber ;
    
    FAKIonIcons *icon = [FAKIonIcons iosPeopleOutlineIconWithSize:self.peopleImage.frame.size.width];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    self.peopleImage.image = [icon imageWithSize:self.peopleImage.frame.size];
    
    icon = [FAKIonIcons iosTimeOutlineIconWithSize:self.waitTimeImage.frame.size.width];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    self.waitTimeImage.image = [icon imageWithSize:self.waitTimeImage.frame.size];
    
    icon = [FAKIonIcons homeIconWithSize:self.branchImage.frame.size.width];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    self.branchImage.image = [icon imageWithSize:self.branchImage.frame.size];
    
    icon = [FAKIonIcons printerIconWithSize:25];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIBarButtonItem *print = [[UIBarButtonItem alloc] initWithImage:[icon imageWithSize:CGSizeMake(40, 25)] style:UIBarButtonItemStylePlain target:self action:@selector(onPrintButtontTapped)];
    self.navigationItem.rightBarButtonItem = print;
    //NSLog(@"Ticketnumber is :%@", self.ticket.ticketNumber);
    self.ticketNumberLabel.text = _ticketnumberString;
    self.waitTimeLabel.text = @"~3 minute waiting";
    self.peopleCountLabel.text = @"~1000 waiting";
    self.branchLabel.text = self.ticket.branch;
    
    switch (self.ticket.status) {
        case 0: {
            self.statusLabel.text = @"Chờ xử lý";
            self.statusLabel.textColor = [UIColor redColor];
            icon = [FAKIonIcons iosTimeOutlineIconWithSize:self.statusImage.frame.size.width];
            [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]}];
            break;
            
    }
        case 1: {
            self.statusLabel.text = @"Đang làm việc";
            self.statusLabel.textColor = [@"#4BA157" representedColor];
            icon = [FAKIonIcons loadAIconWithSize:self.statusImage.frame.size.width];
            [icon setAttributes:@{NSForegroundColorAttributeName : [@"#4BA157" representedColor]}];
            break;
        }
        case 2: {
            self.statusLabel.text = @"Hủy";
            self.statusLabel.textColor = [UIColor lightGrayColor];
            icon = [FAKIonIcons iosCloseOutlineIconWithSize:self.statusImage.frame.size.width];
            [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
            break;
        }
        default: {
            self.statusLabel.text = @"Hoàn thành";
            self.statusLabel.textColor = [@"#76D6FF" representedColor];
            icon = [FAKIonIcons iosCheckmarkOutlineIconWithSize:self.statusImage.frame.size.width];
            [icon setAttributes:@{NSForegroundColorAttributeName : [@"#76D6FF" representedColor]}];
            break;
        }
    }
    self.statusImage.image = [icon imageWithSize:self.statusImage.frame.size];
    
    icon = [FAKIonIcons iosArrowBackIconWithSize:25];
    [icon setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[icon imageWithSize:CGSizeMake(40, 25)] style:UIBarButtonItemStylePlain target:self action:@selector(onBackButtonTapped)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)onBackButtonTapped {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)onPrintButtontTapped {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
