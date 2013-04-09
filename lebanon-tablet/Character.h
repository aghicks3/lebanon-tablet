//
//  Character.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/30/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryPoint.h"


@interface Character : NSObject

@property (readwrite) int idNum;
@property (nonatomic, retain) NSString	*name;
@property (readwrite) int age;
@property (nonatomic, retain) NSString	*gender;
@property (nonatomic, retain) NSString	*dateOfBirth;
@property (nonatomic, retain) NSString	*education;
@property (nonatomic, retain) NSString	*family;
@property (nonatomic, retain) NSString	*occupation;
@property (nonatomic, retain) NSString	*economicStatus;
@property (nonatomic, retain) UIImage	*portrait;
@property (nonatomic, retain) UIImage	*fullBodyImage;
@property (nonatomic, retain) StoryPoint *story;
/*@property (nonatomic, retain) UIImage   *story1;
@property (nonatomic, retain) UIImage   *emigration1;
@property (nonatomic, retain) UIImage   *story2;
@property (nonatomic, retain) UIImage   *emigration2;
@property (nonatomic, retain) UIImage   *story3;
@property (nonatomic, retain) UIImage   *emigration3;
@property (nonatomic, retain) UIImage   *story4;
@property (nonatomic, retain) UIImage   *emigration4;
@property (nonatomic, retain) UIImage   *story5;
@property (nonatomic, retain) UIImage   *emigration5;*/
@end
