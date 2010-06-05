    //
//  Congratulations.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/6/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "Congratulations.h"
#import "SystemSettings.h"

@implementation Congratulations

+ (NSString *)pickCongratulationsClassString {
	NSString *class;
	NSMutableArray *congratsClasses = [[NSMutableArray alloc] init];
	TapToTeachAppDelegate *appDelegate= [[UIApplication sharedApplication] delegate];

	SystemSettings *ss = [appDelegate systemSettings];

	if (ss.giveAudioCongratulations) {
		[congratsClasses addObject:@"SayCongratulations"];
		[congratsClasses addObject:@"PlaySoundFile"];
	}
	
	if (ss.giveVisualCongratulations) {
		[congratsClasses addObject:@"SimpleFlashing"];
		[congratsClasses addObject:@"BouncingBall"];
	}
	
	class = [congratsClasses objectAtIndex:arc4random() % [congratsClasses count]];
	FUNCTION_LOG(@"congrats with %@", class);
	[congratsClasses release];
	
	return class;
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
