//
//  GameStateManager.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/30/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "GameStateManager.h"

@implementation GameStateManager

static GameStateManager *_gameStateManager = nil;

//gets the global singleton instance of the GameStateManager
+(GameStateManager *)instance {
	if(!_gameStateManager) {
		_gameStateManager = [[self alloc] init];
	}
	
	return _gameStateManager;
}

@end
