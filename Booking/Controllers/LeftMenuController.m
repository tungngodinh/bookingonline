//
//  LeftMenuController.m
//  Booking
//
//  Created by Cau Ca on 11/26/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import FontAwesomeKit;
@import Masonry;

#import "LeftMenuController.h"

@interface LeftMenuController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation LeftMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    CGFloat width = self.view.frame.size.width;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width / 2)];
    header.backgroundColor = [UIColor colorWithRed:48 green:228 blue:247 alpha:1];
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width * 0.2, width * 0.2)];
    [header addSubview:logo];
    self.tableView.tableHeaderView = header;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    FAKIonIcons *icon;
    switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"Service Providers";
                icon = [FAKIonIcons iosPeopleOutlineIconWithSize:30];
                break;
            }
            case 1: {
                cell.textLabel.text = @"Maps Direction";
                icon = [FAKIonIcons iosNavigateOutlineIconWithSize:30];
                break;
            }
            case 2: {
                cell.textLabel.text = @"My Favourite";
                icon = [FAKIonIcons androidFavoriteOutlineIconWithSize:30];
                break;
            }
            case 3: {
                cell.textLabel.text = @"Recent Visits";
                icon = [FAKIonIcons compassIconWithSize:30];
                break;
            }
        default:
            break;
    }
    cell.imageView.image = [icon imageWithSize:CGSizeMake(30, 30)];
    return cell;
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
