//
//  GameStateManager.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/30/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioPlayer.h>
@class StoryPoint, Character;

@interface GameStateManager : NSObject

+(GameStateManager *)instance;

@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) StoryPoint *currentStoryPoint;
@property (nonatomic, retain) Character *currentCharacter;
@property (nonatomic, assign) Boolean *isJourney; //True if JourneyDB is used, false if BelongingDB is used.
@property (nonatomic, assign) int * playerID; //Player ID for logging purposes
@property (nonatomic, retain) UIFont *buttonFont;

@end
