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
#import "StoryPoint.h"

#define TIME_BEFORE_RESET 150

@interface CharacterSelectionViewController ()
{
    NSMutableArray *characters, *stories;
    sqlite3 *characterDB, *storyDB;
    NSString *dbPathString, *dbdetailsString; //sets two different NSStrings to avoid confusion. One for the characterDB and another for the storyDB
}
@end

@implementation CharacterSelectionViewController

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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CHARACTER (id INTEGER PRIMARY KEY, name TEXT, dateOfBirth TEXT, gender TEXT, age NUMERIC, family TEXT, education TEXT, economicStatus TEXT, occupation TEXT, portrait TEXT, fullbody TEXT";
            sqlite3_exec(characterDB, sql_stmt, NULL, NULL, &error);
            sqlite3_close(characterDB);
        }
    }
}

- (void)createOrOpenDBdetails //Opens the database of Details of each character
{
    //dbPathString = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Journey"];
    dbdetailsString = [[NSBundle mainBundle] pathForResource:@"Journey" ofType:@"sqlite"];
    
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
    
    if(![fileManager fileExistsAtPath:dbdetailsString])
    {
        const char *dbdetails = [dbdetailsString UTF8String];
        
        //create db here
        if(sqlite3_open(dbdetails, &storyDB)== SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CHARACTER (nCPop NUMERIC, hammanaPop NUMERIC, year NUMERIC, id INTEGER PRIMARY KEY, owner NUMERIC, image TEXT, type TEXT, parent NUMERIC";
            sqlite3_exec(storyDB, sql_stmt, NULL, NULL, &error);
            sqlite3_close(storyDB);
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
    selectButton = (UIButton *)sender;
    
    for(int i = 0; i < characters.count; i++) {
        Character *current = [characters objectAtIndex:i];
        if([current.name isEqualToString:characterName]) {
            character = [characters objectAtIndex:i];
            break;
        }
        
    }
	// TODO: get full character info from a plist or SQLite
    if(!character.name) {
		character.name = characterName;
    }
    [GameStateManager instance].currentCharacter = character;
    
    //calls the label fade transition
    [self performSelector:@selector(transition) withObject:(nil)];
    
    
    //Calls the button move function.
    if(_chooseLabel.alpha > 0.0)
    {
        [self moveButton:[NSNumber numberWithInt:0.0]];
    }
    else
    {
        [self moveButtonBack:[NSNumber numberWithInt:0.0]]; //original function
        [self inverseTransition];
    }
    
    //calls the function that fetches all the details of the character button that was touched
    [self loadDetails];

}

-(IBAction)backButton:(id)sender //if back button is pressed in the details part, fades the details out, and shows again the character selection.
{
    [self moveButtonBack:[NSNumber numberWithInt:0.0]]; //original function
    [self inverseTransition];
}
-(IBAction)continueButton:(id)sender
{
    [self performSegueWithIdentifier:@"Story" sender:sender];
    
}

-(void) activate
{
    _btnCharA.enabled = YES;
    _btnCharB.enabled = YES;
    _btnCharC.enabled = YES;
    _btnCharD.enabled = YES;
    _continueButton.enabled = YES;
    _backButton.enabled = YES;
}

-(void) deactivate
{
    _btnCharA.enabled = NO;
    _btnCharB.enabled = NO;
    _btnCharC.enabled = NO;
    _btnCharD.enabled = NO;
    _continueButton.enabled = NO;
    _backButton.enabled = NO;
}
- (void) moveButton :(NSNumber *)_counter
{
    double counter = [_counter intValue];
    CGRect locBut = selectButton.frame;
    if(counter == 0)
    {
        startLoc = locBut.origin.x;
    }
    int frame = 25;
    
    if (locBut.origin.x != 752)
    {
        locBut.origin.x = locBut.origin.x + (752 - locBut.origin.x) * (counter/frame);
    }
    selectButton.frame = locBut;
    
    if (counter<frame) {
        counter++;
        [self performSelector:@selector(moveButton:) withObject:[NSNumber numberWithInt:counter] afterDelay:.02];
    }
    
    [self performSelector:@selector(deactivate) withObject:nil];

    if(locBut.origin.x == 752)
    {
        [self performSelector:@selector(activate) withObject:nil afterDelay: 0.15];
    }
}

- (void) moveButtonBack :(NSNumber *)_counter
{
    double counter = [_counter intValue];
    CGRect locBut = selectButton.frame;
    //float startLoc = locBut.origin.x;
    int frame = 17;
    
    if (locBut.origin.x != startLoc)
    {
        locBut.origin.x = 752 - (counter/frame) * (752 - startLoc);
    }
    selectButton.frame = locBut;
    
    if (counter<frame) {
        counter++;
        [self performSelector:@selector(moveButtonBack:) withObject:[NSNumber numberWithInt:counter] afterDelay:.02];
    }

    [self performSelector:@selector(deactivate) withObject:nil];
    
    if(locBut.origin.x == startLoc)
    {
        [self performSelector:@selector(activate) withObject:nil afterDelay: 0.15];
    }
}

-(void) transition
{
    CGRect BTN1 = _btnCharA.frame;
    CGRect BTN2 = _btnCharB.frame;
    CGRect BTN3 = _btnCharC.frame;
    CGRect BTN4 = _btnCharD.frame;
    CGRect btnSelect = selectButton.frame;
    
    _lblAge.alpha += 0.1;
    _lblDoB.alpha += 0.1;
    _lblEcon.alpha += 0.1;
    _lblEducation.alpha += 0.1;
    _lblGender.alpha += 0.1;
    _lblName.alpha += 0.1;
    _lblOcc.alpha += 0.1;
    _tvFamily.alpha += 0.1;
    _profileTitle.alpha += 0.1;;
    _nameTitle.alpha += 0.1;
    _ageTitle.alpha += 0.1;
    _dobTitle.alpha += 0.1;
    _genderTitle.alpha += 0.1;
    _educationTitle.alpha += 0.1;
    _econTitle.alpha += 0.1;
    _familyTitle.alpha += 0.1;
    _occTitle.alpha += 0.1;
    _chooseLabel.alpha -= 0.1;
    _backButton.alpha += 0.1;
    _continueButton.alpha += 0.1;
    _portraitImage.alpha += 0.1;
    
    if(btnSelect.origin.x != BTN1.origin.x)
    {
        _btnCharA.alpha = 0.0;
    }
    if (btnSelect.origin.x != BTN2.origin.x)
    {
        _btnCharB.alpha = 0.0;
    }
    if (btnSelect.origin.x != BTN3.origin.x)
    {
        _btnCharC.alpha = 0.0;
    }
    if (btnSelect.origin.x != BTN4.origin.x)
    {
        _btnCharD.alpha = 0.0;
    }
    
    if(_lblAge.alpha < 1.0) {
		[self performSelector:@selector(transition) withObject:nil afterDelay:0.02];
	}
}

-(void) inverseTransition
{
    _lblAge.alpha -= 0.1;
    _lblDoB.alpha -= 0.1;
    _lblEcon.alpha -= 0.1;
    _lblEducation.alpha -= 0.1;
    _lblGender.alpha -= 0.1;
    _lblName.alpha -= 0.1;
    _lblOcc.alpha -= 0.1;
    _tvFamily.alpha -= 0.1;
    _profileTitle.alpha -= 0.1;;
    _nameTitle.alpha -= 0.1;
    _ageTitle.alpha -= 0.1;
    _dobTitle.alpha -= 0.1;
    _genderTitle.alpha -= 0.1;
    _educationTitle.alpha -= 0.1;
    _econTitle.alpha -= 0.1;
    _familyTitle.alpha -= 0.1;
    _occTitle.alpha -= 0.1;
    if([GameStateManager instance].isJourney)
    {
        _btnCharA.alpha += 0.1;
        _btnCharD.alpha += 0.1;
    }
    _btnCharB.alpha += 0.1;
    _btnCharC.alpha += 0.1;
    _chooseLabel.alpha += 0.1;
    _backButton.alpha -= 0.1;
    _continueButton.alpha -= 0.1;
    _portraitImage.alpha -= 0.1;

    if(_lblAge.alpha > 0.0) {
		[self performSelector:@selector(inverseTransition) withObject:nil afterDelay:0.02];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

	_chooseLabel.font = [UIFont fontWithName:@"Garamond" size:60.0f];\
	
    characters = [[NSMutableArray alloc]init];

    //when the view loads, fetches the data of both databases. Avoids confusion in the program. It calls everytime it loads the view.
    [self createOrOpenDB];
    [self createOrOpenDBdetails];
    
    //calls the timer function
    [self performSelector:@selector(restart:) withObject:nil afterDelay:TIME_BEFORE_RESET];
    
    //Sets the details label and other stuff's alpha to 0. Makes them invisible when the view loads.
    _lblAge.alpha = 0.0;
    _lblDoB.alpha = 0.0;
    _lblEcon.alpha = 0.0;
    _lblEducation.alpha = 0.0;
    _lblGender.alpha = 0.0;
    _lblName.alpha = 0.0;
    _lblOcc.alpha = 0.0;
    _tvFamily.alpha = 0.0;
    _profileTitle.alpha = 0.0;
    _nameTitle.alpha = 0.0;
    _ageTitle.alpha = 0.0;
    _dobTitle.alpha = 0.0;
    _genderTitle.alpha = 0.0;
    _educationTitle.alpha = 0.0;
    _econTitle.alpha = 0.0;
    _familyTitle.alpha = 0.0;
    _occTitle.alpha = 0.0;
    _backButton.alpha = 0.0;
    _continueButton.alpha = 0.0;
    _portraitImage.alpha = 0.0;
    
    sqlite3_stmt *statement;
    
    if(sqlite3_open([dbPathString UTF8String], &(characterDB))==SQLITE_OK)
    {
        [characters removeAllObjects];
        const char *query_sql = "SELECT * FROM CHARACTER";
        
        if(sqlite3_prepare_v2(characterDB, query_sql, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *idNum = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
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
                /*NSString *story1 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 11)];
                NSString *emigrate1 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 12)];
                NSString *story2 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 13)];
                NSString *emigrate2 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 14)];
                NSString *story3 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 15)];
                NSString *emigrate3 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 16)];
                NSString *story4 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 17)];
                NSString *emigrate4 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 18)];
                NSString *story5 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 19)];
                NSString *emigrate5 = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 20)];*/
                
                Character *character = [[Character alloc]init];
                [character setIdNum:[idNum intValue]];
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
                /*[character setStory1:[UIImage imageNamed:story1]];
                [character setEmigration1:[UIImage imageNamed:emigrate1]];
                [character setStory2:[UIImage imageNamed:story2]];
                [character setEmigration2:[UIImage imageNamed:emigrate2]];
                [character setStory3:[UIImage imageNamed:story3]];
                [character setEmigration3:[UIImage imageNamed:emigrate3]];
                [character setStory4:[UIImage imageNamed:story4]];
                [character setEmigration4:[UIImage imageNamed:emigrate4]];
                [character setStory5:[UIImage imageNamed:story5]];
                [character setEmigration5:[UIImage imageNamed:emigrate5]];*/
                
                [characters addObject:character];
                
            }
        }
        
    }
    	
    if(characters.count == 4)
    {
        [GameStateManager instance].isJourney = true;
        
        [_btnCharA setTitle:[[characters objectAtIndex:0] name] forState:UIControlStateNormal];
        [_btnCharA setTitle:[[characters objectAtIndex:0] name] forState:UIControlStateSelected];
        [_btnCharA setTitle:[[characters objectAtIndex:0] name] forState:UIControlStateHighlighted];
        //[_btnCharA setImage:[[characters objectAtIndex:0] fullBodyImage] forState:UIControlStateNormal];
        [_btnCharA setImage:[[characters objectAtIndex:0] fullBodyImage] forState:UIControlStateSelected];
        [_btnCharA setImage:[[characters objectAtIndex:0] fullBodyImage] forState:UIControlStateHighlighted];
        [_btnCharA setImage:[[characters objectAtIndex:0] fullBodyImage] forState:UIControlStateDisabled];
        
        [_btnCharB setTitle:[[characters objectAtIndex:1] name] forState:UIControlStateNormal];
        [_btnCharB setTitle:[[characters objectAtIndex:1] name] forState:UIControlStateSelected];
        [_btnCharB setTitle:[[characters objectAtIndex:1] name] forState:UIControlStateHighlighted];
        //[_btnCharB setImage:[[characters objectAtIndex:1] fullBodyImage] forState:UIControlStateNormal];
        [_btnCharB setImage:[[characters objectAtIndex:1] fullBodyImage] forState:UIControlStateSelected];
        [_btnCharB setImage:[[characters objectAtIndex:1] fullBodyImage] forState:UIControlStateHighlighted];
        [_btnCharB setImage:[[characters objectAtIndex:1] fullBodyImage] forState:UIControlStateDisabled];
        
        [_btnCharC setTitle:[[characters objectAtIndex:2] name] forState:UIControlStateNormal];
        [_btnCharC setTitle:[[characters objectAtIndex:2] name] forState:UIControlStateSelected];
        [_btnCharC setTitle:[[characters objectAtIndex:2] name] forState:UIControlStateHighlighted];
        //[_btnCharC setImage:[[characters objectAtIndex:2] fullBodyImage] forState:UIControlStateNormal];
        [_btnCharC setImage:[[characters objectAtIndex:2] fullBodyImage] forState:UIControlStateSelected];
        [_btnCharC setImage:[[characters objectAtIndex:2] fullBodyImage] forState:UIControlStateHighlighted];
        [_btnCharC setImage:[[characters objectAtIndex:2] fullBodyImage] forState:UIControlStateDisabled];
        
        [_btnCharD setTitle:[[characters objectAtIndex:3] name] forState:UIControlStateNormal];
        [_btnCharD setTitle:[[characters objectAtIndex:3] name] forState:UIControlStateSelected];
        [_btnCharD setTitle:[[characters objectAtIndex:3] name] forState:UIControlStateHighlighted];
        //[_btnCharD setImage:[[characters objectAtIndex:3] fullBodyImage] forState:UIControlStateNormal];
        [_btnCharD setImage:[[characters objectAtIndex:3] fullBodyImage] forState:UIControlStateSelected];
        [_btnCharD setImage:[[characters objectAtIndex:3] fullBodyImage] forState:UIControlStateHighlighted];
        [_btnCharD setImage:[[characters objectAtIndex:3] fullBodyImage] forState:UIControlStateDisabled];
		
		_btnCharA.titleLabel.font = [GameStateManager instance].buttonFont;
		_btnCharB.titleLabel.font = [GameStateManager instance].buttonFont;
		_btnCharC.titleLabel.font = [GameStateManager instance].buttonFont;
		_btnCharD.titleLabel.font = [GameStateManager instance].buttonFont;
        
    }
    else if(characters.count == 2)
    {
        [GameStateManager instance].isJourney = false;
        CGPoint pointC = _btnCharC.center;
        CGSize sizeC = {300, 530};
        CGRect rectC = {pointC, sizeC};
        
        CGPoint pointB = _btnCharB.center;
        CGSize sizeB = {300, 530};
        CGRect rectB ={pointB, sizeB};
        
        [_btnCharB setTitle:[[characters objectAtIndex:0] name] forState:UIControlStateNormal];
        [_btnCharB setTitle:[[characters objectAtIndex:0] name] forState:UIControlStateSelected];
        [_btnCharB setTitle:[[characters objectAtIndex:0] name] forState:UIControlStateHighlighted];
        [_btnCharB setBackgroundImage:[[characters objectAtIndex:0] fullBodyImage] forState:UIControlStateSelected];
        [_btnCharB setBackgroundImage:[[characters objectAtIndex:0] fullBodyImage] forState:UIControlStateHighlighted];
        [_btnCharB setBackgroundImage:[[characters objectAtIndex:0] fullBodyImage] forState:UIControlStateDisabled];
        [_btnCharB setBackgroundImage:[[characters objectAtIndex:0] fullBodyImage] forState:UIControlStateNormal];
        [_btnCharB setBounds:rectB];
        
        [_btnCharC setTitle:[[characters objectAtIndex:1] name] forState:UIControlStateNormal];
        [_btnCharC setTitle:[[characters objectAtIndex:1] name] forState:UIControlStateSelected];
        [_btnCharC setTitle:[[characters objectAtIndex:1] name] forState:UIControlStateHighlighted];
        [_btnCharC setBackgroundImage:[[characters objectAtIndex:1] fullBodyImage] forState:UIControlStateSelected];
        [_btnCharC setBackgroundImage:[[characters objectAtIndex:1] fullBodyImage] forState:UIControlStateHighlighted];
        [_btnCharC setBackgroundImage:[[characters objectAtIndex:1] fullBodyImage] forState:UIControlStateDisabled];
        [_btnCharC setBackgroundImage:[[characters objectAtIndex:1] fullBodyImage] forState:UIControlStateNormal];
        [_btnCharC setBounds:rectC];
        
		_btnCharB.titleLabel.font = [GameStateManager instance].buttonFont;
		_btnCharC.titleLabel.font = [GameStateManager instance].buttonFont;
        
        _btnCharA.alpha = 0.0;
        _btnCharD.alpha = 0.0;
    }

}

//if a character button is touched, loads the corrsponding details.
-(void) loadDetails 
{
    Character *selectedCharacter = [[GameStateManager instance] currentCharacter];
    stories = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement;
    if(sqlite3_open([dbdetailsString UTF8String], &(storyDB))==SQLITE_OK)
    {
        [stories removeAllObjects];
        /*const char *query_sql = [NSString  stringwithFormat:@"select * from story where owner = %i", selectedCharacter.idNum];*/
        int idnum = selectedCharacter.idNum;
        char *query = calloc(35, sizeof(char));
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
        
        free(query);
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
    
	
	self.backButton.titleLabel.font = [GameStateManager instance].buttonFont;
	self.continueButton.titleLabel.font = [GameStateManager instance].buttonFont;
	
    self.portraitImage.image = selectedCharacter.portrait;
    
    //Loop through the story points and construct the correct chain
    StoryPoint *storyPointStay = [[StoryPoint alloc] init];
    StoryPoint *nextStoryPoint = nil;
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
    

}

-(void)restart:(id)sender {
	[self performSegueWithIdentifier:@"RESET" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

