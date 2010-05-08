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
	
	switch (arc4random() % 3) {
		case 2:
			wordToSay = @"Really good work";
			speed = 1.80;
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
	
	FliteTTS *fliteEngine = [[FliteTTS alloc] init];
	[fliteEngine setPitch:125.0 variance:11.0 speed:speed];
	[fliteEngine speakText:wordToSay];
	
	//[fliteEngine release];
	
	[self endRun];
}

@end
