//
//  MyTicketsController.m
//  Booking
//
//  Created by Cau Ca on 12/1/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import "MyTicketsController.h"

@interface MyTicketsController ()<UITableViewDataSource, UITabBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation MyTicketsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"My tickets";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
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
