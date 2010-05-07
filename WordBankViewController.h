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
#import "WordBank.h"
#import "Word.h"

@interface WordBankViewController : UIViewController {
	UIButton *button1;
	UIButton *button2;
	UIButton *button3;
	UIButton *button4;
	UIButton *button5;
	
	UIButton *infoButton;
	UITextField *text;
	UILabel *wordToSpellLabel;
	UILabel *wordToSpell;
	TapToTeachAppDelegate *appDelegate;
	WordBankSettings *wordBankSettings;
	UIPopoverController *popover;
	
	WordBank *wordBank;
	Word *word;
	NSArray *words;
	NSMutableArray *wordUsage;
}

@property (nonatomic, retain) IBOutlet UIButton *button1;
@property (nonatomic, retain) IBOutlet UIButton *button2;
@property (nonatomic, retain) IBOutlet UIButton *button3;
@property (nonatomic, retain) IBOutlet UIButton *button4;
@property (nonatomic, retain) IBOutlet UIButton *button5;
@property (nonatomic, retain) IBOutlet UIButton *infoButton;
@property (nonatomic, retain) IBOutlet UITextField *text;
@property (nonatomic, retain) IBOutlet UILabel *wordToSpell;
@property (nonatomic, retain) IBOutlet UILabel *wordToSpellLabel;

- (IBAction)infoButtonPressed:(id)sender;
- (UIButton *)initButton:(UIButton *)btn at:(int)index;


- (void)setupScreenDisplay;
- (IBAction)quitWordBank:(id)sender;
- (void)reloadWordBankAndStart;
- (void)startWordBank;
- (IBAction)nextWord;
- (void)setButtonLetters;
- (IBAction)buttonPressed:(id)sender;
- (void)setButtonsEnabled:(BOOL) enabled;
- (void)congratulate;

@end
