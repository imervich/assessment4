//
//  DogTableViewCell.m
//  Assessment4
//
//  Created by Iván Mervich on 8/14/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogTableViewCell.h"
#import "Dog.h"

@interface DogTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *breedLabel;


@end

@implementation DogTableViewCell

- (void)showDogData
{
	self.nameLabel.text = self.dog.name;
	self.colorLabel.text = self.dog.color;
	self.breedLabel.text = self.dog.breed;
}

@end
