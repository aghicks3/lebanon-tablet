//
//  MainMenuViewController.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController {
	BOOL howToDisplayed;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UITapGestureRecognizer *tapRecognizer;

-(IBAction)handleTap:(id)sender;
@end
