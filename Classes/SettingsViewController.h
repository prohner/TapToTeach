//
//  SettingsViewController.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/11/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TapToTeachAppDelegate;

@interface SettingsViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	UISwitch *audioCongrats;
	UISwitch *visualCongrats;

	UIButton *sayItButton;
	UITextField *wordOrPhrase;
	UISlider *pitch;
	UISlider *variance;
	UISlider *speed;
	UIPickerView *voicePicker;
	
	UILabel *pitchValue;
	UILabel *varianceValue;
	UILabel *speedValue;
	
	UITextField *userName;
	UITextField *userNamePhonetic;
	
	NSMutableArray *voiceChoices;
	
	TapToTeachAppDelegate *appDelegate;
}

@property (nonatomic, retain) IBOutlet UISwitch *audioCongrats;
@property (nonatomic, retain) IBOutlet UISwitch *visualCongrats;

@property (nonatomic, retain) IBOutlet UIButton *sayItButton;
@property (nonatomic, retain) IBOutlet UITextField *wordOrPhrase;
@property (nonatomic, retain) IBOutlet UISlider *pitch;
@property (nonatomic, retain) IBOutlet UISlider *variance;
@property (nonatomic, retain) IBOutlet UISlider *speed;
@property (nonatomic, retain) IBOutlet UIPickerView *voicePicker;

@property (nonatomic, retain) IBOutlet UILabel *pitchValue;
@property (nonatomic, retain) IBOutlet UILabel *varianceValue;
@property (nonatomic, retain) IBOutlet UILabel *speedValue;

@property (nonatomic, retain) IBOutlet UITextField *userName;
@property (nonatomic, retain) IBOutlet UITextField *userNamePhonetic;

- (IBAction)sayWordOrPhrase:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)audioCongratsChanged:(id)sender;
//- (IBAction)useNameCongratsChanged:(id)sender;
- (IBAction)visualCongratsChanged:(id)sender;

@end
