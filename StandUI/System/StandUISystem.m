//
//  StandUISystem.m
//  StandUI
//
//  Created by PhilipsIT5 on 11/4/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "StandUISystem.h"
#import <AVFoundation/AVFoundation.h>

@interface StandUISystem ()

@property(nonatomic)BOOL AutoRunCycleToggleBtn;

@end

@implementation StandUISystem
@synthesize testBuzzerButton;
@synthesize autoRunCycleButton;
@synthesize CloseButton;
@synthesize AutoRunCycleToggleBtn;
@synthesize systemMainView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  // Drawing code
}
*/

-(void)initSystemView
{
    self.backgroundColor=[[UIColor clearColor]colorWithAlphaComponent:0.0];
    UIColor *darkcolor =[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
    systemMainView.backgroundColor=[darkcolor colorWithAlphaComponent:1.0];
    testBuzzerButton.backgroundColor=[darkcolor colorWithAlphaComponent:1.0];
    autoRunCycleButton.backgroundColor=[darkcolor colorWithAlphaComponent:1.0];
    CloseButton.backgroundColor=[darkcolor colorWithAlphaComponent:1.0];
    AutoRunCycleToggleBtn =  FALSE;
    [self initialiseButtonStyle:testBuzzerButton];
    [self initialiseButtonStyle:autoRunCycleButton];
    [self initialiseButtonStyle:CloseButton];
}

-(void)initialiseButtonStyle:(UIButton*)button
{
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    UIColor *buttoncolor =[UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];

    button.backgroundColor =[buttoncolor colorWithAlphaComponent:1.0];
    [button setTintColor:[UIColor whiteColor]];
}

- (IBAction)AutoRunCycleButtonTapped:(id)sender {
    
    AutoRunCycleToggleBtn = !AutoRunCycleToggleBtn;
    if(AutoRunCycleToggleBtn)
    {
        autoRunCycleButton.layer.borderWidth = 1.0;
        autoRunCycleButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        [autoRunCycleButton setTitleColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    }
    else
    {
        autoRunCycleButton.layer.borderWidth = 0.5;
        autoRunCycleButton.layer.borderColor = [UIColor blackColor].CGColor;
        [autoRunCycleButton setTitleColor:[UIColor colorWithRed:255.0/256.0 green:255.0/256.0 blue:255.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    }
}

- (IBAction)TestBuzzerButtonTapped:(id)sender
{
    SystemSoundID myAlertSound;
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"Purr" ofType:@"aiff"];
    NSURL *url = [NSURL fileURLWithPath:soundFilePath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &myAlertSound);
    AudioServicesPlaySystemSound(myAlertSound);
}

- (IBAction)CloseButtonTapped:(id)sender {
    
    self.hidden =YES;
}

@end
