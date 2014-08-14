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

//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

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
    //TODO: UPDATE THIS ACCORDINGLY
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:mmAddSegue]) {
		AddDogViewController *addDVC = segue.destinationViewController;
		addDVC.delegate = self;
		addDVC.dogOwner = self.dogOwner;
	}
}

#pragma mark - AddDogViewControllerDelegate

- (void)addedDog:(Dog *)dog toPerson:(Person *)person
{
	[self.dogsTableView reloadData];
}

#pragma mark - Helper methods

//- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message buttonText:(NSString *)buttonText
//{
//	UIAlertView *alertView = [UIAlertView new];
//	alertView.title = title;
//	alertView.message = message;
//	[alertView addButtonWithTitle:buttonText];
//	[alertView show];
//	NSLog(@"%@, %@", title, message);
//}

- (NSManagedObjectContext *)managedObjectContext
{
	return ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
}
@end
