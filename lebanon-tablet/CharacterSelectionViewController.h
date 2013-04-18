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

@interface CharacterSelectionViewController : UIViewController


-(IBAction)characterIconTouched:(id)sender;

//button properties
@property (strong, nonatomic) IBOutlet UIButton *btnCharA;
@property (strong, nonatomic) IBOutlet UIButton *btnCharB;
@property (strong, nonatomic) IBOutlet UIButton *btnCharC;
@property (strong, nonatomic) IBOutlet UIButton *btnCharD;
@property (strong, nonatomic) IBOutlet UILabel	*chooseLabel;

@end
