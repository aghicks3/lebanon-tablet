//
//  CharacterDetailViewController.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterDetailViewController : UIViewController


@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateOfBirthLabel;
@property (nonatomic, retain) IBOutlet UILabel *genderLabel;
@property (nonatomic, retain) IBOutlet UILabel *literacyLabel;
@property (nonatomic, retain) IBOutlet UILabel *familyLabel;
@property (nonatomic, retain) IBOutlet UILabel *occupationLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UIImageView *portraitImage;
@property (nonatomic, retain) IBOutlet UIImageView *fullBodyImage;

@end
