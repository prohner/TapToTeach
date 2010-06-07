//
//  CleanUpSettingsViewController.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/31/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utility.h"
#import "TapToTeachAppDelegate.h"

@class CleanUpViewController;

@interface CleanUpSettingsViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	CleanUpViewController *cleanUpViewController;
	UIBarButtonItem *quitActivityButton;
	UISlider *imageSizeSlider;
	UISlider *imageCountSlider;
	TapToTeachAppDelegate *appDelegate;
	NSMutableArray *pictures;
}

@property (nonatomic, retain) CleanUpViewController *cleanUpViewController;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *quitActivityButton;
@property (nonatomic, retain) IBOutlet UISlider *imageSizeSlider;
@property (nonatomic, retain) IBOutlet UISlider *imageCountSlider;

- (void)chooseImage;
- (void)useImage:(UIImage*)theImage;
- (IBAction)quitCleanUp:(id)sender;

@end
