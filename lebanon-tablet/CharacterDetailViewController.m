//
//  CharacterDetailViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "CharacterDetailViewController.h"
#import "GameStateManager.h"
#import "Character.h"
#import "StoryPoint.h"

@interface CharacterDetailViewController ()

@end

@implementation CharacterDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//get the selected character from the GameStateManager
	Character *selectedCharacter = [[GameStateManager instance] currentCharacter];
	self.nameLabel.text = selectedCharacter.name;
	
	//get the initial story point
	//this is hardcoded now until we have the data loading
	StoryPoint *storyPoint1 = [[StoryPoint alloc] init];
	storyPoint1.year = 1890;
	storyPoint1.illustration = [UIImage imageNamed:@"asad_s_1.png"];
	
	StoryPoint *storyPoint2 = [[StoryPoint alloc] init];
	storyPoint2.year = 1894;
	storyPoint2.illustration = [UIImage imageNamed:@"asad_s_2.png"];
	
	storyPoint1.nextStoryPoint = storyPoint2;
	storyPoint2.nextStoryPoint = storyPoint2;
	
	[GameStateManager instance].currentStoryPoint = storyPoint1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
