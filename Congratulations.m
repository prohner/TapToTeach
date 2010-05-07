    //
//  Congratulations.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/6/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "Congratulations.h"


@implementation Congratulations

+ (NSString *)pickCongratulationsClassString {
	NSString *class;
	int i = arc4random() % 2;
	switch (arc4random() % 2) {
		case 0:
			class = @"SimpleFlashing";
			break;
		case 1:
			class = @"SimpleFlashing";
			break;
		default:
			break;
	}
}

- (id)initOnRect:(CGRect)rect withDuration:(NSTimeInterval)howLong {
	appDelegate = [[UIApplication sharedApplication] delegate];
	duration = howLong;
	originRect = rect;
	return self;
}

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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
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

- (void)run {
}

- (void)endRun {
	[self performSelector:@selector(endRunAndCleanup) withObject:nil afterDelay:duration];
}

- (void)endRunAndCleanup {
	[self.view removeFromSuperview];
}

@end
