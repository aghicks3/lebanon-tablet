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
	
	StoryPoint *storyPoint3 = [[StoryPoint alloc] init];
	storyPoint3.year = 1897;
	storyPoint3.illustration = [UIImage imageNamed:@"asad_s_3.png"];
	
	StoryPoint *storyPoint4 = [[StoryPoint alloc] init];
	storyPoint4.year = 1901;
	storyPoint4.illustration = [UIImage imageNamed:@"asad_s_4.png"];
	
	StoryPoint *emigration1 = [[StoryPoint alloc] init];
	emigration1.year = 1890;
	emigration1.illustration = [UIImage imageNamed:@"asad_e_1.png"];
	
	StoryPoint *emigration2 = [[StoryPoint alloc] init];
	emigration2.year = 1894;
	emigration2.illustration = [UIImage imageNamed:@"asad_e_2.png"];
	
	StoryPoint *emigration3 = [[StoryPoint alloc] init];
	emigration3.year = 1897;
	emigration3.illustration = [UIImage imageNamed:@"asad_e_3.png"];

	StoryPoint *emigration4 = [[StoryPoint alloc] init];
	emigration4.year = 1901;
	emigration4.illustration = [UIImage imageNamed:@"asad_e_4.png"];
	
	storyPoint1.nextStoryPoint = storyPoint2;
	storyPoint2.nextStoryPoint = storyPoint3;
	storyPoint3.nextStoryPoint = storyPoint4;
	storyPoint4.nextStoryPoint = storyPoint4;
	
	storyPoint1.emigrationStoryPoint = emigration1;
	storyPoint2.emigrationStoryPoint = emigration2;
	storyPoint3.emigrationStoryPoint = emigration3;
	storyPoint4.emigrationStoryPoint = emigration4;
	
	[GameStateManager instance].currentStoryPoint = storyPoint1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
