//
//  WordBankViewController.h
//  TapToTeach
//
//  Created by Preston Rohner on 4/27/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapToTeachAppDelegate.h"
#import "WordBankSettings.h"

@interface WordBankViewController : UIViewController {
	UIButton *button1;
	UIButton *button2;
	UIButton *button3;
	UIButton *button4;
	UIButton *button5;
	
	UIButton *infoButton;
	UITextField *text;
	TapToTeachAppDelegate *appDelegate;
	WordBankSettings *wordBankSettings;
}

@property (nonatomic, retain) IBOutlet UIButton *button1;
@property (nonatomic, retain) IBOutlet UIButton *button2;
@property (nonatomic, retain) IBOutlet UIButton *button3;
@property (nonatomic, retain) IBOutlet UIButton *button4;
@property (nonatomic, retain) IBOutlet UIButton *button5;
@property (nonatomic, retain) IBOutlet UIButton *infoButton;
@property (nonatomic, retain) IBOutlet UITextField *text;

- (IBAction)infoButtonPressed:(id)sender;
@end
