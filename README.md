Three-Panels-SplitViewController
================================

This project shows how to implement a SplitViewController with three panels (Menu, stream and main view).

Just copy the *iPadRootViewController* to your project. This class has three properties containing the three ViewControllers:

<code>
@property (retain, nonatomic) UIViewController *leftViewController;

@property (retain, nonatomic) UIViewController *streamViewController;

@property (retain, nonatomic) UIViewController *rightViewController;
</code>

*streamViewController* is a view between the left and the right view controller. The view can be dragged to the right to see the entire menu. When it's on the left side, only the menu icons will be visible.

The panels sizes can be controlled changing the values in *iPadRootViewController.m*:

<code>
#define LEFT_VIEW_CONTROLLER_WIDTH      360
#define STREAM_VIEW_CONTROLLER_WIDTH    320
</code>

This project contains an example. In the *AppDelegate* three view controllers are created and assigned to the iPadRootViewController:

<code>
    TableViewController *menuController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];

    TableViewController *streamController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    
    MainViewController *rightController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    self.viewController.leftViewController = menuController;
    self.viewController.streamViewController = streamController;
    self.viewController.rightViewController = rightController;
</code>