Three-Panels-SplitViewController
================================

This project shows how to implement a SplitViewController with three panels (Menu, stream and main view).

Just copy the *iPadRootViewController* to your project. This class has three properties containing the three ViewControllers:


    @property (retain, nonatomic) UIViewController *leftViewController;
    @property (retain, nonatomic) UIViewController *streamViewController;
    @property (retain, nonatomic) UIViewController *rightViewController;

*streamViewController* is a view between the left and the right view controller. The view can be dragged to the right to see the entire menu. When it's on the left side, only the menu icons will be visible.

[Stream closed](https://s3.amazonaws.com/files.droplr.com/files_production/acc_28611/mL0?AWSAccessKeyId=AKIAJSVQN3Z4K7MT5U2A&Expires=1345301099&Signature=Hicn%2B3a2Vk3EcSoovEEYWhNUusw%3D&response-content-disposition=inline%3B+filename%3D%22iOS+Simulator+Screen+shot+Aug+18%2C+2012+4.42.34+PM.png%22)
[Stream opened](https://s3.amazonaws.com/files.droplr.com/files_production/acc_28611/NAat?AWSAccessKeyId=AKIAJSVQN3Z4K7MT5U2A&Expires=1345301162&Signature=kIyCa6EesONAy8lXpdKLtYo%2FsPU%3D&response-content-disposition=inline%3B+filename%3D%22iOS+Simulator+Screen+shot+Aug+18%2C+2012+4.42.39+PM.png%22)

The panels sizes can be controlled changing the values in *iPadRootViewController.m*:

    #define LEFT_VIEW_CONTROLLER_WIDTH      360
    #define STREAM_VIEW_CONTROLLER_WIDTH    320

This project contains an example. In the *AppDelegate* three view controllers are created and assigned to the iPadRootViewController as follows:

    TableViewController *menuController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    TableViewController *streamController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    MainViewController *rightController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    self.viewController.leftViewController = menuController;
    self.viewController.streamViewController = streamController;
    self.viewController.rightViewController = rightController;
