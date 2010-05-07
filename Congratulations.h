//
//  Congratulations.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/6/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapToTeachAppDelegate.h"

@interface Congratulations : UIViewController {
	TapToTeachAppDelegate *appDelegate;
	NSTimeInterval duration;
	CGRect originRect;
}

- (id) initOnRect:(CGRect)rect withDuration:(NSTimeInterval)howLong;
- (void) run;
- (void)endRun;
- (void)endRunAndCleanup;
	
+ (NSString *)pickCongratulationsClassString;
@end
