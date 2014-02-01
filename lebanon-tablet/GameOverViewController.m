//
//  GameOverViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "GameOverViewController.h"

#define TIME_BEFORE_RESET 120

@interface GameOverViewController ()

@end

@implementation GameOverViewController

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
	_endLabel.font = [UIFont fontWithName:@"Garamond" size:34.0f];
	_playAgainLabel.font = [UIFont fontWithName:@"Garamond" size:21.0f];
    _playAgainLabel2.font = [UIFont fontWithName:@"Garamond" size:21.0f];
    _playAgainLabel3.font = [UIFont fontWithName:@"Garamond" size:21.0f];
	[self performSelector:@selector(restart:) withObject:nil afterDelay:TIME_BEFORE_RESET];
}

-(void)restart:(id)sender {
	[self performSegueWithIdentifier:@"RestartSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PlayAgainButton:(id)sender {
	[self performSegueWithIdentifier:@"RestartSegue" sender:self];
}
@end
