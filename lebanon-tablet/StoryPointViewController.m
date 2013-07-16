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
#define TIMEOUT 120
#define TIMER 150

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
    _leaveButton.alpha = 0.0;
	_leaveButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:32.0f];
    _stayButton.alpha = 0.0;
	_stayButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:32.0f];
    _illustrationMask.alpha=0.0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lastStoryPoint)];
    self.illustrationImageView.userInteractionEnabled = YES;
    [self.illustrationImageView addGestureRecognizer:tap];
    [self performSelector:@selector(transition) withObject:nil afterDelay: TIMEOUT];
    [self performSelector:@selector(restart:) withObject:nil afterDelay: TIMER];
}

-(void)restart:(id)sender {
	[self performSegueWithIdentifier:@"RESET" sender:self];    
}

- (void)lastStoryPoint
{
    _leaveButton.alpha = 0.0;
    _stayButton.alpha = 0.0;
    _illustrationMask.alpha=0.0;
    _continueButton.alpha = 1.0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)stayButtonPressed:(id)sender {
    _leaveButton.alpha = 0.0;
    _stayButton.alpha = 0.0;
    _continueButton.alpha = 1.0;
    
	StoryPoint *storyPoint = [GameStateManager instance].currentStoryPoint;
	
	[GameStateManager instance].currentStoryPoint = storyPoint.nextStoryPoint;
    if([GameStateManager instance].currentStoryPoint.nextStoryPoint == NULL) {
        [self performSegueWithIdentifier:@"ConclusionSegue" sender:sender];
    }
    
	self.illustrationImageView.image = [GameStateManager instance].currentStoryPoint.illustration;
    self.illustrationMask.alpha=0.0;
	self.yearLabel.text = [NSString stringWithFormat:@"%i", [GameStateManager instance].currentStoryPoint.year];
    self.ncPopulationLabel.text =[NSString stringWithFormat:@"%i", [GameStateManager instance].currentStoryPoint.nCPop];
    self.lebanonPopulationLabel.text = [NSString stringWithFormat:@"%i", [GameStateManager instance].currentStoryPoint.hammanaPop];
    
}
- (void) transition
{
    _leaveButton.alpha += 0.1;
    _stayButton.alpha += 0.1;
	_continueButton.alpha -= 0.1;
    _illustrationMask.alpha += 0.05;
    [_leaveButton setNeedsDisplay];
    [_stayButton setNeedsDisplay];
    [_continueButton setNeedsDisplay];
    [_illustrationMask setNeedsDisplay];
	
	if(_leaveButton.alpha < 1.0) {
		[self performSelector:@selector(transition) withObject:nil afterDelay:0.02];
	}
    
}

- (IBAction)continueButtonPressed:(id)sender {
		[self transition];
    
}

- (IBAction)leaveButtonPressed:(id)sender {
    if(_leaveButton.alpha >= 1.0) {
        [GameStateManager instance].currentStoryPoint = [GameStateManager instance].currentStoryPoint.emigrationStoryPoint;
        [self performSegueWithIdentifier:@"ConclusionSegue" sender:sender];
    }

}
@end
