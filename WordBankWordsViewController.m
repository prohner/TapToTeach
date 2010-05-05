//
//  WordBankWordsViewController.m
//  TapToTeach
//
//  Created by Preston Rohner on 5/4/10.
//  Copyright 2010 Cool Tool Apps. All rights reserved.
//

#import "WordBankWordsViewController.h"
#import "WordBankViewController.h"

@implementation WordBankWordsViewController

@synthesize wordBank, newWord, newWordPhonetic, makeActiveButton, wordBankViewController;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = wordBank.title;
	self.editing = YES;

	words = [[[wordBank words] allObjects] mutableCopy];
	appDelegate = [[UIApplication sharedApplication] delegate];
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	int rowCount = [words count] + 1;
	if (self.tableView.editing) { 
        rowCount++;
	}

    return rowCount;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier;
	CellIdentifier = [[NSString alloc] initWithFormat:@"Cell %i.%i", indexPath.section, indexPath.row];
	if (indexPath.row > [words count]) {
		CellIdentifier = [[NSString alloc] initWithFormat:@"Cell New Word %i.%i", indexPath.section, indexPath.row];
	}
	FUNCTION_LOG(@"%@", CellIdentifier);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

		if (indexPath.row > [words count]) {
			cell.textLabel.text = @"Word:\n\nPhonetic:";
			cell.textLabel.numberOfLines = 0;
			cell.textLabel.font = [UIFont systemFontOfSize:17];
			cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
			
			[newWord setFrame:CGRectMake(130, 5, 175, 35)];
			newWord.placeholder = @"Enter the word";
			
			[newWordPhonetic setFrame:CGRectMake(130, 52, 175, 35)];
			newWordPhonetic.placeholder = @"Phonetic spelling";
		}
    }
    
    // Configure the cell...
	if (indexPath.row > [words count]) {
		FUNCTION_LOG(@"newWord = %i", newWord);
		newWord.text = @"";
		[cell addSubview:newWord];
		newWordPhonetic.text = @"";
		[cell addSubview:newWordPhonetic];
	} else if (indexPath.row == [words count]) {
		[makeActiveButton setFrame:CGRectMake(2, 2, 316, 36)];
		[cell addSubview:makeActiveButton];
	} else {
		Word *word = [words objectAtIndex:indexPath.row];
		if ([word.wordPhonetic length] == 0) {
			cell.textLabel.text = word.word;
		} else {
			cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ (%@)", word.word, word.wordPhonetic];
		}
	}


    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
 	
    if( indexPath.row > [words count] ) {
        return UITableViewCellEditingStyleInsert;
	} else if (indexPath.row == [words count]) {
		return UITableViewCellEditingStyleNone;
	}
	
    return UITableViewCellEditingStyleDelete;
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		Word *wordToDelete = [words objectAtIndex:indexPath.row];
		[[appDelegate managedObjectContext] deleteObject:wordToDelete];
		[appDelegate saveData];
		words = [[[wordBank words] allObjects] mutableCopy];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		[tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		NSLog(@"Inserting new item");
		@try {
			Word *newWordToAdd = (Word *)[NSEntityDescription insertNewObjectForEntityForName:@"Word" 
																  inManagedObjectContext:[appDelegate managedObjectContext]];
			newWordToAdd.word = newWord.text;
			newWordToAdd.wordBank = wordBank;
			newWordToAdd.wordPhonetic = newWordPhonetic.text;
			[appDelegate saveData];
			
			[words addObject:newWordToAdd];
			
			//[words addObject:newWordTextField.text];
			NSArray *insertIndexPaths = [NSArray arrayWithObjects:
										 [NSIndexPath indexPathForRow:[words count]+1 inSection:0],
										 nil];
			UITableView *tv = (UITableView *)self.view;
			[tv beginUpdates];
			[tv insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
			[tv reloadData];
			[tv endUpdates];
		}
		@catch (NSException * e) {
			NSLog(@"%s ERROR: %@", __FUNCTION__, [e description]);
		}
		
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row > [words count]) {
		return 90.0f;
	}
	
	return 40.0f;
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
	[wordBank release];
	[words release];
    [super dealloc];
}

- (IBAction)selectThisWordBank:(id)sender {
	[appDelegate wordBankSettings].lastWordBank = wordBank;
	[appDelegate saveData];
	[wordBankViewController reloadWordBankAndStart];
}

@end

