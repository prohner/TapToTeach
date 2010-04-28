    //
//  WordBankViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 4/27/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "WordBankViewController.h"
#import "Utility.h"

@implementation WordBankViewController

@synthesize button1, button2, button3, button4, button5, infoButton, text;


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
	MEMORY_LOG();
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.button1 = nil;
	self.button2 = nil;
	self.button3 = nil;
	self.button4 = nil;
	self.button5 = nil;
	self.infoButton = nil;
	self.text = nil;
	
}


- (void)dealloc {
	MEMORY_LOG();
	[button1 release];
	[button2 release];
	[button3 release];
	[button4 release];
	[button5 release];
	
	[infoButton release];
	[text release];
    [super dealloc];
}

- (IBAction)infoButtonPressed:(id)sender {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	[self.view removeFromSuperview];
	[UIView commitAnimations];	
}

@end
