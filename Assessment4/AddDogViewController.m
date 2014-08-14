//
//  AddDogViewController.m
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"
#import "AppDelegate.h"
#import "Dog.h"
#import "Person.h"

#define dogEntity @"Dog"

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;

@end

@implementation AddDogViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";
}

#pragma mark - IBActions

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
	BOOL isAdding;
	if (!self.dog) {
		isAdding = YES;
		NSLog(@"Adding dog");
		self.dog = [NSEntityDescription insertNewObjectForEntityForName:dogEntity inManagedObjectContext:[self managedObjectContext]];
		self.dog.name = self.nameTextField.text;
		self.dog.breed = self.breedTextField.text;
		self.dog.color = self.colorTextField.text;

		[self.dogOwner addDogsObject:self.dog];
	} else {
		self.dog.name = self.nameTextField.text;
		self.dog.breed = self.breedTextField.text;
		self.dog.color = self.colorTextField.text;

		NSLog(@"editing dog!");
	}

	[self.dogOwner addDogsObject:self.dog];
	[self saveContext];

	// tell the DogsVC that a dog was added to its owner
	if (isAdding) {
		[self.delegate addedDog:self.dog toPerson:self.dogOwner];
	} else {
		[self.delegate editedDog:self.dog];
	}

    [self dismissViewControllerAnimated:YES completion:nil];
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
