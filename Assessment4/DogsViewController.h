//
//  DogsViewController.h
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;
@interface DogsViewController : UIViewController

#define mmAddSegue @"AddDogSegue"
#define mmDogCellIdentifier @"dogCell"

@property Person *dogOwner;

@end
