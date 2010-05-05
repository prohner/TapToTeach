//
//  WordBankWordsViewController.h
//  TapToTeach
//
//  Created by Preston Rohner on 5/4/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapToTeachAppDelegate.h"
#import "WordBank.h"
#import "Word.h"

@class WordBankViewController;

@interface WordBankWordsViewController : UITableViewController {
	WordBank *wordBank;
	UITextField *newWord;
	UITextField *newWordPhonetic;
	NSMutableArray *words;
	TapToTeachAppDelegate *appDelegate;
	UIButton *makeActiveButton;
	WordBankViewController *wordBankViewController;
}

@property (nonatomic, retain) WordBank *wordBank;
@property (nonatomic, retain) IBOutlet UITextField *newWord;
@property (nonatomic, retain) IBOutlet UITextField *newWordPhonetic;
@property (nonatomic, retain) IBOutlet UIButton *makeActiveButton;
@property (nonatomic, retain) WordBankViewController *wordBankViewController;

- (IBAction)selectThisWordBank:(id)sender;

@end
