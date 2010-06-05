    //
//  CleanUpViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/23/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "CleanUpViewController.h"
#import "CleanUpSettingsViewController.h"
#import "CleanUpView.h"

@implementation CleanUpViewController

@synthesize popover;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

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

- (IBAction)infoButtonPressed:(id)sender {
	FUNCTION_LOG();
	CleanUpSettingsViewController *ctrl = [[CleanUpSettingsViewController alloc] initWithNibName:@"CleanUpSettingsViewController" bundle:nil];
	ctrl.cleanUpViewController = self;
	UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:ctrl] autorelease];
	popover = [[NSClassFromString(@"UIPopoverController") alloc] initWithContentViewController:navController];
	//[popover setPopoverContentSize:CGSizeMake(320, 550)];
	
	//CGRect popoverRect = ((CleanUpView *)self.view).infoButtonView.frame;
	//CGRect popoverRect = [self.view convertRect:[categoriesTextField frame] fromView:[categoriesTextField superview]];
	//popoverRect.size.width = MIN(popoverRect.size.width, 100); // the text field is actually really big
	
	[popover presentPopoverFromRect:[self infoButtonRectangle] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (CGRect)infoButtonRectangle {
	return ((CleanUpView *)self.view).infoButtonView.frame;
}

@end
