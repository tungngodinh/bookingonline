//
//  LeftMenuController.m
//  Booking
//
//  Created by Cau Ca on 11/26/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import FontAwesomeKit;
@import Masonry;
@import SlideMenuControllerOC;
@import NSString_Color;

#import "MyFeedBackVC.h"
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    FAKIonIcons *icon;
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = @"Service Providers";
            icon = [FAKIonIcons iosPeopleOutlineIconWithSize:20];
            break;
        }
        case 1: {
            cell.textLabel.text = @"Maps Direction";
            icon = [FAKIonIcons iosNavigateOutlineIconWithSize:20];
            break;
        }
        case 2: {
            cell.textLabel.text = @"My Tickets";
            icon = [FAKIonIcons androidFavoriteOutlineIconWithSize:20];
            break;
        }
        case 3: {
            cell.textLabel.text = @"Recent Visits";
            icon = [FAKIonIcons compassIconWithSize:20];
            break;
        }
        case 4: {
            cell.textLabel.text = @"FeedBack";
            icon = [FAKIonIcons iosMicIconWithSize:20];
            break;
        }
        default:
            break;
    }
    cell.imageView.image = [icon imageWithSize:CGSizeMake(20, 20)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *storyboardid = @"";
    
    switch (indexPath.row) {
        case 0: {
            
            break;
        }
            
        case 1: {
            storyboardid = @"NavMapsDirectionController";
            break;
        }
        case 2: {
            
            break;
        }
        case 3: {
            
            break;
        }
        case 4: {
            storyboardid = @"NavMyFeedBackVC";
            break;
        }
        default:
            break;
    }
    
    UINavigationController *nav = storyboardid.length > 0 ? [self.storyboard instantiateViewControllerWithIdentifier:storyboardid] : self.storyboard.instantiateInitialViewController;
    FAKIonIcons *icon = [FAKIonIcons naviconIconWithSize:30];
    
    [nav.topViewController addLeftBarButtonWithImage:[icon imageWithSize:CGSizeMake(30, 30)]];
    [self.slideMenuController setMainViewController:nav];
    [self.slideMenuController closeLeft];
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
