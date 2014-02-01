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
#define TIMEOUT 210
#define TIMER 210

@interface StoryPointViewController ()
{
    sqlite3 *storyPointLog;
    NSString *dbPathString,*docPathString, *previousTime;
    int currentStoryID;
}
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
    
    if(![GameStateManager instance].isJourney)
    {
        [_stayButton setTitle:@"Stay in America" forState:UIControlStateNormal];
        [_stayButton setTitle:@"Stay in America" forState:UIControlStateSelected];
        [_stayButton setTitle:@"Stay in America" forState:UIControlStateHighlighted];
        
        [_leaveButton setTitle:@"Return to Lebanon" forState:UIControlStateNormal];
        [_leaveButton setTitle:@"Return to Lebanon" forState:UIControlStateSelected];
        [_leaveButton setTitle:@"Return to Lebanon" forState:UIControlStateHighlighted];
    }
    
    previousTime = [NSDate date];
    [self createOrOpenDB];
	// Do any additional setup after loading the view.
	//get the current StoryPoint from the GameStateManager
	StoryPoint *currentStoryPoint = [[GameStateManager instance] currentStoryPoint];
	
    currentStoryID = currentStoryPoint.idNum;
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
    _characterButton.alpha = 0.0;
	_characterButton.titleLabel.font = [UIFont fontWithName:@"Garamond" size:24.0f];
    _illustrationMask.alpha=0.0;
    _lebanonLabel.alpha=0.0;
    _ncLabel.alpha=0.0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lastStoryPoint)];
    self.illustrationImageView.userInteractionEnabled = YES;
    [self.illustrationImageView addGestureRecognizer:tap];
    //[self performSelector:@selector(transition) withObject:nil afterDelay: TIMEOUT];
    [self performSelector:@selector(restart:) withObject:nil afterDelay: TIMER];
    
    if(! [GameStateManager instance].isJourney)
    {
        CGPoint stayCenter = _stayButton.center;
        _stayButton.center = _leaveButton.center;
        _leaveButton.center = stayCenter;
        
        self.stayButton.titleLabel.text = @"Stay In America";
        self.leaveButton.titleLabel.text = @"Return to Lebanon";
        
    }
}

- (void)createOrOpenDB
{
    //dbPathString = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Journey"];
    dbPathString = [[NSBundle mainBundle] pathForResource:@"Journey" ofType:@"sqlite"];
    
    char *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *resourceError;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *txtPath = [documentsDirectory stringByAppendingPathComponent:@"Journey"];
    docPathString = txtPath;
    if ([fileManager fileExistsAtPath:txtPath]) {
        //[fileManager removeItemAtPath:txtPath error:&resourceError];
    } else {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"Journey" ofType:@"sqlite"];
        [fileManager copyItemAtPath:resourcePath toPath:txtPath error:&resourceError];
    }
    
    //if(![fileManager fileExistsAtPath:dbPathString])
    if(![fileManager fileExistsAtPath:docPathString])
    {
        //const char *dbPath = [dbPathString UTF8String];
        const char *dbPath = [docPathString UTF8String];
        //create db here
        if(sqlite3_open(dbPath, &storyPointLog)== SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS StoryPointLog (id INTEGER PRIMARY KEY, playerID NUMERIC, startTime TEXT, storyPointID NUMERIC, endTime TEXT, timeout NUMERIC";
            sqlite3_exec(storyPointLog, sql_stmt, NULL, NULL, &error);
            sqlite3_close(storyPointLog);
        }
    }
}

