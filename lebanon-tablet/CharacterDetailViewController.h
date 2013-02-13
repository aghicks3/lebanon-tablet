//
//  CharacterDetailViewController.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UILabel *lblDoB;
@property (strong, nonatomic) IBOutlet UILabel *lblGender;
@property (strong, nonatomic) IBOutlet UILabel *lblEducation;
@property (strong, nonatomic) IBOutlet UILabel *lblEcon;
@property (strong, nonatomic) IBOutlet UILabel *lblOcc;
@property (strong, nonatomic) IBOutlet UITextView *tvFamily;



@property (nonatomic, retain) IBOutlet UIImageView *portraitImage;
@property (nonatomic, retain) IBOutlet UIImageView *fullBodyImage;

@end
