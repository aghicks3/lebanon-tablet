//
//  CharacterSelectionViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "CharacterSelectionViewController.h"
#import "GameStateManager.h"
#import "Character.h"

@interface CharacterSelectionViewController ()

@end

@implementation CharacterSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//handles the user touching a character selection button
-(IBAction)characterIconTouched:(id)sender {
	UIButton *sendingButton = (UIButton *)sender;
	NSLog(@"%@", [sendingButton titleForState:UIControlStateNormal]);

	//update the current player character to the character whose button was pressed
	Character *character = [[Character alloc] init];

	// TODO: get full character info from a plist or SQLite
	NSString *characterName = [sendingButton titleForState:UIControlStateNormal];
	character.name = characterName;
	
	[GameStateManager instance].currentCharacter = character;
	
	[self performSegueWithIdentifier:@"SelectCharacterSegue" sender:sender];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
