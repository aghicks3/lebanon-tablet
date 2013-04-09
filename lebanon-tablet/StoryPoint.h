//
//  StoryPoint.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryPoint : NSObject

@property (readwrite)		  int			idNum;
@property (readwrite)		  int			year;
@property (readwrite)		  int			nCPop;
@property (readwrite)		  int			hammanaPop;
@property (readwrite)		  int			owner;
@property (nonatomic, retain) NSString		*storyType;
@property (readwrite)		  int			parent;
@property (nonatomic, retain) UIImage		*illustration;
@property (nonatomic, retain) StoryPoint	*nextStoryPoint;
@property (nonatomic, retain) StoryPoint	*emigrationStoryPoint;

@end
