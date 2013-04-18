//
//  MainMenuViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "MainMenuViewController.h"
#import "GameStateManager.h"

#define LOOP_FOREVER -1

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
	GameStateManager *gsm = [GameStateManager instance];

	howToDisplayed = NO;
	
	NSURL *songURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"laytana" ofType:@"m4a"]];
	
	NSError *error;
	
	gsm.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songURL error:&error];
	gsm.audioPlayer.volume = 0.5;
	gsm.audioPlayer.numberOfLoops = LOOP_FOREVER;
	[gsm.audioPlayer play];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
	if (sender.state == UIGestureRecognizerStateEnded)     {
		if(howToDisplayed) {
			[self performSegueWithIdentifier:@"characterSelectionSegue" sender:sender];
		} else {
			_imageView.image = [UIImage imageNamed:@"howTo.png"];
			howToDisplayed = YES;
		}
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
