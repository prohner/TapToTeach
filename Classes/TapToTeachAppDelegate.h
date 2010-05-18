//
//  TapToTeachAppDelegate.h
//  TapToTeach
//
//  Created by Preston Rohner on 4/27/10.
//  Copyright Cool Tool Apps 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Utility.h"
#import "SystemSettings.h"
#import "WordBankSettings.h"
#import "SystemSettings.h"

@class WordBankViewController;
@class VoicePlayViewController;

@interface TapToTeachAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

    UIWindow *window;
	WordBankViewController *wordBankViewController;
	VoicePlayViewController *voicePlayViewController;
	SystemSettings *systemSettings;
	UILabel *welcomeLabel;
	UIButton *infoButton;
	UIPopoverController *popover;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) SystemSettings *systemSettings;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UILabel *welcomeLabel;
@property (nonatomic, retain) IBOutlet UIButton *infoButton;

- (NSString *)applicationDocumentsDirectory;

- (IBAction)buttonPressedForWordBank:(id)sender;
//- (IBAction)buttonPressedForVoicePlay:(id)sender;
- (void)loadViewController:(UIViewController **)ctrl withNibAndClassName:(NSString *)nibAndClassName;
- (WordBankSettings *)wordBankSettings;
- (NSArray *)wordBanks;
- (void)saveData;
- (IBAction)infoButtonPressed:(id)sender;

@end

