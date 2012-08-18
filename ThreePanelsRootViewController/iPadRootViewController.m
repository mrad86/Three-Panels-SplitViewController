//
//  iPadRootViewController.m
//  ThreePanelsRootViewController
//
//  Created by Miguel on 8/18/12.
//  Copyright (c) 2012 Miguel Rodelas. All rights reserved.
//

#import "iPadRootViewController.h"
#import <QuartzCore/QuartzCore.h>

#define LEFT_VIEW_CONTROLLER_WIDTH      360
#define STREAM_VIEW_CONTROLLER_WIDTH    320
#define STREAM_X_COORDINATES            LEFT_VIEW_CONTROLLER_WIDTH-STREAM_VIEW_CONTROLLER_WIDTH


@interface iPadRootViewController ()
@property (assign, nonatomic) float initialXPos;
@property (nonatomic, retain) UIView *leftView;
@property (nonatomic, retain) UIView *streamView;
@property (nonatomic, retain) UIView *rightView;
@property (nonatomic, retain) UITapGestureRecognizer* menuRecognizer;
@property (nonatomic, retain) UITapGestureRecognizer* rightViewRecognizer;
@end

@implementation iPadRootViewController
@synthesize leftViewController = _leftViewController;
@synthesize rightViewController = _rightViewController;
@synthesize streamViewController = _streamViewController;
@synthesize initialXPos;

@synthesize leftView = _leftView;
@synthesize streamView = _streamView;
@synthesize rightView = _rightView;

@synthesize menuRecognizer;
@synthesize rightViewRecognizer;

- (void)setRightViewController:(UIViewController *)rightViewController
{
    if (_rightViewController != rightViewController)
    {
        if (_rightViewController) {
            [_rightViewController.view removeFromSuperview];
        }
        
        [_rightViewController release];
        _rightViewController = [rightViewController retain];
        
        [_rightView addSubview:_rightViewController.view];
        _rightViewController.view.frame = _rightView.bounds;
        
    }
    
}


- (void)setLeftViewController:(UIViewController *)leftViewController
{
    if ( _leftViewController != leftViewController)
    {
        if (_leftViewController) {
            [_leftViewController.view removeFromSuperview];
        }
        
        [_leftViewController release];
        _leftViewController = [leftViewController retain];
        
        
        if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            _leftViewController.view.frame = CGRectMake(0, 0, LEFT_VIEW_CONTROLLER_WIDTH, 748);
        } else {
            _leftViewController.view.frame = CGRectMake(0, 0, LEFT_VIEW_CONTROLLER_WIDTH, 1004);
        }
        
        [_leftView addSubview:_leftViewController.view];
    }
}

- (void)setStreamViewController:(UIViewController *)streamViewController
{
    if ( _streamViewController != streamViewController)
    {
        if (_streamViewController) {
            [_streamViewController.view removeFromSuperview];
        }
        
        [_streamViewController release];
        _streamViewController = [streamViewController retain];
        
        if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            _streamViewController.view.frame = CGRectMake(0, 0, STREAM_VIEW_CONTROLLER_WIDTH, 748);
        } else {
            _streamViewController.view.frame = CGRectMake(0, 0, STREAM_VIEW_CONTROLLER_WIDTH, 1004);
        }
        
        // Set a shadow effect on the view
        _streamView.layer.masksToBounds = NO;
        //        _streamView.layer.cornerRadius = 4; // if you like rounded corners
        _streamView.layer.shadowOffset = CGSizeMake(-5, 0);
        _streamView.layer.shadowRadius = 10;
        _streamView.layer.shadowOpacity = 1;
        
        [_streamView addSubview:_streamViewController.view];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            self.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, LEFT_VIEW_CONTROLLER_WIDTH, 748)] autorelease];
            self.streamView = [[[UIView alloc] initWithFrame:CGRectMake(STREAM_X_COORDINATES, 0, STREAM_VIEW_CONTROLLER_WIDTH, 748)] autorelease];
            self.rightView = [[[UIView alloc] initWithFrame:CGRectMake(LEFT_VIEW_CONTROLLER_WIDTH, 0, 1024-LEFT_VIEW_CONTROLLER_WIDTH, 748)] autorelease];
//            self.streamView.hidden = NO;
        } else {
            self.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, LEFT_VIEW_CONTROLLER_WIDTH, 1004)] autorelease];
            self.streamView = [[[UIView alloc] initWithFrame:CGRectMake(STREAM_X_COORDINATES, 0, STREAM_VIEW_CONTROLLER_WIDTH, 748)] autorelease];
            self.rightView = [[[UIView alloc] initWithFrame:CGRectMake(LEFT_VIEW_CONTROLLER_WIDTH, 0, 768-LEFT_VIEW_CONTROLLER_WIDTH, 1004)] autorelease];
