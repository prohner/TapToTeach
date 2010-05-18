//
//  PlaySoundFile.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/17/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "PlaySoundFile.h"
#import <AVFoundation/AVFoundation.h>

@implementation PlaySoundFile

- (void)run {
	[super run];
	
//	float speed;
//	NSString *fileToPlay;
//	
//	
//	switch (arc4random() % 5) {
//		case 4:
//			wordToSay = @"Terrific";
//			speed = 1.0;
//			break;
//		case 3:
//			wordToSay = @"Awesome";
//			speed = 1.0;
//			break;
//		case 2:
//			wordToSay = @"Great work";
//			speed = 1.37;
//			break;
//		case 1:
//			wordToSay = @"Great job";
//			speed = 1;
//			break;
//		case 0:
//			wordToSay = @"Congratulations";
//			speed = 1;
//			break;
//		default:
//			break;
//	}
	
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"HiDaddy" ofType:@"mp3"];
	NSData *data = [NSData dataWithContentsOfFile:soundFilePath];
	AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
	[newPlayer play];
	
	[self endRun];
}
@end
