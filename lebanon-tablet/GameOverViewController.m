//
//  GameOverViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "GameOverViewController.h"

#define TIME_BEFORE_RESET 5.0

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
	_endLabel.font = [UIFont fontWithName:@"Garamond" size:120.0f];
	_playAgainLabel.font = [UIFont fontWithName:@"Garamond" size:50.0f];
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

@end
