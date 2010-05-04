//
//  WordBankSettingsViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 4/30/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "WordBankSettingsViewController.h"
#import "WordBankViewController.h"
#import "WordBank.h"

#define SECTION_GENERAL_SETTINGS	1
#define SECTION_CONGRATS_SETTINGS	2
#define SECTION_WORD_BANKS			0
#define SECTION_GENERAL_SETTINGS_NAME				0
#define SECTION_GENERAL_SETTINGS_TOUCHPOINT_COUNT	1
#define SECTION_GENERAL_SETTINGS_TOUCHPOINT_SIZE	2

#define SECTION_CONGRATS_SETTINGS_AUDIO				0
#define SECTION_CONGRATS_SETTINGS_USE_NAME			1
#define SECTION_CONGRATS_SETTINGS_VISUAL			2

@implementation WordBankSettingsViewController

@synthesize audioCongrats, userName, visualCongrats, numberOfTouchpoints, touchpointSize;
@synthesize wordBankViewController;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"Settings";

	appDelegate = [[UIApplication sharedApplication] delegate];
	wordBankSettings = [appDelegate wordBankSettings];
	wordBanks = [appDelegate wordBanks];
	
	numberOfTouchpoints.value = [wordBankSettings.numberOfTouchpoints floatValue];
	touchpointSize.value = [wordBankSettings.touchpointSize floatValue];
	audioCongrats.on = [wordBankSettings.giveAudioCongratulations boolValue];
	userName.on = [wordBankSettings.audioCongratulationsText isEqualToString:@""] ? NO : YES;
	visualCongrats.on = [wordBankSettings.giveVisualCongratulations boolValue];
	
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	switch (section) {
		case SECTION_GENERAL_SETTINGS:
			return 3;
			break;
		case SECTION_CONGRATS_SETTINGS:
			return 3;
			break;
		case SECTION_WORD_BANKS:
		{
			int rowCount = [[appDelegate wordBanks] count];
			if (self.tableView.editing) {
				rowCount++;
			}
			return rowCount;
		}	
			break;
		default:
			break;
	}
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case SECTION_GENERAL_SETTINGS:
			return @"Settings";
			break;
		case SECTION_CONGRATS_SETTINGS:
			return @"Congratulations";
			break;
		case SECTION_WORD_BANKS:
			return @"Word Banks";
			break;
		default:
			return @"Huh?";
			break;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == SECTION_GENERAL_SETTINGS) {
		switch (indexPath.row) {
			case 1:
			case 2:
				return 60.0f;
				break;
		}
	}
	
	return 40.0f;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [[NSString alloc] initWithFormat:@"Cell %i.%i", indexPath.section, indexPath.row ];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

