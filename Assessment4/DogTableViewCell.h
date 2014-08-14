//
//  DogTableViewCell.h
//  Assessment4
//
//  Created by Iván Mervich on 8/14/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dog;

@interface DogTableViewCell : UITableViewCell

@property Dog *dog;

- (void)showDogData;

@end
