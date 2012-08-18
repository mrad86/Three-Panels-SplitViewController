//
//  AppDelegate.m
//  ThreePanelsRootViewController
//
//  Created by Miguel on 8/18/12.
//  Copyright (c) 2012 Miguel Rodelas. All rights reserved.
//

#import "AppDelegate.h"

#import "iPadRootViewController.h"
#import "TableViewController.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[iPadRootViewController alloc] initWithNibName:@"iPadRootViewController" bundle:nil];
    
    // Create the menu and stream view controllers
    TableViewController *menuController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    menuController.isMenu = YES;
    TableViewController *streamController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    streamController.isMenu = NO;
    
    // Create the main view controller
    MainViewController *rightController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    // Assign those view controllers to the properties in ipadrootviewcontroller
    self.viewController.leftViewController = menuController;
    self.viewController.streamViewController = streamController;
    self.viewController.rightViewController = rightController;
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
