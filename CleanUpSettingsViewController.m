//
//  CleanUpSettingsViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/31/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "CleanUpSettingsViewController.h"
#import "CleanUpViewController.h"
#import "CleanUpView.h"
#import "CleanUpSettings.h"
#import "CleanUpPicture.h"

#define SECTION_GENERAL		0
#define SECTION_IMAGES		1

@implementation CleanUpSettingsViewController

@synthesize cleanUpViewController, quitActivityButton, imageSizeSlider, imageCountSlider;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"Settings";
	self.navigationItem.leftBarButtonItem = quitActivityButton;
	
	appDelegate = [[UIApplication sharedApplication] delegate];
	pictures = [[[appDelegate cleanUpSettings].pictures allObjects] mutableCopy];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	CleanUpSettings *settings = [appDelegate cleanUpSettings];
	imageSizeSlider.value = [settings.sizeOfImages intValue];
	imageCountSlider.value = [settings.numberOfImages intValue];
}

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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	int rowCount = 0;
	switch (section) {
		case SECTION_GENERAL:
			rowCount = 2;
			break;
		case SECTION_IMAGES:
			rowCount = [pictures count];
			if (self.tableView.editing) {
				rowCount++;
			}
			break;
	}
    return rowCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case SECTION_GENERAL:
			return @"General Settings";
			break;
		case SECTION_IMAGES:
			return @"Images";
			break;
		default:
			return @"Huh?";
			break;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == SECTION_IMAGES) {
		return 60.0f;
	}
	
	return 40.0f;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [[NSString alloc] initWithFormat:@"Cell %i.%i", indexPath.section, indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

		if (indexPath.section == SECTION_GENERAL) {
			if (indexPath.row == 0) {
				cell.textLabel.text = @"Image Sizes";
				[imageSizeSlider setFrame:CGRectMake(140, 10, 160, 20)];
				[cell addSubview:imageSizeSlider];
			} else if (indexPath.row == 1) {
				cell.textLabel.text = @"Image Count";
				[imageCountSlider setFrame:CGRectMake(140, 10, 160, 20)];
				[cell addSubview:imageCountSlider];
			}
		} else if (indexPath.section == SECTION_IMAGES) {
			UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(80, 2, 56, 56)];
			iv.tag = 1;
			[cell addSubview:iv];
		}

				
	}
    
    // Configure the cell...
	if (indexPath.section == SECTION_IMAGES) {
		if (indexPath.row == [pictures count]) {
			cell.textLabel.text = @"add a picture";
		} else {
			UIImageView *iv = (UIImageView *)[cell viewWithTag:1];
			CleanUpPicture *cup = [pictures objectAtIndex:indexPath.row];
			iv.image = [UIImage imageWithData:cup.pictureData];
		}
	}

    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
	if (indexPath.section == SECTION_IMAGES) {
		return YES;
	}
    return NO;
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
	
	NSArray *paths = [NSArray arrayWithObjects:[NSIndexPath 
												indexPathForRow:[pictures count]
												inSection:SECTION_IMAGES], 
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
 	
    if( indexPath.section == SECTION_IMAGES && indexPath.row == [pictures count] )
        return UITableViewCellEditingStyleInsert;
	
    return UITableViewCellEditingStyleDelete;
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		CleanUpSettings *settings = [appDelegate cleanUpSettings];
		CleanUpPicture *cup = [pictures objectAtIndex:indexPath.row];
		[settings removePicturesObject:cup];
		[appDelegate saveData];
		[pictures removeObjectAtIndex:indexPath.row];
		
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		[self chooseImage];
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
	[self chooseImage];
	
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

#pragma mark -
#pragma mark Images

- (void)chooseImage {
	UIImagePickerController* picker = [[UIImagePickerController alloc] init];
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
	picker.delegate = self;
	picker.allowsEditing = YES;

	// Picker is displayed asynchronously.
	UIPopoverController *popover = cleanUpViewController.popover;
	[popover setContentViewController:picker animated:YES];
	//[cuvc.popover presentModalViewController:picker animated:YES];

	//CGRect popoverRect = ((CleanUpView *)self.view).infoButtonView.frame;
	//CGRect popoverRect = [self.view convertRect:[categoriesTextField frame] fromView:[categoriesTextField superview]];
	//popoverRect.size.width = MIN(popoverRect.size.width, 100); // the text field is actually really big
	
	//[popover presentPopoverFromRect:originRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker
		didFinishPickingImage:(UIImage *)image
				  editingInfo:(NSDictionary *)editingInfo {
    [self useImage:image];
	
    // Remove the picker interface and release the picker object.
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    [picker release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    [picker release];
}

// Implement this method in your code to do something with the image.
- (void)useImage:(UIImage*)theImage {
	FUNCTION_LOG();
	[((CleanUpView *)cleanUpViewController.view) addImage:theImage];
	
	CleanUpSettings *settings = [appDelegate cleanUpSettings];
	
	CleanUpPicture *newPicture = (CleanUpPicture *)[NSEntityDescription insertNewObjectForEntityForName:@"CleanUpPicture" 
															   inManagedObjectContext:[appDelegate managedObjectContext]];
	newPicture.pictureData = UIImageJPEGRepresentation(theImage, 1.0);

	[settings addPicturesObject:newPicture];
	
	[appDelegate saveData];
		
	[cleanUpViewController.popover dismissPopoverAnimated:YES];
}

- (IBAction)quitCleanUp:(id)sender {
	FUNCTION_LOG();
	[cleanUpViewController quitActivity:sender];
}

- (IBAction)sliderChanged:(id)sender {
	FUNCTION_LOG();
	CleanUpSettings *settings = [appDelegate cleanUpSettings];
	if (sender == imageSizeSlider) {
		settings.sizeOfImages = [NSNumber numberWithInt:imageSizeSlider.value];
	} else if (sender == imageCountSlider) {
		settings.numberOfImages = [NSNumber numberWithInt:imageCountSlider.value];
	}

	[appDelegate saveData];
}

@end

