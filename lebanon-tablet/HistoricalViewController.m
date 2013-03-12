//
//  HistoricalViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "HistoricalViewController.h"

#define HORIZONTAL_INSET 20
#define VERTICAL_INSET 80

@interface HistoricalViewController ()

@end

@implementation HistoricalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)moviePlaybackDidFinish:(NSNotification *)notification {
    MPMoviePlayerController *moviePlayer = [notification object];
    [[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object:moviePlayer];
	
    if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)]) {
        [moviePlayer.view removeFromSuperview];
    }
	
	NSLog(@"Movie finished playing");
	[self performSegueWithIdentifier:@"GameOverSegue" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initializeVideoPlayer];
}

-(void)initializeVideoPlayer {
	NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Movie" ofType:@"mov"]];
	
	_moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(moviePlaybackDidFinish:)
												 name:MPMoviePlayerPlaybackDidFinishNotification
											   object:_moviePlayer];
	_moviePlayer.controlStyle = MPMovieControlStyleNone;
	_moviePlayer.shouldAutoplay = YES;
	_moviePlayer.view.bounds = self.view.bounds;
	_moviePlayer.backgroundView.backgroundColor = [UIColor clearColor];
	CGRect viewInsetRect = CGRectMake(HORIZONTAL_INSET, VERTICAL_INSET, 1024-2*HORIZONTAL_INSET, 768-(VERTICAL_INSET*2+20));
	[[_moviePlayer view] setFrame:viewInsetRect];
	[self.view addSubview:_moviePlayer.view];
	[_moviePlayer setFullscreen:NO animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
