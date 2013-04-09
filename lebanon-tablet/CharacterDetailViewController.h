//
//  CharacterDetailViewController.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface CharacterDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UILabel *lblDoB;
@property (strong, nonatomic) IBOutlet UILabel *lblGender;
@property (strong, nonatomic) IBOutlet UILabel *lblEducation;
@property (strong, nonatomic) IBOutlet UILabel *lblEcon;
@property (strong, nonatomic) IBOutlet UILabel *lblOcc;
@property (strong, nonatomic) IBOutlet UITextView *tvFamily;

@property (strong, nonatomic) IBOutlet UILabel *profileTitle;
@property (strong, nonatomic) IBOutlet UILabel *nameTitle;
@property (strong, nonatomic) IBOutlet UILabel *ageTitle;
@property (strong, nonatomic) IBOutlet UILabel *dobTitle;
@property (strong, nonatomic) IBOutlet UILabel *genderTitle;
@property (strong, nonatomic) IBOutlet UILabel *educationTitle;
@property (strong, nonatomic) IBOutlet UILabel *econTitle;
@property (strong, nonatomic) IBOutlet UILabel *occTitle;
@property (strong, nonatomic) IBOutlet UILabel *familyTitle;

@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *prevButton;

@property (nonatomic, retain) IBOutlet UIImageView *portraitImage;
@property (nonatomic, retain) IBOutlet UIImageView *fullBodyImage;

@end
