//
//  BouncingBall.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/17/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Congratulations.h"

@interface BouncingBall : Congratulations {
	CGPoint pos;
	UIImageView *ball;
	int iterations;
}

@end
