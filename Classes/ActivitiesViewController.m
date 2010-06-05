    //
//  ActivitiesViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/17/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "ActivitiesViewController.h"
#import "WordBankViewController.h"
#import "SettingsViewController.h"
#import "CleanUpViewController.h"

@implementation ActivitiesViewController

@synthesize welcomeLabel, infoButton;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	appDelegate = [[UIApplication sharedApplication] delegate];
	NSString *welcomeMessage = @"Welcome!";
	if ([[[appDelegate systemSettings] userName] isEqualToString:@""]) {
		[welcomeMessage release];
		welcomeMessage = [[NSString alloc] initWithFormat:@"Welcome %@!", [[appDelegate systemSettings] userName]];
	}
	welcomeLabel.text = welcomeMessage;
	[welcomeMessage release];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	FUNCTION_LOG(@"Rotating everything");
	[appDelegate.window layoutSubviews];
//	CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI / 2.0);
//	[wordBankViewController.view setTransform:rotate];
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

#pragma mark -
#pragma mark Activities

- (IBAction)buttonPressedForWordBank:(id)sender {
	[self loadViewController:&wordBankViewController withNibAndClassName:@"WordBankViewController"];
}

- (IBAction)buttonPressedForCleanUp:(id)sender {
	[self loadViewController:&cleanUpViewController withNibAndClassName:@"CleanUpViewController"];
}

//- (IBAction)buttonPressedForVoicePlay:(id)sender {
//	[self loadViewController:&voicePlayViewController withNibAndClassName:@"VoicePlayViewController"];
//}

- (IBAction)infoButtonPressed:(id)sender {
	SettingsViewController *ctrl = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
	//ctrl.wordBankViewController = self;
	UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:ctrl] autorelease];
	popover = [[NSClassFromString(@"UIPopoverController") alloc] initWithContentViewController:navController];
	//[popover setPopoverContentSize:CGSizeMake(320, 550)];
	
	CGRect popoverRect = infoButton.frame;
	//CGRect popoverRect = [self.view convertRect:[categoriesTextField frame] fromView:[categoriesTextField superview]];
	//popoverRect.size.width = MIN(popoverRect.size.width, 100); // the text field is actually really big
	
	[popover presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


- (void)loadViewController:(ActivityViewController **)ctrl withNibAndClassName:(NSString *)nibAndClassName {
	[(*ctrl) release];
	
	Class c = NSClassFromString(nibAndClassName);
	*ctrl = [[c alloc] initWithNibName:nibAndClassName bundle:nil];
	[(*ctrl).view setFrame:self.view.bounds];
	(*ctrl).activitiesViewController = self;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
//	[self.view addSubview:(*ctrl).view];
	
	[appDelegate.window addSubview:(*ctrl).view];
	[appDelegate.activitiesViewController.view removeFromSuperview];
	[UIView commitAnimations];
}


@end
