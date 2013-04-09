//
//  ConclusionViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "ConclusionViewController.h"
#import "GameStateManager.h"
#import "StoryPoint.h"

@interface ConclusionViewController ()

@end

@implementation ConclusionViewController

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
	//get the current StoryPoint from the GameStateManager
	StoryPoint *currentStoryPoint = [[GameStateManager instance] currentStoryPoint];
	
	NSLog(@"%i", currentStoryPoint.year);
	
	//populate the interface elements with the current story point's info
	self.yearLabel.text = [NSString stringWithFormat:@"%i", currentStoryPoint.year];
	self.yearLabel.font = [UIFont fontWithName:@"Garamond" size:50.0f];
	self.illustrationImageView.image = currentStoryPoint.illustration;
	self.ncPopulationLabel.font = [UIFont fontWithName:@"Garamond" size:22.0f];
    self.ncPopulationLabel.text =[NSString stringWithFormat:@"%i", currentStoryPoint.nCPop];
	self.lebanonPopulationLabel.font = [UIFont fontWithName:@"Garamond" size:22.0f];
    self.lebanonPopulationLabel.text = [NSString stringWithFormat:@"%i", currentStoryPoint.hammanaPop];
	
	_nextButton.titleLabel.font = [GameStateManager instance].buttonFont;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
