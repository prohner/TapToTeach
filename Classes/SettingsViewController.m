//
//  SettingsViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/11/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "SettingsViewController.h"
#import "FliteTTS.h"
#import "TapToTeachAppDelegate.h"
#import "SystemSettings.h"

#define SECTION_USER_SETTINGS				0
#define SECTION_USER_SETTINGS_NAME			0

#define SECTION_CONGRATS_SETTINGS			1
#define SECTION_CONGRATS_SETTINGS_AUDIO		0
#define SECTION_CONGRATS_SETTINGS_VISUAL	1

#define SECTION_VOICE_SETTINGS				2
#define SECTION_VOICE_SETTINGS_WORD_TO_SAY	0
#define SECTION_VOICE_SETTINGS_SAY_BUTTON	1
#define SECTION_VOICE_SETTINGS_PITCH		2
#define SECTION_VOICE_SETTINGS_VARIANCE		3
#define SECTION_VOICE_SETTINGS_SPEED		4
#define SECTION_VOICE_SETTINGS_VOICE		5


@implementation SettingsViewController

@synthesize wordOrPhrase, pitch, variance, speed, voicePicker;
@synthesize pitchValue, varianceValue, speedValue;
@synthesize userName, userNamePhonetic, sayItButton;
@synthesize audioCongrats, visualCongrats;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
	self.title = @"General Settings";
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

	voiceChoices = [[NSMutableArray alloc] init];
	[voiceChoices addObject:@"cmu_us_kal"];
	[voiceChoices addObject:@"cmu_us_kal16"];
	[voiceChoices addObject:@"cmu_us_rms"];
	[voiceChoices addObject:@"cmu_us_awb"];
	[voiceChoices addObject:@"cmu_us_slt"];			
	
	appDelegate = [[UIApplication sharedApplication] delegate];
	
	SystemSettings *systemSettings = [appDelegate systemSettings];
	audioCongrats.on = [systemSettings.giveAudioCongratulations boolValue];
//	userName.on = [systemSettings.audioCongratulationsText isEqualToString:@""] ? NO : YES;
	visualCongrats.on = [systemSettings.giveVisualCongratulations boolValue];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	SystemSettings *s = [appDelegate systemSettings];
	
	pitch.value = [s.ttsPitch floatValue];
	variance.value = [s.ttsVariance floatValue];
	speed.value = [s.ttsSpeed floatValue];
	
	[self sliderValueChanged:pitch];
	[self sliderValueChanged:variance];
	[self sliderValueChanged:speed];
	
	NSInteger row = [voiceChoices indexOfObject:s.ttsVoice];
	[voicePicker selectRow:row inComponent:0 animated:YES];
}

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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case SECTION_USER_SETTINGS:
			return @"General Settings";
			break;
		case SECTION_CONGRATS_SETTINGS:
			return @"Congratulations Settings";
			break;
		case SECTION_VOICE_SETTINGS:
			return @"Voice Settings";
			break;
		default:
			return @"Huh?";
			break;
	}
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case SECTION_USER_SETTINGS:
			return 1;
			break;
		case SECTION_CONGRATS_SETTINGS:
			return 2;
			break;
		case SECTION_VOICE_SETTINGS:
			return 6;
			break;
		default:
			return 0;
			break;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.section) {
		case SECTION_VOICE_SETTINGS:
			switch (indexPath.row) {
				case SECTION_VOICE_SETTINGS_VOICE:
					return 218.0f;
					break;
				case SECTION_VOICE_SETTINGS_PITCH:
				case SECTION_VOICE_SETTINGS_VARIANCE:
				case SECTION_VOICE_SETTINGS_SPEED:
					return 60.0f;
					break;
			}
			break;
		default:
			break;
	}
	
	return 40.0f;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [[NSString alloc] initWithFormat:@"Settings Cell %i.%i", indexPath.section, indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

		switch (indexPath.section) {
			case SECTION_VOICE_SETTINGS:
			{
				SystemSettings *s = [appDelegate systemSettings];
				switch (indexPath.row) {
					case SECTION_VOICE_SETTINGS_WORD_TO_SAY:
					{
						CGRect r = cell.bounds;
						r.origin.x = 4;
						r.origin.y = 3;
						r.size.height = 34;
						r.size.width = 312;
						
						[wordOrPhrase setFrame:r];
						[cell addSubview:wordOrPhrase];
					}
						break;
					case SECTION_VOICE_SETTINGS_SAY_BUTTON:
					{
						CGRect r = sayItButton.bounds;
						r.origin.y = 2;
						r.origin.x = (cell.bounds.size.width / 2 - sayItButton.bounds.size.width / 2);
						[sayItButton setFrame:r];
						[cell addSubview:sayItButton];
					}
						break;
					case SECTION_VOICE_SETTINGS_PITCH:
						cell.textLabel.text = @"Voice Pitch: \n ";
						cell.textLabel.numberOfLines = 0;
						cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;

						pitch.value = [s.ttsPitch floatValue];
						[pitch setFrame:CGRectMake(20, 25, 280, 40)];
						[cell addSubview:pitch];
						
						[pitchValue setFrame:CGRectMake(260, 3, 60, 30)];
						[cell addSubview:pitchValue];
						break;
					case SECTION_VOICE_SETTINGS_VARIANCE:
						cell.textLabel.text = @"Voice Variation: \n ";
						cell.textLabel.numberOfLines = 0;
						cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
						
						variance.value = [s.ttsVariance floatValue];
						[variance setFrame:CGRectMake(20, 25, 280, 40)];
						[cell addSubview:variance];
						
						[varianceValue setFrame:CGRectMake(260, 3, 60, 30)];
						[cell addSubview:varianceValue];
						break;
					case SECTION_VOICE_SETTINGS_SPEED:
						cell.textLabel.text = @"Voice Speed: \n ";
						cell.textLabel.numberOfLines = 0;
						cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
						
						speed.value = [s.ttsSpeed floatValue];
						[speed setFrame:CGRectMake(20, 25, 280, 40)];
						[cell addSubview:speed];
						
						[speedValue setFrame:CGRectMake(260, 3, 60, 30)];
						[cell addSubview:speedValue];
						break;
					case SECTION_VOICE_SETTINGS_VOICE:
					{
						NSInteger row = [voiceChoices indexOfObject:s.ttsVoice];
						[voicePicker setFrame:CGRectMake(0, 0, 320, 218)];
						[voicePicker selectRow:row inComponent:0 animated:YES];
						[cell addSubview:voicePicker];
					}
						break;
					default:
						break;
				}
				break;
			}
			case SECTION_CONGRATS_SETTINGS:
			{
				//SystemSettings *s = [appDelegate systemSettings];
				switch (indexPath.row) {
					case SECTION_CONGRATS_SETTINGS_AUDIO:
						cell.textLabel.text = @"Audio Congrats";
						[audioCongrats setFrame:CGRectMake(210, 7.5, 80, 35)];
						[cell addSubview:audioCongrats];
						break;
					case SECTION_CONGRATS_SETTINGS_VISUAL:
						cell.textLabel.text = @"Visual Congrats";
						[visualCongrats setFrame:CGRectMake(210, 7.5, 80, 35)];
						[cell addSubview:visualCongrats];
						break;
					default:
						break;
				}
			}
				break;

			default:
				break;
		}
    }
    
    // Configure the cell...
    
    return cell;
}

