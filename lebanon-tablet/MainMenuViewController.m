//
//  MainMenuViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "MainMenuViewController.h"
#import "GameStateManager.h"
#import "QuartzCore/CAAnimation.h"


#define LOOP_FOREVER -1

@interface MainMenuViewController ()
{
    NSString *dbPathString, *docPathString;
    sqlite3 *characterDB;
    
}

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

- (void)createOrOpenDB
{
    //dbPathString = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Journey"];
    dbPathString = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Belonging"];
    
    char *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *resourceError;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *txtPath = [documentsDirectory stringByAppendingPathComponent:@"Journey"];
    
    dbPathString = txtPath;
    
    if ([fileManager fileExistsAtPath:txtPath]) {
        //[fileManager removeItemAtPath:txtPath error:&resourceError];
    } else {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"Journey" ofType:@"sqlite"];
        [fileManager copyItemAtPath:resourcePath toPath:txtPath error:&resourceError];
    }
    
    //if(![fileManager fileExistsAtPath:dbPathString])
    if(![fileManager fileExistsAtPath:txtPath])
    {
        //const char *dbPath = [dbPathString UTF8String];
        const char *dbPath = [docPathString UTF8String];
        
        //create db here
        if(sqlite3_open(dbPath, &characterDB)== SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CHARACTER (id INTEGER PRIMARY KEY, name TEXT, dateOfBirth TEXT, gender TEXT, age NUMERIC, family TEXT, education TEXT, economicStatus TEXT, occupation TEXT, portrait TEXT, fullbody TEXT";
            sqlite3_exec(characterDB, sql_stmt, NULL, NULL, &error);
            sqlite3_close(characterDB);
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createOrOpenDB];
    
    
    
	GameStateManager *gsm = [GameStateManager instance];
    
    //TOGGLE JOURNEY OR BELONGING
    //gsm.isJourney = true;
    gsm.isJourney = false;

    
    //If we're using the Belonging database, change the images.
    if(!gsm.isJourney)
    {
        _imageView.image = [UIImage imageNamed:@"Belonging Title Screen.png"];
    }
    
	howToDisplayed = NO;
	
	NSURL *songURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"laytana" ofType:@"m4a"]];
	
	NSError *error;
	
	gsm.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songURL error:&error];
	gsm.audioPlayer.volume = 1.5;
	gsm.audioPlayer.numberOfLoops = LOOP_FOREVER;
	[gsm.audioPlayer play];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
	if (sender.state == UIGestureRecognizerStateEnded)     {
		if(howToDisplayed) {
			[self performSegueWithIdentifier:@"characterSelectionSegue" sender:sender];
		} else {
			UIImage *image1 = _imageView.image;
			UIImage *image2 = [UIImage imageNamed:@"howTo.png"];
			CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"contents"];
			crossFade.duration = 0.5;
			crossFade.fromValue = (__bridge id)(image1.CGImage);
			crossFade.toValue = (__bridge id)(image2.CGImage);
			[_imageView.layer addAnimation:crossFade forKey:@"animateContents"];
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
