//
//  CleanUpViewController.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/23/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityViewController.h"

@interface CleanUpViewController : ActivityViewController {
	UIPopoverController *popover;

}

@property (nonatomic, retain) UIPopoverController *popover;

- (IBAction)infoButtonPressed:(id)sender;

- (CGRect)infoButtonRectangle;

@end
