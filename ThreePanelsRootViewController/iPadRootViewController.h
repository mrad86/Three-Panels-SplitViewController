//
//  iPadRootViewController.h
//  ThreePanelsRootViewController
//
//  Created by Miguel on 8/18/12.
//  Copyright (c) 2012 Miguel Rodelas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPadRootViewController : UIViewController

@property (retain, nonatomic) UIViewController *leftViewController;
@property (retain, nonatomic) UIViewController *streamViewController;
@property (retain, nonatomic) UIViewController *rightViewController;

- (void) openStream;
- (void) closeStream;

@end
