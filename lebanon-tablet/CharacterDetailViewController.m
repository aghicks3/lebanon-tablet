//
//  CharacterDetailViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "CharacterDetailViewController.h"
#import "GameStateManager.h"
#import "Character.h"
#import "StoryPoint.h"

@interface CharacterDetailViewController ()
{
    NSMutableArray *stories;
    sqlite3 *storyDB;
    NSString *dbPathString;
}

@end

@implementation CharacterDetailViewController

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
        if(sqlite3_open(dbPath, &storyDB)== SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CHARACTER (nCPop NUMERIC, hammanaPop NUMERIC, year NUMERIC, id INTEGER PRIMARY KEY, owner NUMERIC, image TEXT, type TEXT, parent NUMERIC";
            sqlite3_exec(storyDB, sql_stmt, NULL, NULL, &error);
            sqlite3_close(storyDB);
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //get the selected character from the GameStateManager
	Character *selectedCharacter = [[GameStateManager instance] currentCharacter];
    
    stories = [[NSMutableArray alloc]init];
    [self createOrOpenDB];
    
    sqlite3_stmt *statement;
    if(sqlite3_open([dbPathString UTF8String], &(storyDB))==SQLITE_OK)
    {
        [stories removeAllObjects];
        /*const char *query_sql = [NSString  stringwithFormat:@"select * from story where owner = %i", selectedCharacter.idNum];*/
        int idnum = selectedCharacter.idNum;
        char *query = malloc(35 * sizeof(char));
        strcpy(query, "select * from story where owner = ");
        NSString* numString = [NSString stringWithFormat:@"%i", idnum];
        const char *num = [numString UTF8String];
        const char *query_sql = strcat(query, num);
        
        if(sqlite3_prepare_v2(storyDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *nCPop = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *hammanaPop = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *year = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *idNum = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *owner = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *image = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSString *type = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                NSString *parent = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                
                
                
                StoryPoint *story = [[StoryPoint alloc]init];
                [story setNCPop:[nCPop intValue]];
                [story setHammanaPop:[hammanaPop intValue]];
                [story setYear:[year intValue]];
                [story setIdNum:[idNum intValue]];
                [story setOwner:[owner intValue]];
                [story setIllustration:[UIImage imageNamed:image]];
                [story setStoryType:type];
                [story setParent:[parent intValue]];
                
                
                [stories addObject:story];
            }
        }
        
    }
    
	
	self.lblName.text = selectedCharacter.name;
    self.lblAge.text = [NSString stringWithFormat:@"%d",selectedCharacter.age];
    self.lblDoB.text = selectedCharacter.dateOfBirth;
    self.lblGender.text = selectedCharacter.gender;
    self.lblEducation.text = selectedCharacter.education;
    self.lblEcon.text = selectedCharacter.economicStatus;
    self.lblOcc.text = selectedCharacter.occupation;
    self.tvFamily.text = selectedCharacter.family;

	UIFont *labelFont = [UIFont fontWithName:@"Garamond" size:20.0f];
//	UIFont *buttonFont = [UIFont fontWithName:@"Garamond Bold" size:20.0f];
	
	self.lblName.font = labelFont;
    self.lblAge.font = labelFont;
    self.lblDoB.font = labelFont;
    self.lblGender.font = labelFont;
    self.lblEducation.font = labelFont;
    self.lblEcon.font = labelFont;
    self.lblOcc.font = labelFont;
    self.tvFamily.font = labelFont;
	
	self.profileTitle.font = [UIFont fontWithName:@"Garamond" size:34.0f];
    self.nameTitle.font = labelFont;
    self.ageTitle.font = labelFont;
    self.dobTitle.font = labelFont;
    self.genderTitle.font = labelFont;
    self.educationTitle.font = labelFont;
    self.econTitle.font = labelFont;
    self.occTitle.font = labelFont;
    self.familyTitle.font = labelFont;
	
	self.prevButton.titleLabel.font = [GameStateManager instance].buttonFont;
	self.nextButton.titleLabel.font = [GameStateManager instance].buttonFont;
	
    self.portraitImage.image = selectedCharacter.portrait;
    self.fullBodyImage.image = selectedCharacter.fullBodyImage;
    
    //Loop through the story points and construct the correct chain
    StoryPoint *storyPointStay = [[StoryPoint alloc] init];
    StoryPoint *nextStoryPoint = [[StoryPoint alloc] init];
    int storiesSize = [stories count];/*/(sizeof stories[0])*/;
    for(int i = 0; i < storiesSize; i++)
    {
        if([[stories objectAtIndex:i ]parent] == 0)
        {
            storyPointStay = stories[i];
            break;
        }
    }
    [GameStateManager instance].currentStoryPoint = storyPointStay;
    while(storyPointStay !=NULL)
    {
        //set the child stories
        nextStoryPoint = NULL;
        for(int i = 0; i < storiesSize; i++)
        {
            if([[stories objectAtIndex:i ]parent] == storyPointStay.idNum && [[[stories objectAtIndex:i ]storyType] isEqualToString:@"emigrate"])
            {
                storyPointStay.emigrationStoryPoint = [stories objectAtIndex:i ];
                
            }
            if([[stories objectAtIndex:i ]parent] == storyPointStay.idNum && [[[stories objectAtIndex:i ]storyType] isEqualToString:@"stay"])
            {
                if(nextStoryPoint == NULL)
                {
                    nextStoryPoint = [stories objectAtIndex:i ];
                }
                
            }
        }
        storyPointStay.nextStoryPoint = nextStoryPoint;
        storyPointStay = nextStoryPoint;
    }
    storyPointStay = [GameStateManager instance].currentStoryPoint;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
