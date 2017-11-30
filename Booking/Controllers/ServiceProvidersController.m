//
//  ServiceProvidersController.m
//  Booking
//
//  Created by Cau Ca on 11/29/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

#import "ServiceProvidersController.h"

@interface ServiceProvidersController ()<UITableViewDataSource, UITableViewDelegate>



@end

@implementation ServiceProvidersController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnServiceList.delegate = self ;
    self.btnServiceList.dataSource = self ;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = @"Dunglt" ;
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Did click : %ld ", indexPath.row);
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
