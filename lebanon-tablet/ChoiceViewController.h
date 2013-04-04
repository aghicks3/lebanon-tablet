//
//  ChoiceViewController.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton *stayButton;
@property (nonatomic, retain) IBOutlet UIButton *emigrateButton;

-(IBAction)stayButtonTouched:(id)sender;
-(IBAction)leaveButtonTouched:(id)sender;

@end
