//
//  BouncingBall.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/17/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "BouncingBall.h"


@implementation BouncingBall

- (void)viewDidLoad {
	[super viewDidLoad];
	NSString *imageFilePath = [[NSBundle mainBundle] pathForResource:@"ball" ofType:@"png"];
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageFilePath];
	ball = [[UIImageView alloc] initWithImage:image];
	[self.view addSubview:ball];
	[image release];
}

- (void)dealloc {
	[ball release];
	[super dealloc];
}

- (void)timerFireMethod:(NSTimer*)theTimer {
	ball.center = CGPointMake(ball.center.x+pos.x,ball.center.y+pos.y);

	int height = self.view.frame.size.height;
	int width = self.view.frame.size.width;
	
	if(ball.center.x > width || ball.center.x < 0)
		pos.x = -pos.x;
	if(ball.center.y > height || ball.center.y < 0)
		pos.y = -pos.y;
	
}

- (void)run {
	[super run];
	iterations = 200;
	pos = CGPointMake(14.0,7.0);
	pos = CGPointMake(abs(arc4random() % 40), abs(arc4random() % 40));
	[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];

	[self performSelector:@selector(endRun) withObject:nil afterDelay:4];
//	[self endRun];
}


@end
