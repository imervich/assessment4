//
//  ViewController.m
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

#define personEntity @"Person"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBarButtonItem;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property UIAlertView *stuckAlert;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";

	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:personEntity];
	request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];

	self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	self.fetchedResultsController.delegate = self;

	NSError *fetchError;
	[self.fetchedResultsController performFetch:&fetchError];
	if (fetchError) {
		[self showAlertViewWithTitle:@"User fetch error" message:fetchError.localizedDescription buttonText:@"OK"];
	}
}

#pragma mark - UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //TODO: UPDATE THIS ACCORDINGLY
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
	Person *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.textLabel.text = person.name;

    return cell;
}

#pragma mark - UIAlertView Methods

//METHOD FOR PRESENTING ALERT VIEW WITH TEXT FIELD FOR USER TO ENTER NEW PERSON
- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender
{
    self.addAlert = [[UIAlertView alloc] initWithTitle:@"Add a Person"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Add", nil];
    self.addAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *alertTextField = [self.addAlert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;

    [self.addAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.addAlert)
    {

        if (buttonIndex != alertView.cancelButtonIndex)
        {
			//TODO: ADD YOUR CODE HERE FOR WHEN USER ADDS NEW PERSON
			Person *newPerson = [NSEntityDescription insertNewObjectForEntityForName:personEntity inManagedObjectContext:self.managedObjectContext];
			newPerson.name = [alertView textFieldAtIndex:0].text;

			[self saveContext];
        }
    }
    else if (alertView == self.colorAlert)
    {
        //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW
            if (buttonIndex == 0)
            {
                self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
            }
            else if (buttonIndex == 1)
            {
                self.navigationController.navigationBar.tintColor = [UIColor blueColor];
            }
            else if (buttonIndex == 2)
            {
                self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
            }
            else if (buttonIndex == 3)
            {
                self.navigationController.navigationBar.tintColor = [UIColor greenColor];
            }
    }
    else
    {
        if (buttonIndex != alertView.cancelButtonIndex)
        {
            UIAlertView *newAlertView = [[UIAlertView alloc] initWithTitle:@"Lets try this"
                                                                   message:@"1.Write down the question you want to ask \n2.Brainstorm 3 possible solutions \n3.Bring the question and 3 possible answers to an instructor, or learning assistant \n4.Give the Engineerium a high-five"
                                                                  delegate:self
                                                         cancelButtonTitle:@"We found the answer"
                                                         otherButtonTitles:nil, nil];
            [newAlertView show];
        }
    }


}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    [self.colorAlert show];
}
- (IBAction)onPressedPresentStuckBox:(UIButton *)sender
{
    self.stuckAlert = [[UIAlertView alloc] initWithTitle:@"Follow these steps"
                                                        message:@"1.Identify where you are stuck \n2.Use Apple documentation to get a better understand of what has you stuck \n3.Search Google and StackOverflow for possible solutions"
                                                       delegate:self
                                              cancelButtonTitle:@"Found solution"
                                              otherButtonTitles:@"Still Stuck", nil];
    [self.stuckAlert show];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
	[self.myTableView reloadData];
}

#pragma mark - Helper methods

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message buttonText:(NSString *)buttonText
{
	UIAlertView *alertView = [UIAlertView new];
	alertView.title = title;
	alertView.message = message;
	[alertView addButtonWithTitle:buttonText];
	[alertView show];
	NSLog(@"%@, %@", title, message);
}

- (void)saveContext
{
	NSError *saveError;
	[self.managedObjectContext save:&saveError];

	if (saveError) {
		UIAlertView *alertView = [UIAlertView new];
		alertView.title = @"Saving error";
		alertView.message = saveError.localizedDescription;
		[alertView addButtonWithTitle:@"OK"];
		[alertView show];

		NSLog(@"Saving error: %@", saveError.localizedDescription);
	}
}


@end
