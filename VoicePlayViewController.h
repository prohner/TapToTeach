//
//  VoicePlayViewController.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/7/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VoicePlayViewController : UIViewController {
	UITextField *wordOrPhrase;
	UISlider *pitch;
	UISlider *variance;
	UISlider *speed;
	UIPickerView *voicePicker;
}

@property (nonatomic, retain) IBOutlet UITextField *wordOrPhrase;
@property (nonatomic, retain) IBOutlet UISlider *pitch;
@property (nonatomic, retain) IBOutlet UISlider *variance;
@property (nonatomic, retain) IBOutlet UISlider *speed;
@property (nonatomic, retain) IBOutlet UIPickerView *voicePicker;

- (IBAction)sayWordOrPhrase:(id)sender;

@end