- (IBAction)audioCongratsChanged:(id)sender {
	[appDelegate systemSettings].giveAudioCongratulations = [NSNumber numberWithBool:audioCongrats.on];
	[appDelegate saveData];
}

//- (IBAction)useNameCongratsChanged:(id)sender {
//	[appDelegate wordBankSettings].audioCongratulationsText = userName.on ? @"{name}" : @"";
//	[appDelegate saveData];
//}

- (IBAction)visualCongratsChanged:(id)sender {
	[appDelegate systemSettings].giveVisualCongratulations = [NSNumber numberWithBool:visualCongrats.on];
	[appDelegate saveData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


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
    [super dealloc];
}

- (IBAction)sayWordOrPhrase:(id)sender {
	FliteTTS *fliteEngine = [[FliteTTS alloc] init];
	
	[fliteEngine setVoice:[voiceChoices objectAtIndex:[voicePicker selectedRowInComponent:0]]];
	[fliteEngine setPitch:[pitch value] variance:[variance value] speed:[speed value]];
	[fliteEngine speakText:wordOrPhrase.text];
}

- (IBAction)sliderValueChanged:(id)sender {
	if (sender == pitch) {
		pitchValue.text = [[NSString alloc] initWithFormat:@"%.2f", pitch.value];
	} else if (sender == variance) {
		varianceValue.text = [[NSString alloc] initWithFormat:@"%.2f", variance.value];
	} else if (sender == speed) {
		speedValue.text = [[NSString alloc] initWithFormat:@"%.2f", speed.value];
	}
	
	SystemSettings *ss = [appDelegate systemSettings];
	ss.ttsPitch = [NSNumber numberWithFloat:pitch.value];
	ss.ttsVariance = [NSNumber numberWithFloat:variance.value];
	ss.ttsSpeed = [NSNumber numberWithFloat:speed.value];
	
	FUNCTION_LOG(@"pitch=%.2f, variance=%.2f, speed=%.2f", ss.ttsPitch, 
				 ss.ttsVariance,
				 ss.ttsSpeed);
	[appDelegate saveData];
	
}

#pragma mark 
#pragma mark Picker View 
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [voiceChoices objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [voiceChoices count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	[appDelegate systemSettings].ttsVoice = [voiceChoices objectAtIndex:row];
	[appDelegate saveData];
}

@end

