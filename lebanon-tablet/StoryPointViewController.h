//
//  StoryPointViewController.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryPointViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *yearLabel;
@property (nonatomic, retain) IBOutlet UILabel *ncPopulationLabel;
@property (nonatomic, retain) IBOutlet UILabel *lebanonPopulationLabel;
@property (nonatomic, retain) IBOutlet UIImageView *illustrationImageView;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *stayButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *leaveButton;
@property (weak, nonatomic) IBOutlet UIImageView *illustrationMask;
@property (weak, nonatomic) IBOutlet UIButton *characterButton;
@property (weak, nonatomic) IBOutlet UIImageView *lebanonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ncLabel;

- (IBAction)stayButtonPressed:(id)sender;
- (IBAction)leaveButtonPressed:(id)sender;
- (IBAction)continueButtonPressed:(id)sender;
- (IBAction)characterButtonPressed:(id)sender;

@end
