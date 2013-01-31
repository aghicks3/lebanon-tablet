//
//  StoryPoint.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryPoint : NSObject

@property (nonatomic, retain) NSString		*title;
@property (readwrite)		  int			year;
@property (nonatomic, retain) NSString		*description;
@property (nonatomic, retain) UIImage		*illustration;
@property (nonatomic, retain) StoryPoint	*nextStoryPoint;
@property (nonatomic, retain) UIImage		*emigrationStoryPoint;

@end
