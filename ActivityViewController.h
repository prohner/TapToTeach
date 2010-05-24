//
//  ActivityViewController.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/22/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapToTeachAppDelegate.h"

@class ActivitiesViewController;

@interface ActivityViewController : UIViewController {
	TapToTeachAppDelegate *appDelegate;
	ActivitiesViewController *activitiesViewController;
}

@property (nonatomic, retain) ActivitiesViewController *activitiesViewController;

- (IBAction)quitActivity:(id)sender;

@end