//            self.streamView.hidden = YES;
        }
        
        
        [self.view insertSubview:self.leftView atIndex:1];
        [self.view insertSubview:self.rightView atIndex:2];
        [self.view insertSubview:self.streamView atIndex:3];
        
        
        UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
		[panRecognizer setMaximumNumberOfTouches:1];
		[panRecognizer setDelaysTouchesBegan:TRUE];
		[panRecognizer setDelaysTouchesEnded:TRUE];
		[panRecognizer setCancelsTouchesInView:TRUE];
        [self.streamView addGestureRecognizer:panRecognizer];
		[panRecognizer release];
        
        // Move stream to the right when clicking on the menu
        self.menuRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openStream)];
		[self.menuRecognizer setDelaysTouchesBegan:TRUE];
		[self.menuRecognizer setDelaysTouchesEnded:TRUE];
		[self.menuRecognizer setCancelsTouchesInView:TRUE];
        [self.leftView addGestureRecognizer:self.menuRecognizer];
		[self.menuRecognizer release];
        
        // Move stream to the left when clicking on the right view
        self.rightViewRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeStream)];
		[self.rightViewRecognizer setDelaysTouchesBegan:TRUE];
		[self.rightViewRecognizer setDelaysTouchesEnded:TRUE];
		[self.rightViewRecognizer setCancelsTouchesInView:FALSE];
		[self.rightViewRecognizer release];
        
    }
    return self;
}

// Drag the stream view to the right/left
- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
	
	CGPoint translatedPoint = [recognizer translationInView:self.view];
	
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.initialXPos = self.streamView.frame.origin.x;
	}
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        float moveToX = translatedPoint.x;
        if (moveToX > LEFT_VIEW_CONTROLLER_WIDTH) {
            moveToX = LEFT_VIEW_CONTROLLER_WIDTH;
        } else if (moveToX < 0) {
            moveToX = initialXPos + translatedPoint.x;
        }
        
        if (moveToX < STREAM_X_COORDINATES) {
            moveToX = STREAM_X_COORDINATES;
        }
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationDelay:0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.streamView.frame = CGRectMake(moveToX,
                                           self.streamView.frame.origin.y,
                                           self.streamView.frame.size.width,
                                           self.streamView.frame.size.height);
        
        [UIView commitAnimations];
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (translatedPoint.x < 0) {
            [self closeStream];
        } else {
            [self openStream];
        }
        
    }
    
}

// Move stream to the right smoothy
- (void) openStream {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.streamView.frame = CGRectMake(LEFT_VIEW_CONTROLLER_WIDTH,
                                       self.streamView.frame.origin.y,
                                       self.streamView.frame.size.width,
                                       self.streamView.frame.size.height);
    
    [UIView commitAnimations];
    
    [self.leftView removeGestureRecognizer:menuRecognizer];
    [self.rightView addGestureRecognizer:self.rightViewRecognizer];
//    [self.rightView findAndResignFirstResponder];
}


// Move stream to the left smoothy
- (void) closeStream {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.streamView.frame = CGRectMake(STREAM_X_COORDINATES,
                                       self.streamView.frame.origin.y,
                                       self.streamView.frame.size.width,
                                       self.streamView.frame.size.height);
    
    [UIView commitAnimations];
    
    [self.leftView addGestureRecognizer:menuRecognizer];
    [self.rightView removeGestureRecognizer:self.rightViewRecognizer];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.rightView.frame = CGRectMake(LEFT_VIEW_CONTROLLER_WIDTH, 0, 768-LEFT_VIEW_CONTROLLER_WIDTH, 1004);
        self.leftView.frame = CGRectMake(0, 0, LEFT_VIEW_CONTROLLER_WIDTH, 1004);
//        self.streamView.hidden = YES;
    } else {
        
        self.leftView.frame = CGRectMake(0, 0, LEFT_VIEW_CONTROLLER_WIDTH, 748);
        self.streamView.frame = CGRectMake(STREAM_X_COORDINATES, 0, STREAM_VIEW_CONTROLLER_WIDTH, 748);
        self.rightView.frame = CGRectMake(LEFT_VIEW_CONTROLLER_WIDTH, 0, 1024-LEFT_VIEW_CONTROLLER_WIDTH, 748);
//        self.streamView.hidden = NO;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end