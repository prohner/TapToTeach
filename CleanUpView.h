//
//  CleanUpView.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/23/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"

@interface CleanUpView : UIView {
	CALayer *deskLayer;
	CALayer *targetLayer;
	CALayer *rootLayer;
	NSMutableArray *draggablesArray;

	// dragging
	CALayer *dragLayer;
	CGPoint dragOrigin;
	CGPoint dragLastPoint;
	
	IBOutlet UIView *infoButtonView;
}

@property (nonatomic, retain) IBOutlet UIView *infoButtonView;

- (UIImage *)makeAnImageOfWidth:(int)width andHeight:(int)height;

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;
- (IBAction)handleTapGesture:(UIPanGestureRecognizer *)sender;
- (void)endDragAtPosition:(CGPoint)where;
- (void)addImage:(UIImage *)newImage;

@end
