//
//  GameStateManager.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/30/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoryPoint, Character;

@interface GameStateManager : NSObject

+(GameStateManager *)instance;

@property (nonatomic, retain) StoryPoint *currentStoryPoint;
@property (nonatomic, retain) Character *currentCharacter;

@end
