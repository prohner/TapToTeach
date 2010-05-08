    //
//  VoicePlayViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/7/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "VoicePlayViewController.h"
#import "FliteTTS.h"

@implementation VoicePlayViewController

@synthesize wordOrPhrase, pitch, variance, speed, voicePicker;


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

- (IBAction)sayWordOrPhrase:(id)sender {
	FliteTTS *fliteEngine = [[FliteTTS alloc] init];
	
	[fliteEngine setPitch:125.0 variance:11.0 speed:1.0];
	[fliteEngine speakText:wordOrPhrase.text];
}

@end
