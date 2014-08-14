//
//  DogsViewController.m
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "Person.h"
#import "AppDelegate.h"
#import "DogTableViewCell.h"
#import "AddDogViewController.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource, AddDogViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";
}

#pragma mark - UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogOwner.dogs.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: mmDogCellIdentifier];
	Dog *dog = self.dogOwner.dogs.allObjects[indexPath.row];

	cell.dog = dog;
	[cell showDogData];

    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		Dog *dog = self.dogOwner.dogs.allObjects[indexPath.row];

		[[self managedObjectContext] deleteObject:(NSManagedObject *)dog];
		[self saveContext];
		[self.dogsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

	}
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	AddDogViewController *addDVC = segue.destinationViewController;
	addDVC.delegate = self;
	addDVC.dogOwner = self.dogOwner;

	if ([segue.identifier isEqualToString:mmAddSegue]) {
		addDVC.dog = nil;
	} else if ([segue.identifier isEqualToString:mmEditSegue]) {

		// set the dog to edit
		NSIndexPath *indexPath = self.dogsTableView.indexPathForSelectedRow;
		Dog *dog = self.dogOwner.dogs.allObjects[indexPath.row];
		addDVC.dog = dog;
	}
}

#pragma mark - AddDogViewControllerDelegate

- (void)addedDog:(Dog *)dog toPerson:(Person *)person
{
	[self.dogsTableView reloadData];
}

- (void)editedDog:(Dog *)dog
{
	[self.dogsTableView reloadData];
}

#pragma mark - Helper methods

- (void)saveContext
{
	NSError *saveError;
	[[self managedObjectContext] save:&saveError];

	if (saveError) {
		[self showAlertViewWithTitle:@"Saving dog error" message:saveError.localizedDescription buttonText:@"OK"];
		NSLog(@"Saving dog error: %@", saveError.localizedDescription);
	}
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message buttonText:(NSString *)buttonText
{
	UIAlertView *alertView = [UIAlertView new];
	alertView.title = title;
	alertView.message = message;
	[alertView addButtonWithTitle:buttonText];
	[alertView show];
	NSLog(@"%@, %@", title, message);
}

- (NSManagedObjectContext *)managedObjectContext
{
	return ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
}
@end
