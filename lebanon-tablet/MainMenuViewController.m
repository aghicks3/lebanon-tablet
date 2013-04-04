//
//  MainMenuViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "MainMenuViewController.h"
#import "GameStateManager.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

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
	_titleLabel.font = [UIFont fontWithName:@"Garamond" size:100.0f];
	_subtitleLabel.font = [UIFont fontWithName:@"Garamond" size:30.0f];
	GameStateManager *gsm = [GameStateManager instance];
	
	_playButton.font = gsm.buttonFont;
	NSURL *songURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"laytana" ofType:@"m4a"]];
	
	NSError *error;
	
	gsm.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songURL error:&error];
	gsm.audioPlayer.volume = 0.5;
	[gsm.audioPlayer play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