@try {
    // Configure the cell...
	switch (indexPath.section) {
		case SECTION_GENERAL_SETTINGS:
			switch (indexPath.row) {
				case SECTION_GENERAL_SETTINGS_NAME:
					cell.textLabel.text = @"User name";
					break;
				case SECTION_GENERAL_SETTINGS_TOUCHPOINT_COUNT:
					cell.textLabel.text = @"Touchpoints: \n ";
					cell.textLabel.numberOfLines = 0;
					cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
				{
					[numberOfTouchpoints setFrame:CGRectMake(20, 25, 280, 40)];
					[cell addSubview:numberOfTouchpoints];
					
					CGFloat width = 10, height = 20;
					FUNCTION_LOG("width=%.2f, height=%.2f", width, height);
					
					// Minimum image --------------------------------------
					UIGraphicsBeginImageContext(CGSizeMake(width, height));
					CGContextRef context = UIGraphicsGetCurrentContext();
					UIGraphicsPushContext(context);
					
					CGContextSetFillColorWithColor( context, [UIColor whiteColor].CGColor );
					CGContextFillRect( context, CGRectMake(0, 0, width, height) );					
					
					CGContextSetTextDrawingMode(context, kCGTextFill);
					CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor );
					
					CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor); 
					CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
					
					CGAffineTransform TextMatrix = CGAffineTransformIdentity;
					TextMatrix.d = -1;
					CGContextSetTextMatrix(UIGraphicsGetCurrentContext(), TextMatrix);					
					
					NSString *text = [[NSString alloc] initWithFormat:@"%.0f", numberOfTouchpoints.minimumValue];
					int fontSize = 14;
					CGContextSelectFont(context, "Helvetica", fontSize, kCGEncodingMacRoman);
					CGContextSetTextDrawingMode(context, kCGTextFill);
					CGContextSetTextPosition(context, 3.0f, fontSize);

					CGContextShowText(context, [text UTF8String], strlen([text UTF8String]));

					UIGraphicsPopContext();
					UIImage *img = [UIGraphicsGetImageFromCurrentImageContext() retain];
					UIGraphicsEndImageContext();
					[numberOfTouchpoints setMinimumValueImage:img];
					
					// Maximum image --------------------------------------
					UIGraphicsBeginImageContext(CGSizeMake(width, height));
					context = UIGraphicsGetCurrentContext();
					UIGraphicsPushContext(context);
					
					CGContextSetFillColorWithColor( context, [UIColor whiteColor].CGColor );
					CGContextFillRect( context, CGRectMake(0, 0, width, height) );					
					
					CGContextSetTextDrawingMode(context, kCGTextFill);
					CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor );
					
					CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor); 
					CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
					
					CGContextSetTextMatrix(UIGraphicsGetCurrentContext(), TextMatrix);					
					
					text = [[NSString alloc] initWithFormat:@"%.0f", numberOfTouchpoints.maximumValue];
					CGContextSelectFont(context, "Helvetica", fontSize, kCGEncodingMacRoman);
					CGContextSetTextDrawingMode(context, kCGTextFill);
					CGContextSetTextPosition(context, 3.0f, fontSize);
					
					CGContextShowText(context, [text UTF8String], strlen([text UTF8String]));
					
					UIGraphicsPopContext();
					img = [UIGraphicsGetImageFromCurrentImageContext() retain];
					UIGraphicsEndImageContext();
					[numberOfTouchpoints setMaximumValueImage:img];
				}
					break;
				case SECTION_GENERAL_SETTINGS_TOUCHPOINT_SIZE:
					cell.textLabel.text = @"Touchpoint Size: \n ";
					cell.textLabel.numberOfLines = 0;
					cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
				{
					[touchpointSize setFrame:CGRectMake(20, 25, 280, 40)];
					[cell addSubview:touchpointSize];

					CGFloat width = 24, height = 20;
					FUNCTION_LOG("width=%.2f, height=%.2f", width, height);
					
					// Minimum image --------------------------------------
					UIGraphicsBeginImageContext(CGSizeMake(width, height));
					CGContextRef context = UIGraphicsGetCurrentContext();
					UIGraphicsPushContext(context);
					
					CGContextSetFillColorWithColor( context, [UIColor whiteColor].CGColor );
					CGContextFillRect( context, CGRectMake(0, 0, width, height) );					
					
					CGContextSetTextDrawingMode(context, kCGTextFill);
					CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor );
					
					CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor); 
					CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
					
					CGAffineTransform TextMatrix = CGAffineTransformIdentity;
					TextMatrix.d = -1;
					CGContextSetTextMatrix(UIGraphicsGetCurrentContext(), TextMatrix);					
					
					NSString *text = [[NSString alloc] initWithFormat:@"%.0f", touchpointSize.minimumValue];
					int fontSize = 14;
					CGContextSelectFont(context, "Helvetica", fontSize, kCGEncodingMacRoman);
					CGContextSetTextDrawingMode(context, kCGTextFill);
					CGContextSetTextPosition(context, 3.0f, fontSize);
					
					CGContextShowText(context, [text UTF8String], strlen([text UTF8String]));
					
					UIGraphicsPopContext();
					UIImage *img = [UIGraphicsGetImageFromCurrentImageContext() retain];
					UIGraphicsEndImageContext();
					[touchpointSize setMinimumValueImage:img];
					
					// Maximum image --------------------------------------
					UIGraphicsBeginImageContext(CGSizeMake(width, height));
					context = UIGraphicsGetCurrentContext();
					UIGraphicsPushContext(context);
					
					CGContextSetFillColorWithColor( context, [UIColor whiteColor].CGColor );
					CGContextFillRect( context, CGRectMake(0, 0, width, height) );					
					
					CGContextSetTextDrawingMode(context, kCGTextFill);
					CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor );
					
					CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor); 
					CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
					
					CGContextSetTextMatrix(UIGraphicsGetCurrentContext(), TextMatrix);					
					
					text = [[NSString alloc] initWithFormat:@"%.0f", touchpointSize.maximumValue];
					CGContextSelectFont(context, "Helvetica", fontSize, kCGEncodingMacRoman);
					CGContextSetTextDrawingMode(context, kCGTextFill);
					CGContextSetTextPosition(context, 0.0f, fontSize);
					
					CGContextShowText(context, [text UTF8String], strlen([text UTF8String]));
					
					UIGraphicsPopContext();
					img = [UIGraphicsGetImageFromCurrentImageContext() retain];
					UIGraphicsEndImageContext();
					[touchpointSize setMaximumValueImage:img];
				}
					break;
				default:
					break;
			}
			break;
		case SECTION_CONGRATS_SETTINGS:
			switch (indexPath.row) {
				case SECTION_CONGRATS_SETTINGS_AUDIO:
					cell.textLabel.text = @"Audio Congrats";
					[audioCongrats setFrame:CGRectMake(210, 7.5, 80, 35)];
					[cell addSubview:audioCongrats];
					break;
				case SECTION_CONGRATS_SETTINGS_USE_NAME:
					cell.textLabel.text = @"Use Name";
					[userName setFrame:CGRectMake(210, 7.5, 80, 35)];
					[cell addSubview:userName];
					break;
				case SECTION_CONGRATS_SETTINGS_VISUAL:
					cell.textLabel.text = @"Visual Congrats";
					[visualCongrats setFrame:CGRectMake(210, 7.5, 80, 35)];
					[cell addSubview:visualCongrats];
					break;
				default:
					break;
			}
			break;
		case SECTION_WORD_BANKS:
		{
			wordBanks = [appDelegate wordBanks];
			if (indexPath.row < [wordBanks count]) {
				WordBank *wb;
				wb = [wordBanks objectAtIndex:indexPath.row];
				cell.textLabel.text = wb.title;
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			} else {
				[newWordBankTitle release];
				newWordBankTitle = [[UITextField alloc] initWithFrame:CGRectMake(45, 10, 250, 35)];
				newWordBankTitle.placeholder = @"New word bank name";
				newWordBankTitle.autocapitalizationType = UITextAutocapitalizationTypeWords;
				[cell addSubview:newWordBankTitle];
			}

		}
			break;

		default:
			break;
	}
}
@catch (NSException * e) {
	FUNCTION_LOG(@"Error %@" @"xxx");
}    
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
	if (indexPath.section == SECTION_WORD_BANKS) {
		return YES;
	}
    return NO;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];

	wordBanks = [appDelegate wordBanks];
	FUNCTION_LOG(@"wordBanks %i", wordBanks);
	int i = [wordBanks count];
	FUNCTION_LOG(@"i==%i", i);
	NSArray *paths = [NSArray arrayWithObjects:[NSIndexPath 
												indexPathForRow:[wordBanks count]
												inSection:SECTION_WORD_BANKS], 
					  nil];
	
	[self.tableView beginUpdates];
	
    if( editing )
        [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationBottom];
    else
        [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationBottom];
	
	[self.tableView endUpdates];
	
    //[paths release];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
 	
    if( indexPath.section == SECTION_WORD_BANKS && indexPath.row == [[appDelegate wordBanks] count] )
        return UITableViewCellEditingStyleInsert;
	
    return UITableViewCellEditingStyleDelete;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source

		wordBanks = [appDelegate wordBanks];
		WordBank *wb = (WordBank *)[wordBanks objectAtIndex:indexPath.row];
		[[appDelegate managedObjectContext] deleteObject:wb];
		[appDelegate saveData];
		wordBanks = [appDelegate wordBanks];

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		WordBank *newWordBank = (WordBank *)[NSEntityDescription insertNewObjectForEntityForName:@"WordBank" 
																		  inManagedObjectContext:[appDelegate managedObjectContext]];
		newWordBank.title = newWordBankTitle.text;
		[appDelegate saveData];
		wordBanks = [appDelegate wordBanks];
		newWordBankTitle.text = @"";
		NSArray *paths = [NSArray arrayWithObjects:[NSIndexPath 
													indexPathForRow:[wordBanks count]-1
													inSection:SECTION_WORD_BANKS], 
						  nil];
		[self.tableView beginUpdates];
		[self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationRight];
		[self.tableView endUpdates];
		
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == SECTION_WORD_BANKS) {
		return indexPath;
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[newWordBankTitle release];
	[wordBanks release];
	[wordBankViewController release];
    [super dealloc];
}

