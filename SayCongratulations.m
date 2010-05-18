//
//  SayCongratulations.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/7/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "SayCongratulations.h"
#import "FliteTTS.h"

@implementation SayCongratulations

- (void)run {
	[super run];

	float speed;
	NSString *wordToSay;
	
	switch (arc4random() % 5) {
		case 4:
			wordToSay = @"Terrific";
			speed = 1.0;
			break;
		case 3:
			wordToSay = @"Awesome";
			speed = 1.0;
			break;
		case 2:
			wordToSay = @"Great work";
			speed = 1.37;
			break;
		case 1:
			wordToSay = @"Great job";
			speed = 1;
			break;
		case 0:
			wordToSay = @"Congratulations";
			speed = 1;
			break;
		default:
			break;
	}
	
//	FliteTTS *fliteEngine = [[FliteTTS alloc] init];
//	[fliteEngine setPitch:125.0 variance:11.0 speed:speed];
//	[fliteEngine speakText:wordToSay];

	FliteTTS *fliteEngine = [[FliteTTS alloc] init];
	
	SystemSettings *s = [appDelegate systemSettings];
	[fliteEngine setPitch:[s.ttsPitch floatValue] variance:[s.ttsVariance floatValue] speed:speed];
	[fliteEngine setVoice:s.ttsVoice];
	[fliteEngine speakText:wordToSay];
	
	//[fliteEngine release];
	
	[self endRun];
}

@end
