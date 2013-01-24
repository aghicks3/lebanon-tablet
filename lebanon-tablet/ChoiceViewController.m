//
//  ChoiceViewController.m
//  lebanon-tablet
//
//  Created by Jon Morgan on 1/23/13.
//  Copyright (c) 2013 SeriousGamesLebanon. All rights reserved.
//

#import "ChoiceViewController.h"

@interface ChoiceViewController ()

@end

@implementation ChoiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//called when the user presses the "stay" button
-(IBAction)stayButtonTouched:(id)sender {
	UIButton *sendingButton = (UIButton *)sender;
	NSLog(@"%@", [sendingButton titleForState:UIControlStateNormal]);
	
	//update the game state
	
	//perform the appropriate segue based on the game state
	// TODO: this should not neccessarily perform this segue
	[self performSegueWithIdentifier:@"NextStoryPointSegue" sender:sender];
}

//called when the user presses the "emigrate" button
-(IBAction)leaveButtonTouched:(id)sender {
	UIButton *sendingButton = (UIButton *)sender;
	NSLog(@"%@", [sendingButton titleForState:UIControlStateNormal]);
	
	//update the game state
	
	//perform the appropriate segue based on the game state
	// TODO: this should not neccessarily perform this segue
	[self performSegueWithIdentifier:@"ConclusionSeque" sender:sender];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
