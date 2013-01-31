//
//  Character.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/30/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum Gender {
	kMale = 1,
	kFemale = 2,
} Gender;

@interface Character : NSObject

@property (nonatomic, retain) NSString	*name;
@property (readwrite) int age;
@property (nonatomic, retain) NSString	*description;
@property (readwrite) Gender gender;
@property (nonatomic, retain) NSDate	*dateOfBirth;
@property (readwrite) BOOL literate;
@property (nonatomic, retain) NSString	*family;
@property (nonatomic, retain) NSString	*Occupation;
@property (nonatomic, retain) UIImage	*portrait;
@property (nonatomic, retain) UIImage	*fullBodyImage;
@end
