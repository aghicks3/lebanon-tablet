//
//  StoryPointViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "StoryPointViewController.h"
#import "StoryPoint.h"

@interface StoryPointViewController ()

@end

@implementation StoryPointViewController

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
	// Do any additional setup after loading the view.
	
	//get the current StoryPoint from the GameStateManager
	StoryPoint *currentStoryPoint = [[GameStateManager instance] currentStoryPoint];
	
	//populate the interface elements with the current story point's info
	self.yearLabel.text = [NSString stringWithFormat:@"%i", currentStoryPoint.year];
	self.descriptionTextView.text = currentStoryPoint.description;
	self.illustrationImageView.image = currentStoryPoint.illustration;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
