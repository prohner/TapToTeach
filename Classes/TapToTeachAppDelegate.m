//
//  TapToTeachAppDelegate.m
//  TapToTeach
//
//  Created by Preston Rohner on 4/27/10.
//  Copyright Cool Tool Apps 2010. All rights reserved.
//

#import "TapToTeachAppDelegate.h"
#import "WordBankViewController.h"


@implementation TapToTeachAppDelegate

@synthesize window, welcomeLabel;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
    // Override point for customization after application launch
	NSString *welcomeMessage = @"Welcome!";
	if ([[[self systemSettings] userName] isEqualToString:@""]) {
		[welcomeMessage release];
		welcomeMessage = [[NSString alloc] initWithFormat:@"Welcome %@!", [[self systemSettings] userName]];
	}
	welcomeLabel.text = welcomeMessage;
	[welcomeMessage release];

	
    [window makeKeyAndVisible];
    
    return YES;
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"TapToTeach.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
	[wordBankViewController release];
    
	[window release];
	[super dealloc];
}

#pragma mark -
#pragma mark System Settings
- (SystemSettings *)systemSettings {
	if ( ! systemSettings) {
		NSEntityDescription *systemSettingsEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"SystemSettings"];
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:systemSettingsEntity];
		
		NSError *error = nil;
		NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:&error];
		
		if ((error != nil) || (array == nil)) {
			NSLog(@"Error while fetching\n%@",
				  ([error localizedDescription] != nil)
				  ? [error localizedDescription] : @"Unknown Error");
			exit(1);
		}

		if ([array count] > 0) {
			systemSettings = [array objectAtIndex:0];
		}
		
	}

	return systemSettings;
	
}

#pragma mark -
#pragma mark Activities
- (IBAction)buttonPressedForWordBank:(id)sender {
	[self loadViewController:&wordBankViewController withNibAndClassName:@"WordBankViewController"];
}

- (void)loadViewController:(UIViewController **)ctrl withNibAndClassName:(NSString *)nibAndClassName {
	[(*ctrl) release];
	
	Class c = NSClassFromString(nibAndClassName);
	*ctrl = [[c alloc] initWithNibName:@"WordBankViewController" bundle:nil];
	[(*ctrl).view setFrame:window.bounds];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:window cache:YES];
	[window addSubview:(*ctrl).view];
	[UIView commitAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

#pragma mark -
#pragma mark Accessing data
- (WordBankSettings *)wordBankSettings {
	WordBankSettings *wordBankSettings;
	NSEntityDescription *wordBankSettingsEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"WordBankSettings"];
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:wordBankSettingsEntity];
	
	NSError *error = nil;
	NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:&error];
	
	if ((error != nil) || (array == nil)) {
		NSLog(@"Error while fetching\n%@",
			  ([error localizedDescription] != nil)
			  ? [error localizedDescription] : @"Unknown Error");
		exit(1);
	}
	
	if ([array count] > 0) {
		wordBankSettings = [array objectAtIndex:0];
	} else {
		wordBankSettings = (WordBankSettings *)[NSEntityDescription insertNewObjectForEntityForName:@"WordBankSettings" inManagedObjectContext:[self managedObjectContext]];
		FUNCTION_LOG(@"New settings: sz=%i, cnt=%i", [wordBankSettings.touchpointSize intValue], [wordBankSettings.numberOfTouchpoints intValue]);
	}
	return wordBankSettings;
}

- (NSArray *)wordBanks {
	NSEntityDescription *wordBankEntity = [[[self managedObjectModel] entitiesByName] objectForKey:@"WordBank"];	
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:wordBankEntity];
	
	NSError *error = nil;
    NSArray *array = [[self managedObjectContext] executeFetchRequest:request error:&error];
    if ((error != nil) || (array == nil)) {
        NSLog(@"Error while fetching\n%@",
			  ([error localizedDescription] != nil)
			  ? [error localizedDescription] : @"Unknown Error");
        exit(1);
    }
	
	return array;
}

- (void)saveData {
	NSError *error = nil;
	
	if (![[self managedObjectContext] save: &error]) {
		NSLog(@"Error while saving\n%@",
			  ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
		exit(1);
	}	
	
}

@end

