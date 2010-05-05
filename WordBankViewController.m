    //
//  WordBankViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 4/27/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "WordBankViewController.h"
#import "Utility.h"
#import "WordBankSettingsViewController.h"

@implementation WordBankViewController

@synthesize button1, button2, button3, button4, button5, infoButton, text, wordToSpell;



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		appDelegate = [[UIApplication sharedApplication] delegate];

		text.text = @"Your text here";
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupScreenDisplay];
}

- (void) setupScreenDisplay {
	[self initButton:button1 at:1];
	[self initButton:button2 at:2];
	[self initButton:button3 at:3];
	[self initButton:button4 at:4];
	[self initButton:button5 at:5];

	wordBankSettings = [appDelegate wordBankSettings];
	FUNCTION_LOG(@"%i", wordBankSettings.lastWordBank);
	if (! wordBankSettings.lastWordBank) {
		wordToSpell.text = @"<== Tap info button to add/choose a word bank";
	}
}

- (UIButton *)initButton:(UIButton *)btn at:(int)index {
	wordBankSettings = [appDelegate wordBankSettings];
	int buttonCount = [wordBankSettings.numberOfTouchpoints intValue];
	if (index <= buttonCount) {
		btn.hidden = NO;
	} else {
		btn.hidden = YES;
		return btn;
	}

	int size = [wordBankSettings.touchpointSize intValue];
	//UIDeviceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];
	
	int height = appDelegate.window.frame.size.height;
	int width = appDelegate.window.frame.size.width;
	int xMargin = 0;
	int yMargin = 100;

	if (buttonCount == 1 && index == 1) {
		int x = width / 2 - size / 2 - xMargin;
		int y = height / 2 - size / 2 - yMargin;
		[btn setFrame:CGRectMake(x + xMargin + yMargin, y, size, size)];
	}

	if (buttonCount == 2 && (index == 1 || index == 2)) {
		float halfScreenWidth = width / 2 - xMargin;
		int x, y;
		switch (index) {
			case 1:
				x = halfScreenWidth / 2 - size / 2;
				y = height / 2 - size / 2;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			case 2:
				x = (halfScreenWidth / 2 - size / 2) + halfScreenWidth;
				y = height / 2 - size / 2;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			default:
				break;
		}
	}
	
	if (buttonCount == 3 && (index == 1 || index == 2 || index == 3)) {
		float halfScreenWidth = width / 2 - xMargin;
		float halfScreenHeight = height / 2 - yMargin;
		int x, y;
		switch (index) {
			case 1:
				x = halfScreenWidth / 2 - size / 2;
				y = (halfScreenHeight / 2 - size / 2) + halfScreenHeight;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			case 2:
				x = (width / 2 - size / 2);
				y = halfScreenHeight / 2 - size / 2;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			case 3:
				x = (halfScreenWidth / 2 - size / 2) + halfScreenWidth;
				y = (halfScreenHeight / 2 - size / 2) + halfScreenHeight;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			default:
				break;
		}
	}
	
	if (buttonCount == 4 && (index == 1 || index == 2 || index == 3 || index == 4)) {
		float halfScreenWidth = width / 2 - xMargin;
		float halfScreenHeight = height / 2 - yMargin;
		int x, y;
		switch (index) {
			case 1:
				x = halfScreenWidth / 2 - size / 2;
				y = (halfScreenHeight / 2 - size / 2) + halfScreenHeight;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			case 2:
				x = halfScreenWidth / 2 - size / 2;
				y = halfScreenHeight / 2 - size / 2;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			case 3:
				x = (halfScreenWidth / 2 - size / 2) + halfScreenWidth;
				y = halfScreenHeight / 2 - size / 2;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			case 4:
				x = (halfScreenWidth / 2 - size / 2) + halfScreenWidth;
				y = (halfScreenHeight / 2 - size / 2) + halfScreenHeight;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			default:
				break;
		}
	}
	
	if (buttonCount == 5) {
		float halfScreenWidth = width / 2 - xMargin;
		float halfScreenHeight = height / 2 - yMargin;
		int x, y;
		switch (index) {
			case 1:
				x = halfScreenWidth / 2 - size / 2;
				y = (halfScreenHeight / 2 - size / 2) + halfScreenHeight;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			case 2:
				x = halfScreenWidth / 2 - size / 2;
				y = halfScreenHeight / 2 - size / 2;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			case 3:
				x = (halfScreenWidth / 2 - size / 2) + halfScreenWidth;
				y = halfScreenHeight / 2 - size / 2;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			case 4:
				x = (halfScreenWidth / 2 - size / 2) + halfScreenWidth;
				y = (halfScreenHeight / 2 - size / 2) + halfScreenHeight;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			case 5:
				x = width / 2 - size / 2 - xMargin;
				y = height / 2 - size / 2 - yMargin;
				[btn setFrame:CGRectMake(x + xMargin, y + yMargin, size, size)];
				break;
			default:
				break;
		}
	}
	
	
	
	return btn;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	FUNCTION_LOG("rotating");
	/*
	 UIInterfaceOrientationPortrait
	 UIInterfaceOrientationPortraitUpsideDown
	 UIInterfaceOrientationLandscapeLeft
	 UIInterfaceOrientationLandscapeRight
	 */
	if (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		self.view.transform = CGAffineTransformIdentity;
	} else {
		self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
	}
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
	WordBankSettingsViewController *ctrl = [[WordBankSettingsViewController alloc] initWithNibName:@"WordBankSettingsViewController" bundle:nil];
	ctrl.wordBankViewController = self;
	UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:ctrl] autorelease];
	popover = [[NSClassFromString(@"UIPopoverController") alloc] initWithContentViewController:navController];
	//[popover setPopoverContentSize:CGSizeMake(320, 550)];
	
	CGRect popoverRect = infoButton.frame;
	//CGRect popoverRect = [self.view convertRect:[categoriesTextField frame] fromView:[categoriesTextField superview]];
	//popoverRect.size.width = MIN(popoverRect.size.width, 100); // the text field is actually really big
	
	[popover presentPopoverFromRect:popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)quitWordBank:(id)sender {
	if (popover && popover.popoverVisible) {
		[popover dismissPopoverAnimated:YES];
	}

	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
	[self.view removeFromSuperview];
	[UIView commitAnimations];	
}

- (void)reloadWordBankAndStart {
	if (popover && popover.popoverVisible) {
		[popover dismissPopoverAnimated:YES];
	}
	[self setupScreenDisplay];
	[self startWordBank];
}

- (void)startWordBank {
}

@end
