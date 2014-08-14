//
//  AddDogViewController.h
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;
@class Dog;

@protocol AddDogViewControllerDelegate

- (void)addedDog:(Dog *)dog toPerson:(Person *)person;

@end

@interface AddDogViewController : UIViewController

@property Person *dogOwner;
@property id<AddDogViewControllerDelegate> delegate;

@end
