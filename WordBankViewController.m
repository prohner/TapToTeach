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
#import <stdlib.h>
//#import <time.h>


@implementation WordBankViewController

@synthesize button1, button2, button3, button4, button5, infoButton, text, wordToSpell, wordToSpellLabel;



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


- (void)viewDidAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self reloadWordBankAndStart];
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
	btn.titleLabel.font = [UIFont systemFontOfSize:size * .75];
	
	int height = appDelegate.window.frame.size.height;
	int width = appDelegate.window.frame.size.width;
	int xMargin = 0;
	int yMargin = 100;
	if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft
		|| [[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight
		) {
		height = appDelegate.window.frame.size.width;
		width = appDelegate.window.frame.size.height;
	}
	FUNCTION_LOG(@"width=%i, height=%i", width, height);

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
		//self.view.transform = CGAffineTransformIdentity;
		[self setupScreenDisplay];
	} else {
		//self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
		[self setupScreenDisplay];
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

#pragma mark -
#pragma mark Word Bank Processing

- (void)reloadWordBankAndStart {
	if (popover && popover.popoverVisible) {
		[popover dismissPopoverAnimated:YES];
	}
	[self setupScreenDisplay];
	[self startWordBank];
}

- (void)startWordBank {
	FUNCTION_LOG(@"hi");
	WordBank *lastWordBank = [appDelegate wordBankSettings].lastWordBank;
	if ([[appDelegate wordBanks] containsObject:lastWordBank]) {
		wordBank = lastWordBank;
		words = [[[wordBank words] allObjects] copy];

//		int array[[wordBank.words count]];
//		[wordUsage setc
//		 for (int i = 0; i < [wordBank.words count]; i++) {
//			 wordUsage[i] = 0;
//		 }
		wordUsage = [[NSMutableArray alloc] init];
		FUNCTION_LOG(@"word usage counters:");
		for (int i = 0; i < [wordBank.words count]; i++) {
			FUNCTION_LOG(@"(%i) at %i is %i", wordUsage, i, wordUsage[i]);
		}
		[self nextWord];
	}
}

- (IBAction)nextWord {
	text.text = @"";
	text.placeholder = @"";
	text.backgroundColor = [UIColor clearColor];
	word = nil;
	wordBank = [appDelegate wordBankSettings].lastWordBank;
	words = [[wordBank.words allObjects] mutableCopy];
	int max_attempts = 50;
	
	while (word == nil && --max_attempts) {
		if ([wordUsage count] == [words count]) {
			FUNCTION_LOG(@"Resetting wordUsage array");
			[wordUsage release];
			wordUsage = [[NSMutableArray alloc] init];
		}
		int attempts = [wordBank.words count] + 1;
		while (--attempts) {
			--max_attempts;
			int f = abs(arc4random());
			int idx = f % [wordBank.words count];
			word = [words objectAtIndex:idx];
			FUNCTION_LOG(@"Checking idx == %i (from %i). What about %@?", idx, f, word.word);
			if ( ! [wordUsage containsObject:word]) {
				[wordUsage addObject:word];
				break;
			}
			word = nil;
		}
	}
	
	wordToSpell.text = [word.word lowercaseString];
	[self setButtonLetters];
	[self setButtonsEnabled:YES];
//	FUNCTION_LOG(@"word usage counters:");
//	for (int i = 0; i < [wordBank.words count]; i++) {
//		FUNCTION_LOG(@"(%i) at %i is %i", wordUsage, i, wordUsage[i]);
//	}
	
	
	FUNCTION_LOG(@"%@", wordToSpell.text);
}

- (void)setButtonsEnabled:(BOOL) enabled {
	button1.enabled = enabled;
	button2.enabled = enabled;
	button3.enabled = enabled;
	button4.enabled = enabled;
	button5.enabled = enabled;
}

- (void)setButtonLetters {
	wordBankSettings = [appDelegate wordBankSettings];
	int buttonCount = [wordBankSettings.numberOfTouchpoints intValue];

	char char1 = [wordToSpell.text characterAtIndex:[text.text length]];
	char char2 = char1;
	char char3 = char1;
	char char4 = char1;
	char char5 = char1;
	
	while (char2 == char1 || char3 == char1 || char4 == char1 || char5 == char1 
		|| char3 == char2 || char4 == char2 || char5 == char2 
 	    || char4 == char3 || char5 == char3
		|| char5 == char4
		   ) {
		char2 = 97 + (abs(arc4random()) % 26);
		char3 = 97 + (abs(arc4random()) % 26);
		char4 = 97 + (abs(arc4random()) % 26);
		char5 = 97 + (abs(arc4random()) % 26);
	}

	int i1 = 0;
	int i2 = 0;
	int i3 = 0;
	int i4 = 0;
	int i5 = 0;
	while (i2 == i1 || i3 == i1 || i4 == i1 || i5 == i1
		|| i3 == i2 || i4 == i2 || i5 == i2
		|| i4 == i3 || i5 == i3
		|| i5 == i4
		|| i1 >= buttonCount
		   ) {
		i1 = (abs(arc4random()) % 5);
		i2 = (abs(arc4random()) % 5);
		i3 = (abs(arc4random()) % 5);
		i4 = (abs(arc4random()) % 5);
		i5 = (abs(arc4random()) % 5);
	}

	UIButton *b1;
	UIButton *b2;
	UIButton *b3;
	UIButton *b4;
	UIButton *b5;
	
	switch (i1) {
		case 0:
			b1 = button1;
			break;
		case 1:
			b1 = button2;
			break;
		case 2:
			b1 = button3;
			break;
		case 3:
			b1 = button4;
			break;
		case 4:
			b1 = button5;
			break;
		default:
			break;
	}
	
	switch (i2) {
		case 0:
			b2 = button1;
			break;
		case 1:
			b2 = button2;
			break;
		case 2:
			b2 = button3;
			break;
		case 3:
			b2 = button4;
			break;
		case 4:
			b2 = button5;
			break;
		default:
			break;
	}
	
	switch (i3) {
		case 0:
			b3 = button1;
			break;
		case 1:
			b3 = button2;
			break;
		case 2:
			b3 = button3;
			break;
		case 3:
			b3 = button4;
			break;
		case 4:
			b3 = button5;
			break;
		default:
			break;
	}
	
	switch (i4) {
		case 0:
			b4 = button1;
			break;
		case 1:
			b4 = button2;
			break;
		case 2:
			b4 = button3;
			break;
		case 3:
			b4 = button4;
			break;
		case 4:
			b4 = button5;
			break;
		default:
			break;
	}
	
	switch (i5) {
		case 0:
			b5 = button1;
			break;
		case 1:
			b5 = button2;
			break;
		case 2:
			b5 = button3;
			break;
		case 3:
			b5 = button4;
			break;
		case 4:
			b5 = button5;
			break;
		default:
			break;
	}

	
	[b1 setTitle:[[NSString alloc] initWithFormat:@"%c", char1] forState:UIControlStateNormal];
	[b2 setTitle:[[NSString alloc] initWithFormat:@"%c", char2] forState:UIControlStateNormal];
	[b3 setTitle:[[NSString alloc] initWithFormat:@"%c", char3] forState:UIControlStateNormal];
	[b4 setTitle:[[NSString alloc] initWithFormat:@"%c", char4] forState:UIControlStateNormal];
	[b5 setTitle:[[NSString alloc] initWithFormat:@"%c", char5] forState:UIControlStateNormal];
	
}

- (IBAction)buttonPressed:(id)sender {
	int letterIndex = [text.text length];
	UIButton *button = (UIButton *)sender;
	char letterChosen = [button.titleLabel.text characterAtIndex:0];
	
	if (letterChosen == [wordToSpell.text characterAtIndex:letterIndex]) {
		NSString *l = [[NSString alloc] initWithFormat:@"%c", letterChosen];
		text.text = [text.text stringByAppendingString:l];
		[l release];
	}
	
	//FUNCTION_LOG(@"Checking %@ against target %@", wordToSpell.text
	if ([wordToSpell.text isEqualToString:text.text]) {
//		[self sayWord];
		text.backgroundColor = [UIColor greenColor];
		[self setButtonsEnabled:NO];
		//[self nextWord];
	} else {
		[self setButtonLetters];
	}
}


@end
