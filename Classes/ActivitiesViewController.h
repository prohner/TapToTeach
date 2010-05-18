//
//  ActivitiesViewController.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/17/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapToTeachAppDelegate.h"

@class WordBankViewController;

@interface ActivitiesViewController : UIViewController {

	TapToTeachAppDelegate *appDelegate;
	UILabel *welcomeLabel;
	UIButton *infoButton;
	UIPopoverController *popover;
	WordBankViewController *wordBankViewController;
}

@property (nonatomic, retain) IBOutlet UILabel *welcomeLabel;
@property (nonatomic, retain) IBOutlet UIButton *infoButton;

- (IBAction)buttonPressedForWordBank:(id)sender;
- (void)loadViewController:(UIViewController **)ctrl withNibAndClassName:(NSString *)nibAndClassName;
- (IBAction)infoButtonPressed:(id)sender;

@end