-(void)restart:(id)sender {
    
    //if(sqlite3_open_v2([dbPathString UTF8String], &(storyPointLog), SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, 0)==SQLITE_OK)
    if(sqlite3_open_v2([docPathString UTF8String], &(storyPointLog), SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, 0)==SQLITE_OK)
    {
        int player = [GameStateManager instance].playerID;
        
        NSString *query = [ NSString stringWithFormat:@"INSERT INTO StoryPointLog VALUES ( NULL, %d, '%@', %d, '%@', 1)", player, previousTime, currentStoryID, [NSDate date] ];
        const char *query_sql = [query UTF8String];
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(storyPointLog, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Insert successful");
            }
            else
            {
                NSLog(@"Save Error: %d", sqlite3_errcode(storyPointLog));
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(storyPointLog);
        previousTime = [NSDate date];
        
    }
	[self performSegueWithIdentifier:@"RESET" sender:self];    
}

- (void)lastStoryPoint
{
    _leaveButton.alpha = 0.0;
    _stayButton.alpha = 0.0;
    _characterButton.alpha = 0.0;
    _illustrationMask.alpha=0.0;
    _lebanonLabel.alpha=0.0;
    _ncLabel.alpha=0.0;
    _continueButton.alpha = 1.0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) bright:(NSNumber *)_counter
{
    double counter = [_counter intValue];
    int frame = 10;
    
    if (counter <= frame) {
        _ncPopulationLabel.textColor = [UIColor colorWithRed:(0.535098 + (1-0.535) * counter/frame) green:0 + counter/frame blue:0 + counter/frame alpha:1];
        _lebanonPopulationLabel.textColor = [UIColor colorWithRed:(0.535098 + (1-0.535) * counter / frame) green:0 + counter/frame blue:0 + counter/frame alpha:1];
        _yearLabel.textColor = [UIColor colorWithRed:(0.535098 + (1-0.535) * counter / frame) green:0 + counter/frame blue:0 + counter/frame alpha:1];
           }
    
   if (counter > frame) {
        _ncPopulationLabel.textColor = [UIColor colorWithRed:1-(counter-10)/frame*0.445098 green:1 - counter/frame*2 blue:1 - counter/frame*2 alpha:1];
        _lebanonPopulationLabel.textColor = [UIColor colorWithRed:1-(counter-10)/frame*0.445098 green:1 - counter/frame*2 blue:1 - counter/frame*2 alpha:1];
        _yearLabel.textColor = [UIColor colorWithRed:1-(counter-10)/frame*0.445098 green:1 - counter/frame*2 blue:1 - counter/frame*2 alpha:1];
           }
    
    
    if (counter < 2*frame) {
        counter += 1;
        [self performSelector:@selector(bright:) withObject:[NSNumber numberWithInt:counter] afterDelay:.05];
    }
    
}

- (IBAction)stayButtonPressed:(id)sender {
    //Log
    //if(sqlite3_open_v2([dbPathString UTF8String], &(storyPointLog), SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, 0)==SQLITE_OK)
    if(sqlite3_open_v2([docPathString UTF8String], &(storyPointLog), SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, 0)==SQLITE_OK)
    {
        int player = [GameStateManager instance].playerID;
        
        NSString *query = [ NSString stringWithFormat:@"INSERT INTO StoryPointLog VALUES ( NULL, %d, '%@', %d, '%@', 0)", player, previousTime, currentStoryID, [NSDate date] ];
        const char *query_sql = [query UTF8String];
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(storyPointLog, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Insert successful");
            }
            else
            {
                NSLog(@"Save Error: %d", sqlite3_errcode(storyPointLog));
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(storyPointLog);
        previousTime = [NSDate date];
        
    }
    
    
    _leaveButton.alpha = 0.0;
    _stayButton.alpha = 0.0;
    _characterButton.alpha = 0.0;
    _lebanonLabel.alpha=0.0;
    _ncLabel.alpha=0.0;
    _continueButton.alpha = 1.0;
    
	StoryPoint *storyPoint = [GameStateManager instance].currentStoryPoint;
	
	[GameStateManager instance].currentStoryPoint = storyPoint.nextStoryPoint;
    currentStoryID = [GameStateManager instance].currentStoryPoint.idNum;
    if([GameStateManager instance].currentStoryPoint.nextStoryPoint == NULL) {
        
        //Log
        //if(sqlite3_open_v2([dbPathString UTF8String], &(storyPointLog), SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, 0)==SQLITE_OK)
        if(sqlite3_open_v2([docPathString UTF8String], &(storyPointLog), SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, 0)==SQLITE_OK)
        {
            int player = [GameStateManager instance].playerID;
            
            NSString *query = [ NSString stringWithFormat:@"INSERT INTO StoryPointLog VALUES ( NULL, %d, '%@', %d, '%@', 0)", player, previousTime, currentStoryID, [NSDate date] ];
            const char *query_sql = [query UTF8String];
            sqlite3_stmt *statement;
            if(sqlite3_prepare_v2(storyPointLog, query_sql, -1, &statement, NULL) == SQLITE_OK)
            {
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    NSLog(@"Insert successful");
                }
                else
                {
                    NSLog(@"Save Error: %d", sqlite3_errcode(storyPointLog));
                }
            }
            sqlite3_finalize(statement);
            sqlite3_close(storyPointLog);
            previousTime = [NSDate date];
            
        }
        
        [self performSegueWithIdentifier:@"ConclusionSegue" sender:sender];
    }
    
	self.illustrationImageView.image = [GameStateManager instance].currentStoryPoint.illustration;
    self.illustrationMask.alpha=0.0;
	self.yearLabel.text = [NSString stringWithFormat:@"%i", [GameStateManager instance].currentStoryPoint.year];
    self.ncPopulationLabel.text =[NSString stringWithFormat:@"%i", [GameStateManager instance].currentStoryPoint.nCPop];
    self.lebanonPopulationLabel.text = [NSString stringWithFormat:@"%i", [GameStateManager instance].currentStoryPoint.hammanaPop];
    [self bright:[NSNumber numberWithInt:0.0]];
}
- (void) transition
{
    _leaveButton.alpha += 0.1;
    _stayButton.alpha += 0.1;
    //_characterButton.alpha += 0.1; //start over button
    _lebanonLabel.alpha +=0.1;
    _ncLabel.alpha +=0.1;
	_continueButton.alpha -= 0.1;
    _illustrationMask.alpha += 0.05;
    [_leaveButton setNeedsDisplay];
    [_stayButton setNeedsDisplay];
    [_characterButton setNeedsDisplay];
    [_continueButton setNeedsDisplay];
    [_lebanonLabel setNeedsDisplay];
    [_ncLabel setNeedsDisplay];
    [_illustrationMask setNeedsDisplay];
	
	if(_leaveButton.alpha < 1.0) {
		[self performSelector:@selector(transition) withObject:nil afterDelay:0.02];
	}
    
}


- (IBAction)continueButtonPressed:(id)sender {
    
		[self transition];
    
}

- (IBAction)characterButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"characterSelectionSegue" sender:sender];
}

