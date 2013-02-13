//
//  Character.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/30/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Character : NSObject

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
@end
