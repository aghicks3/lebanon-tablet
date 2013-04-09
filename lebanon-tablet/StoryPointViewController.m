//
//  StoryPointViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "StoryPointViewController.h"
#import "StoryPoint.h"
#import "GameStateManager.h"

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
	
	NSLog(@"%i", currentStoryPoint.year);
	
	//populate the interface elements with the current story point's info
	self.yearLabel.text = [NSString stringWithFormat:@"%i", currentStoryPoint.year];
	self.yearLabel.font = [UIFont fontWithName:@"Garamond" size:50.0f];
	self.ncPopulationLabel.font = [UIFont fontWithName:@"Garamond" size:22.0f];
    self.ncPopulationLabel.text =[NSString stringWithFormat:@"%i", currentStoryPoint.nCPop];
	self.lebanonPopulationLabel.font = [UIFont fontWithName:@"Garamond" size:22.0f];
    self.lebanonPopulationLabel.text = [NSString stringWithFormat:@"%i", currentStoryPoint.hammanaPop];
	self.illustrationImageView.image = currentStoryPoint.illustration;
	_nextButton.titleLabel.font = [GameStateManager instance].buttonFont;
    self.LeaveButton.alpha = 0.0;
    self.StayButton.alpha = 0.0;
    self.illustrationMask.alpha=0.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)StayButtonAction:(id)sender {
    self.LeaveButton.alpha = 0.0;
    self.StayButton.alpha = 0.0;
    self.ContinueButton.alpha = 1.0;
    
    Character *character = [GameStateManager instance].currentCharacter;
	StoryPoint *storyPoint = [GameStateManager instance].currentStoryPoint;
	
	[GameStateManager instance].currentStoryPoint = storyPoint.nextStoryPoint;
    if([GameStateManager instance].currentStoryPoint.nextStoryPoint == NULL)
    {
        [self performSegueWithIdentifier:@"ConclusionSegue" sender:sender];
    }
    
	self.illustrationImageView.image = [GameStateManager instance].currentStoryPoint.illustration;
    self.illustrationMask.alpha=0.0;
    
    //perform the appropriate segue based on the game state
	/*if( character.story5 == storyPoint.illustration ) {
		[self performSegueWithIdentifier:@"ConclusionSeque" sender:sender];
	} else {
		[self performSegueWithIdentifier:@"NextStoryPointSegue" sender:sender];
	}*/
    
    
}
- (void) transition
{
    self.LeaveButton.alpha += 0.2;
    self.StayButton.alpha += 0.2;
    self.ContinueButton.alpha -= 0.2;
    self.illustrationMask.alpha += 0.1;
    [_LeaveButton setNeedsDisplay];
    [_StayButton setNeedsDisplay];
    [_ContinueButton setNeedsDisplay];
    [_illustrationMask setNeedsDisplay];
    //[NSThread sleepForTimeInterval:0.2];
    
}

- (IBAction)ContinueButtonAction:(id)sender {
    /*self.LeaveButton.alpha = 1.0;
    self.StayButton.alpha = 1.0;
    self.ContinueButton.alpha = 0.0;
    self.illustrationMask.alpha=0.4;*/
    
    int frames = 5;
    for(int i=0; i < frames; i++)
    {
        //[self performSelector:@selector(transition) withObject:(NULL) afterDelay:(0.5)];
        [self performSelectorOnMainThread:@selector(transition) withObject:(NULL) waitUntilDone:(NO)];
        /*self.LeaveButton.alpha += 0.2;
        self.StayButton.alpha += 0.2;
        self.ContinueButton.alpha -= 0.2;
        self.illustrationMask.alpha += 0.1;*/
    }
    
}
- (IBAction)LeaveButtonAction:(id)sender {
    if(self.LeaveButton.alpha == 1.0)
    {
        [GameStateManager instance].currentStoryPoint = [GameStateManager instance].currentStoryPoint.emigrationStoryPoint;
        
        [self performSegueWithIdentifier:@"ConclusionSegue" sender:sender];
    }
    
}
@end
