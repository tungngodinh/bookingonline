//
//  AppDelegate.m
//  Booking
//
//  Created by Cau Ca on 11/26/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import SlideMenuControllerOC;
@import FontAwesomeKit;
@import GoogleMaps;
@import GooglePlaces;
@import NSString_Color;

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupSlideMenu];
    [self setupGoogleMapSDK];
    [[UINavigationBar appearance] setBarTintColor: [UIColor redColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    return YES;
}

- (void)setupGoogleMapSDK {
    static NSString *ggAPIKey = @"AIzaSyANc7efkSb78I2Rl_Ak-OvMf3iv0EcNP1c";
    [GMSServices provideAPIKey:ggAPIKey];
    [GMSPlacesClient provideAPIKey:ggAPIKey];
}

- (void)setupSlideMenu {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *leftMenu = [storyboard instantiateViewControllerWithIdentifier:@"LeftMenuController"];
    UINavigationController *home = storyboard.instantiateInitialViewController;
    FAKIonIcons *icon = [FAKIonIcons naviconIconWithSize:30];
    [home.topViewController addLeftBarButtonWithImage:[icon imageWithSize:CGSizeMake(30, 30)]];
    SlideMenuController *slide = [[SlideMenuController alloc] initWithMainViewController:home leftMenuViewController:leftMenu];
    slide.option.panFromBezel = NO;
    
    self.window.rootViewController = slide;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
