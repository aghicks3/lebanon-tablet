//
//  GameOverViewController.h
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *endLabel;
@property (strong, nonatomic) IBOutlet UILabel *playAgainLabel;
@property (strong, nonatomic) IBOutlet UILabel *playAgainLabel2;
@property (strong, nonatomic) IBOutlet UILabel *playAgainLabel3;
- (IBAction)PlayAgainButton:(id)sender;

@end
