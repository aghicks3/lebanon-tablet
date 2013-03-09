//
//  CharacterSelectionViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "CharacterSelectionViewController.h"
#import "GameStateManager.h"
#import "Character.h"

@interface CharacterSelectionViewController ()
{
    NSMutableArray *characters;
    sqlite3 *characterDB;
    NSString *dbPathString;
}

@end

@implementation CharacterSelectionViewController
@synthesize btnCharA,btnCharB,btnCharC,btnCharD,btnCharE;
@synthesize lblName, lblAge;

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
    dbPathString = [[NSBundle mainBundle] pathForResource:@"Journey" ofType:@"sqlite"];
    
    char *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *resourceError;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *txtPath = [documentsDirectory stringByAppendingPathComponent:@"Journey"];
    
    if ([fileManager fileExistsAtPath:txtPath]) {
        [fileManager removeItemAtPath:txtPath error:&resourceError];
    } else {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"Journey" ofType:@"sqlite"];
        [fileManager copyItemAtPath:resourcePath toPath:txtPath error:&resourceError];
    }
    
    if(![fileManager fileExistsAtPath:dbPathString])
    {
        const char *dbPath = [dbPathString UTF8String];
        
        //create db here
        if(sqlite3_open(dbPath, &characterDB)== SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CHARACTER (id INTEGER PRIMARY KEY, name TEXT, dateOfBirth TEXT, gender TEXT, age NUMERIC, family TEXT, education TEXT, economicStatus TEXT, occupation TEXT, portrait TEXT, fullbody TEXT, story1 TEXT, emigrate1 TEXT, story2 TEXT, emigrate2 TEXT, story3 TEXT, emigrate3 TEXT, story4 TEXT, emigrate4 TEXT, story5 TEXT, emigrate5 TEXT";
            sqlite3_exec(characterDB, sql_stmt, NULL, NULL, &error);
            sqlite3_close(characterDB);
        }
    }
}


//handles the user touching a character selection button
-(IBAction)characterIconTouched:(id)sender
{
	UIButton *sendingButton = (UIButton *)sender;
	NSLog(@"%@", [sendingButton titleForState:UIControlStateNormal]);

	//update the current player character to the character whose button was pressed
	Character *character = [[Character alloc] init];
	NSString *characterName = [sendingButton titleForState:UIControlStateNormal];
    
    Character *current = [[Character alloc]init];
    for(int i = 0; i < characters.count; i++) {
        current = [characters objectAtIndex:i];
        if([current.name isEqualToString:characterName]) {
            character = [characters objectAtIndex:i];
            [lblAge setText:[NSString stringWithFormat:@"%d",current.age ]];
            [lblName setText:current.name];
            break;
        }
        
    }
	// TODO: get full character info from a plist or SQLite
    if(!character.name) {
		character.name = characterName;
    }
    
	
	[GameStateManager instance].currentCharacter = character;	
}

- (IBAction)confirmIconTouched:(id)sender
{
    if([GameStateManager instance].currentCharacter) {
		[self performSegueWithIdentifier:@"SelectCharacterSegue" sender:sender];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    characters = [[NSMutableArray alloc]init];
    [self createOrOpenDB];
    
    sqlite3_stmt *statement;
    if(sqlite3_open([dbPathString UTF8String], &(characterDB))==SQLITE_OK)
    {
        [characters removeAllObjects];
        const char *query_sql = "SELECT * FROM CHARACTER";
        
        if(sqlite3_prepare_v2(characterDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *dateOfBirth = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *gender = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *age = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *family = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSString *education = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                NSString *economicStatus = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                NSString *occupation = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                NSString *portrait = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)];
                NSString *fullbody = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 10)];
                NSString *story1 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 11)];
                NSString *emigrate1 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 12)];
                NSString *story2 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 13)];
                NSString *emigrate2 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 14)];
                NSString *story3 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 15)];
                NSString *emigrate3 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 16)];
                NSString *story4 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 17)];
                NSString *emigrate4 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 18)];
                NSString *story5 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 19)];
                NSString *emigrate5 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 20)];
                
                Character *character = [[Character alloc]init];
                [character setName:name];
                [character setDateOfBirth:dateOfBirth];
                [character setGender:gender];
                [character setAge:[age intValue]];
                [character setFamily:family];
                [character setEducation:education];
                [character setEconomicStatus:economicStatus];
                [character setOccupation:occupation];
                [character setPortrait:[UIImage imageNamed:portrait]];
                [character setFullBodyImage:[UIImage imageNamed:fullbody]];
                [character setStory1:[UIImage imageNamed:story1]];
                [character setEmigration1:[UIImage imageNamed:emigrate1]];
                [character setStory2:[UIImage imageNamed:story2]];
                [character setEmigration2:[UIImage imageNamed:emigrate2]];
                [character setStory3:[UIImage imageNamed:story3]];
                [character setEmigration3:[UIImage imageNamed:emigrate3]];
                [character setStory4:[UIImage imageNamed:story4]];
                [character setEmigration4:[UIImage imageNamed:emigrate4]];
                [character setStory5:[UIImage imageNamed:story5]];
                [character setEmigration5:[UIImage imageNamed:emigrate5]];
                
                [characters addObject:character];
            }
        }
    }
	
    if(characters.count == 5)
    {
        [btnCharA setTitle:[[characters objectAtIndex:0] name] forState:UIControlStateNormal];
        [btnCharA setTitle:[[characters objectAtIndex:0] name] forState:UIControlStateSelected];
        [btnCharA setTitle:[[characters objectAtIndex:0] name] forState:UIControlStateHighlighted];
        
        [btnCharB setTitle:[[characters objectAtIndex:1] name] forState:UIControlStateNormal];
        [btnCharB setTitle:[[characters objectAtIndex:1] name] forState:UIControlStateSelected];
        [btnCharB setTitle:[[characters objectAtIndex:1] name] forState:UIControlStateHighlighted];
        
        [btnCharC setTitle:[[characters objectAtIndex:2] name] forState:UIControlStateNormal];
        [btnCharC setTitle:[[characters objectAtIndex:2] name] forState:UIControlStateSelected];
        [btnCharC setTitle:[[characters objectAtIndex:2] name] forState:UIControlStateHighlighted];
        
        [btnCharD setTitle:[[characters objectAtIndex:3] name] forState:UIControlStateNormal];
        [btnCharD setTitle:[[characters objectAtIndex:3] name] forState:UIControlStateSelected];
        [btnCharD setTitle:[[characters objectAtIndex:3] name] forState:UIControlStateHighlighted];
        
        [btnCharE setTitle:[[characters objectAtIndex:4] name] forState:UIControlStateNormal];
        [btnCharE setTitle:[[characters objectAtIndex:4] name] forState:UIControlStateSelected];
        [btnCharE setTitle:[[characters objectAtIndex:4] name] forState:UIControlStateHighlighted];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