- (IBAction)leaveButtonPressed:(id)sender {
    if(_leaveButton.alpha >= 1.0) {
        
        //Log current
        //if(sqlite3_open_v2([dbPathString UTF8String], &(storyPointLog), SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, 0)==SQLITE_OK)
        if(sqlite3_open_v2([docPathString UTF8String], &(storyPointLog), SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, 0)==SQLITE_OK)
        {
            int player = [GameStateManager instance].playerID;
            
            NSString *query = [ NSString stringWithFormat:@"INSERT INTO StoryPointLog VALUES ( NULL, %d, '%@', %d, '%@', 0)", player, previousTime, currentStoryID, [NSDate date] ];
            const char *query_sql = [query UTF8String];
            sqlite3_stmt *statement;
            if(sqlite3_prepare_v2(storyPointLog, query_sql, -1, &statement, NULL) == SQLITE_OK)
            {
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    NSLog(@"Insert successful");
                }
                else
                {
                    NSLog(@"Save Error: %d", sqlite3_errcode(storyPointLog));
                }
            }
            sqlite3_finalize(statement);
            sqlite3_close(storyPointLog);
            previousTime = [NSDate date];
            
        }
        
        [GameStateManager instance].currentStoryPoint = [GameStateManager instance].currentStoryPoint.emigrationStoryPoint;
        
        //Log final
        //if(sqlite3_open_v2([dbPathString UTF8String], &(storyPointLog), SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, 0)==SQLITE_OK)
        if(sqlite3_open_v2([docPathString UTF8String], &(storyPointLog), SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, 0)==SQLITE_OK)
        {
            int player = [GameStateManager instance].playerID;
            
            NSString *query = [ NSString stringWithFormat:@"INSERT INTO StoryPointLog VALUES ( NULL, %d, '%@', %d, '%@', 0)", player, previousTime, [GameStateManager instance].currentStoryPoint.idNum, [NSDate date] ];
            const char *query_sql = [query UTF8String];
            sqlite3_stmt *statement;
            if(sqlite3_prepare_v2(storyPointLog, query_sql, -1, &statement, NULL) == SQLITE_OK)
            {
                if(sqlite3_step(statement) == SQLITE_DONE)
                {
                    NSLog(@"Insert successful");
                }
                else
                {
                    NSLog(@"Save Error: %d", sqlite3_errcode(storyPointLog));
                }
            }
            sqlite3_finalize(statement);
            sqlite3_close(storyPointLog);
            previousTime = [NSDate date];
            
        }
        
        
        [self performSegueWithIdentifier:@"ConclusionSegue" sender:sender];
    }
}
@end
