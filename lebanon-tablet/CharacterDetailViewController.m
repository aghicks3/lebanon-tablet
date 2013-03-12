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
	self.lblName.text = selectedCharacter.name;
    self.lblAge.text = [NSString stringWithFormat:@"%d",selectedCharacter.age];
    self.lblDoB.text = selectedCharacter.dateOfBirth;
    self.lblGender.text = selectedCharacter.gender;
    self.lblEducation.text = selectedCharacter.education;
    self.lblEcon.text = selectedCharacter.economicStatus;
    self.lblOcc.text = selectedCharacter.occupation;
    self.tvFamily.text = selectedCharacter.family;
	
    self.portraitImage.image = selectedCharacter.portrait;
    self.fullBodyImage.image = selectedCharacter.fullBodyImage;
    
	//get the initial story point
	//this is hardcoded now until we have the data loading
	StoryPoint *storyPoint1 = [[StoryPoint alloc] init];
	storyPoint1.year = 1890;
	storyPoint1.illustration = selectedCharacter.story1;
	
	StoryPoint *storyPoint2 = [[StoryPoint alloc] init];
	storyPoint2.year = 1894;
	storyPoint2.illustration = selectedCharacter.story2;
	
	StoryPoint *storyPoint3 = [[StoryPoint alloc] init];
	storyPoint3.year = 1897;
	storyPoint3.illustration = selectedCharacter.story3;
	
	StoryPoint *storyPoint4 = [[StoryPoint alloc] init];
	storyPoint4.year = 1901;
	storyPoint4.illustration = selectedCharacter.story4;
	
	StoryPoint *storyPoint5 = [[StoryPoint alloc] init];
	storyPoint5.year = 1905;
	storyPoint5.illustration = selectedCharacter.story5;
    
	StoryPoint *emigration1 = [[StoryPoint alloc] init];
	emigration1.year = 1890;
	emigration1.illustration = selectedCharacter.emigration1;
	
	StoryPoint *emigration2 = [[StoryPoint alloc] init];
	emigration2.year = 1894;
	emigration2.illustration = selectedCharacter.emigration2;
	
	StoryPoint *emigration3 = [[StoryPoint alloc] init];
	emigration3.year = 1897;
	emigration3.illustration = selectedCharacter.emigration3;

	StoryPoint *emigration4 = [[StoryPoint alloc] init];
	emigration4.year = 1901;
	emigration4.illustration = selectedCharacter.emigration4;
	
	StoryPoint *emigration5 = [[StoryPoint alloc] init];
	emigration5.year = 1905;
	emigration5.illustration = selectedCharacter.emigration5;
	
	storyPoint1.nextStoryPoint = storyPoint2;
	storyPoint2.nextStoryPoint = storyPoint3;
	storyPoint3.nextStoryPoint = storyPoint4;
	storyPoint4.nextStoryPoint = storyPoint5;
	storyPoint5.nextStoryPoint = storyPoint5;
	
	storyPoint1.emigrationStoryPoint = emigration1;
	storyPoint2.emigrationStoryPoint = emigration2;
	storyPoint3.emigrationStoryPoint = emigration3;
	storyPoint4.emigrationStoryPoint = emigration4;
	storyPoint5.emigrationStoryPoint = emigration5;
	
	[GameStateManager instance].currentStoryPoint = storyPoint1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
