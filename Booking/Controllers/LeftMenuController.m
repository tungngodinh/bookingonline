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
@import STPopup;

#import "MyFeedBackVC.h"
#import "LeftMenuController.h"
#import "MenuHeaderView.h"
#import "ChooseBranchController.h"

@interface LeftMenuController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary<NSString *, UINavigationController *> *controllers;

@end

@implementation LeftMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    CGFloat width = self.slideMenuController.leftContainerView.frame.size.width;
    MenuHeaderView *view = [[MenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, width, width * 0.5)];
    view.backgroundColor = [UIColor redColor];
    [view setUserName:@"Hệ thống đặt vé online" email:@"dunglt@miraway.vn"];
    self.tableView.tableHeaderView = view;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
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
            cell.textLabel.text = @"Hệ thống CN/PGD";
            icon = [FAKIonIcons iosPeopleOutlineIconWithSize:20];
            break;
        }
        case 1: {
            cell.textLabel.text = @"Đặt lịch";
            icon = [FAKIonIcons iosNavigateOutlineIconWithSize:20];
            break;
        }
        case 2: {
            cell.textLabel.text = @"Quản lý lịch đặt";
            icon = [FAKIonIcons androidFavoriteOutlineIconWithSize:20];
            break;
        }
        case 3: {
            cell.textLabel.text = @"Lịch sử giao dịch";
            icon = [FAKIonIcons compassIconWithSize:20];
            break;
        }
        case 4: {
            cell.textLabel.text = @"Phản hồi";
            icon = [FAKIonIcons androidHappyIconWithSize:20];
            break;
        }
        case 5: {
            cell.textLabel.text = @"Giúp đỡ";
            icon = [FAKIonIcons iosHelpOutlineIconWithSize:20];
            break;
        }
        case 6: {
            cell.textLabel.text = @"Về chúng tôi";
            icon = [FAKIonIcons iosInformationOutlineIconWithSize:20];
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
            storyboardid = @"NavMyTicketsController";
            break;
        }
        case 3: {
            storyboardid = @"NavRecentVisitsController";
            break;
        }
        case 4: {
            [self.slideMenuController closeLeft];
            ChooseBranchController *controller = [ChooseBranchController new];
            controller.contentSizeInPopup = CGSizeMake(self.slideMenuController.mainContainerView.bounds.size.width * 0.8, 200);
            STPopupController *popup = [[STPopupController alloc] initWithRootViewController:controller];
            popup.style = STPopupStyleFormSheet;
            [popup presentInViewController:self.slideMenuController.mainViewController];
            return;
        }
        case 5:
        case 6: {
            storyboardid = @"NavWebViewController";
            break;
        }
        default:
            break;
    }
    UINavigationController *nav = [self.controllers objectForKey:storyboardid];
    if (!nav) {
    nav = storyboardid.length > 0 ? [self.storyboard instantiateViewControllerWithIdentifier:storyboardid] : self.storyboard.instantiateInitialViewController;
        [self.controllers setObject:nav forKey:storyboardid];
    }
    FAKIonIcons *icon = [FAKIonIcons naviconIconWithSize:30];
    
    [nav.topViewController addLeftBarButtonWithImage:[icon imageWithSize:CGSizeMake(30, 30)]];
    [self.slideMenuController setMainViewController:nav];
    [self.slideMenuController closeLeft];
}

- (NSMutableDictionary<NSString *, UINavigationController *> *)controllers {
    if (!_controllers) {
        _controllers = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.storyboard.instantiateInitialViewController, @"", nil];
    }
    return _controllers;
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
