//
//  TableViewController.h
//  ThreePanelsRootViewController
//
//  Created by Miguel on 8/18/12.
//  Copyright (c) 2012 Miguel Rodelas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (assign, nonatomic) BOOL isMenu;
@end