- (IBAction)numberOfTouchpointsChanged:(id)sender {
	FUNCTION_LOG(@"value=%f, wordBankSettings=%i", numberOfTouchpoints.value, wordBankSettings);
	NSNumber *newNumber = [NSNumber numberWithFloat:numberOfTouchpoints.value];
	FUNCTION_LOG(@"\tnew number =%i", [newNumber intValue]);
	[appDelegate wordBankSettings].numberOfTouchpoints = newNumber;
	[appDelegate saveData];
	[wordBankViewController setupScreenDisplay];
}

- (IBAction)touchpointSizeChanged:(id)sender {
	FUNCTION_LOG(@"value=%f", touchpointSize.value);
	[appDelegate wordBankSettings].touchpointSize = [NSNumber numberWithFloat:touchpointSize.value];
	[appDelegate saveData];
	[wordBankViewController setupScreenDisplay];
}

- (IBAction)numberOfTouchpointsFinishedChanging:(id)sender {
	FUNCTION_LOG(@"value=%f", numberOfTouchpoints.value);
}

- (IBAction)audioCongratsChanged:(id)sender {
	[appDelegate wordBankSettings].giveAudioCongratulations = [NSNumber numberWithBool:audioCongrats.on];
	[appDelegate saveData];
}

- (IBAction)useNameCongratsChanged:(id)sender {
	[appDelegate wordBankSettings].audioCongratulationsText = userName.on ? @"{name}" : @"";
	[appDelegate saveData];
}

- (IBAction)visualCongratsChanged:(id)sender {
	[appDelegate wordBankSettings].giveVisualCongratulations = [NSNumber numberWithBool:visualCongrats.on];
	[appDelegate saveData];
}

@end

