//
//  CharacterSelectionViewController.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Character.h"

@interface CharacterSelectionViewController : UIViewController {IBOutlet UIButton *selectButton; float startLoc;}

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


@property (nonatomic, retain) IBOutlet UIImageView *portraitImage;
@property (nonatomic, retain) IBOutlet UIImageView *fullBodyImage;

@property (weak, nonatomic) IBOutlet UIImageView *illustrationMask;

-(IBAction)backButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

-(IBAction)continueButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *continueButton;


-(IBAction)characterIconTouched:(id)sender;

//button properties
@property (strong, nonatomic) IBOutlet UIButton *btnCharA;
@property (strong, nonatomic) IBOutlet UIButton *btnCharB;
@property (strong, nonatomic) IBOutlet UIButton *btnCharC;
@property (strong, nonatomic) IBOutlet UIButton *btnCharD;
@property (strong, nonatomic) IBOutlet UILabel	*chooseLabel;



@end
