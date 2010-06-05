    //
//  ActivityViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/22/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivitiesViewController.h"

@implementation ActivityViewController

@synthesize activitiesViewController;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		appDelegate = [[UIApplication sharedApplication] delegate];
		
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction)quitActivity:(id)sender {
//	if (popover && popover.popoverVisible) {
//		[popover dismissPopoverAnimated:YES];
//	}
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	[appDelegate.window addSubview:activitiesViewController.view];
	[self.view removeFromSuperview];
	[UIView commitAnimations];	
}


@end
