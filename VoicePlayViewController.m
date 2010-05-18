    //
//  VoicePlayViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/7/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "VoicePlayViewController.h"
#import "FliteTTS.h"
#import "TapToTeachAppDelegate.h"
#import "SystemSettings.h"

@implementation VoicePlayViewController

@synthesize wordOrPhrase, pitch, variance, speed, voicePicker;
@synthesize pitchValue, varianceValue, speedValue;
@synthesize userName, userNamePhonetic;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		voiceChoices = [[NSMutableArray alloc] init];
		[voiceChoices addObject:@"cmu_us_kal"];
		[voiceChoices addObject:@"cmu_us_kal16"];
		[voiceChoices addObject:@"cmu_us_rms"];
		[voiceChoices addObject:@"cmu_us_awb"];
		[voiceChoices addObject:@"cmu_us_slt"];			

		appDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
//- (void)viewDidLoad {
//    [super viewDidLoad];
- (void)viewDidAppear:(BOOL)animated {
	SystemSettings *s = [appDelegate systemSettings];

	pitch.value = [s.ttsPitch floatValue];
	variance.value = [s.ttsVariance floatValue];
	speed.value = [s.ttsSpeed floatValue];
	
	[self sliderValueChanged:pitch];
	[self sliderValueChanged:variance];
	[self sliderValueChanged:speed];

	NSInteger row = [voiceChoices indexOfObject:s.ttsVoice];
	[voicePicker selectRow:row inComponent:0 animated:YES];
}



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
	
	[fliteEngine setVoice:[voiceChoices objectAtIndex:[voicePicker selectedRowInComponent:0]]];
	[fliteEngine setPitch:[pitch value] variance:[variance value] speed:[speed value]];
	[fliteEngine speakText:wordOrPhrase.text];
}

- (IBAction)sliderValueChanged:(id)sender {
	if (sender == pitch) {
		pitchValue.text = [[NSString alloc] initWithFormat:@"%.2f", pitch.value];
	} else if (sender == variance) {
		varianceValue.text = [[NSString alloc] initWithFormat:@"%.2f", variance.value];
	} else if (sender == speed) {
		speedValue.text = [[NSString alloc] initWithFormat:@"%.2f", speed.value];
	}
	
	[appDelegate systemSettings].ttsPitch = [NSNumber numberWithFloat:pitch.value];
	[appDelegate systemSettings].ttsVariance = [NSNumber numberWithFloat:variance.value];
	[appDelegate systemSettings].ttsSpeed = [NSNumber numberWithFloat:speed.value];
	[appDelegate saveData];
	
}

#pragma mark 
#pragma mark Picker View 
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [voiceChoices objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [voiceChoices count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	[appDelegate systemSettings].ttsVoice = [voiceChoices objectAtIndex:row];
	[appDelegate saveData];
}



@end
