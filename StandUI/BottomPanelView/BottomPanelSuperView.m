//
//  BottomPanelSuperView.m
//  StandUI
//
//  Created by PhilipsIT5 on 8/19/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "BottomPanelSuperView.h"
#import "SimulationConstants.h"
#import "StandUIViewController.h"
#import "../Constants.h"
// Constants


#define ROTATIONINCREMENT       1
#define ROTATIONDECREMENT       2
#define ANGULATIONINCREMENT     3
#define ANGULATIONDECREMENT     4
#define LONGITUDINALINCREMENT   5
#define LONGITUDINALDECREMENT   6

#define HEIGHTINCREMENT         7
#define HEIGHTDECREMENT         8


@interface BottomPanelSuperView ()
@property (atomic,retain)NSDate *touchTime;
@property (nonatomic,assign) NSString *degreeSymbol;
@property (nonatomic,assign) BOOL touchDown ;

@end


@implementation BottomPanelSuperView

@synthesize otherExamButton;
@synthesize xRayState;
@synthesize currentRotationValue;
@synthesize currentAngulationValue;
@synthesize currentLongitudinalValue;
@synthesize currentHeightValue;

@synthesize rotationLabel;
@synthesize angulationLabel;
@synthesize longitudinalLabel;
@synthesize heightLabel;
@synthesize simulationView;
@synthesize simulationSuperView;
@synthesize timer;
@synthesize touchTime;
@synthesize degreeSymbol;
@synthesize cARMPositionTimer;
@synthesize currentActiveButton;
@synthesize touchDown;

@synthesize fluoroXraySwitch;
@synthesize exposureXraySwitch;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/*
- (void)drawRect:(CGRect)rect
{

}
*/

-(void)initBottomPanelSuperView
{
    // Skeleton button
    otherExamButton.layer.cornerRadius = 2;
    otherExamButton.layer.borderWidth = 0.5;
    otherExamButton.layer.borderColor = [UIColor blackColor].CGColor;
    otherExamButton.backgroundColor = [UIColor colorWithRed:57.0/255.0 green:55.0/255.0 blue:52.0/255.0 alpha:1.0];
    [ otherExamButton setTintColor:[UIColor whiteColor]];
    
    [self Initialise];
    simulationView.hidden=YES;
    currentActiveButton = 100;
    currentCArmPos = [ StandUICARMPosition shareCARMManager];
}

-(void)Initialise
{
    xRayState = NO;
    currentRotationValue =  0;
    currentAngulationValue =  0;
    currentLongitudinalValue = 10.0;
    currentHeightValue = 10.0;
    degreeSymbol = @"\u00B0";
    rotationLabel.text = [NSString stringWithFormat: @"%d%@", currentRotationValue,degreeSymbol];
    angulationLabel.text = [NSString stringWithFormat: @"%d%@", currentAngulationValue,degreeSymbol];
    longitudinalLabel.text = [NSString stringWithFormat: @"%.01f", currentLongitudinalValue];
    heightLabel.text = [NSString stringWithFormat: @"%.01f", currentHeightValue];
    
    
    [self setupTouchButton:self.orientationRotationIncrement :ROTATIONINCREMENT];
    [self setupTouchButton:self.orientationRotationDecrement :ROTATIONDECREMENT];
    
    [self setupTouchButton:self.orientationAngulationIncrement :ANGULATIONINCREMENT];
    [self setupTouchButton:self.AngulationDecrement :ANGULATIONDECREMENT];
   
    [self setupTouchButton:self.orientationLongitudinalncrement :LONGITUDINALINCREMENT];
    [self setupTouchButton:self.orientationLongitudinalDecrement :LONGITUDINALDECREMENT];
    
    [self setupTouchButton:self.orientatioHeightIncrement :HEIGHTINCREMENT];
    [self setupTouchButton:self.orientatioHeightDecrement :HEIGHTDECREMENT];
    touchDown = NO;
}

-(void)setupTouchButton:(UIButton *)button :(int)tagid
{
    [button addTarget:self action:@selector(handleTouchDownEvent:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(handleTouchReleaseEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tagid;
}

-(void)handleTouchDownEvent:(UIButton *)sender
{
    simulationView.hidden=NO;   
    touchTime =  [NSDate date];
    currentActiveButton = sender.tag;
    cARMPositionTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(simulateCARM:) userInfo:Nil repeats:YES];
}

-(void)handleTouchReleaseEvent:(UIButton *)sender
{
    touchDown=NO;
    if ([cARMPositionTimer isValid]) {
        [cARMPositionTimer invalidate];
        cARMPositionTimer = nil;
    }
    currentActiveButton = 100;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint nowPoint  = [[touches anyObject] locationInView: self];
    
    for(UIView *subview in [self subviews])
    {
        if([subview isKindOfClass:[UIView class]] && CGRectContainsPoint(subview.frame, nowPoint))
        {
            if(subview == simulationSuperView )
            {
                simulationView.hidden=NO;
                touchTime =  [NSDate date];
                [self StartTimer];
            }
        }
    }
}

-(void)StartTimer
{
    if( !timer )
    {
        timer= [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                target: self
                                              selector:@selector(hideSimulationView:)
                                              userInfo: nil repeats:YES];
    }
}

-(void)hideSimulationView:(NSTimer *)Localtimer
{
    if(!([fluoroXraySwitch isOn] || [exposureXraySwitch isOn]))
    {
        // calculate the time difference
        NSTimeInterval timediff = [[NSDate date] timeIntervalSinceDate:touchTime];
        if(timediff >= 5 )
        {
            if ([timer isValid]) {
                [timer invalidate];
            }
            timer = nil;
            simulationView.hidden=YES;
        }
    }
}


// Orientation Rotation
- (IBAction)orientationRotationIncrementBtnCLicked:(id)sender
{
    if (touchDown)
    {
    currentRotationValue = ((currentRotationValue + ROTATIONINCREMENTALSTEP) >=ORIENTATIONROTATIONMAX)? ORIENTATIONROTATIONMAX :currentRotationValue+ROTATIONINCREMENTALSTEP;
    }
    else
    {
        currentRotationValue = (currentRotationValue >=ORIENTATIONROTATIONMAX)? ORIENTATIONROTATIONMAX :currentRotationValue+1;
    }
    NSString *str = [NSString stringWithFormat: @"%d%@", currentRotationValue,degreeSymbol];
    rotationLabel.text = str;
    [currentCArmPos setValue:str forKey:@"RotationPos"];
}

- (IBAction)orientationRotationDecrementBtnCLicked:(id)sender
{
   if(touchDown)
   {
    currentRotationValue = ((currentRotationValue-ROTATIONINCREMENTALSTEP) <=ORIENTATIONROTATIONMIN)? ORIENTATIONROTATIONMIN :currentRotationValue-ROTATIONINCREMENTALSTEP;
   }
    else
    {
        currentRotationValue = (currentRotationValue <=ORIENTATIONROTATIONMIN)? ORIENTATIONROTATIONMIN :currentRotationValue-1;
    }
    NSString *str = [NSString stringWithFormat: @"%d%@", currentRotationValue,degreeSymbol];
    rotationLabel.text = str;
    [currentCArmPos setValue:str forKey:@"RotationPos"];
}

// Orientation Angulation
- (IBAction)orientationAngulationIncrementBtnCLicked:(id)sender
{
    if(touchDown)
    {
        currentAngulationValue = ((currentAngulationValue+ANGULATIONINCREMENTALSTEP) >= ORIENTATIONANGULATIONMAX)? ORIENTATIONANGULATIONMAX:currentAngulationValue+ANGULATIONINCREMENTALSTEP;
    }
    else
    {
        currentAngulationValue = (currentAngulationValue >= ORIENTATIONANGULATIONMAX)? ORIENTATIONANGULATIONMAX:currentAngulationValue+1;
    }
    NSString *str = [NSString stringWithFormat: @"%d%@", currentAngulationValue,degreeSymbol];
    angulationLabel.text = str;
    [currentCArmPos setValue:str forKey:@"AngulationPos"];

}

- (IBAction)orientationAngulationDecrementBtnCLicked:(id)sender
{
    if(touchDown)
    {
    currentAngulationValue = ((currentAngulationValue-ANGULATIONINCREMENTALSTEP) <= ORIENTATIONANGULATIONMIN)? ORIENTATIONANGULATIONMIN:currentAngulationValue-ANGULATIONINCREMENTALSTEP;
    }
    else
    {
    currentAngulationValue = (currentAngulationValue <= ORIENTATIONANGULATIONMIN)? ORIENTATIONANGULATIONMIN:currentAngulationValue-1;
    }
    NSString *str =  [NSString stringWithFormat: @"%d%@", currentAngulationValue,degreeSymbol];
    angulationLabel.text = str;
    [currentCArmPos setValue:str forKey:@"AngulationPos"];
}


// Orientation Longitudinal
- (IBAction)orientationLongitudinalncrementBtnCLicked:(id)sender
{
    if(touchDown)
    {
    currentLongitudinalValue = ((currentLongitudinalValue+LONGITUDINALINCREMENTALSTEP) >= ORIENTATIONLONGITUDINALMAX)? ORIENTATIONLONGITUDINALMAX:currentLongitudinalValue+LONGITUDINALINCREMENTALSTEP;
    }
    else
    {
       currentLongitudinalValue = (currentLongitudinalValue >= ORIENTATIONLONGITUDINALMAX)? ORIENTATIONLONGITUDINALMAX:currentLongitudinalValue+1;
    }
    NSString *str = [NSString stringWithFormat: @"%.01f", currentLongitudinalValue];
    longitudinalLabel.text = str;
    [currentCArmPos setValue:str forKey:@"LongitudinalPos"];
}

- (IBAction)orientationLongitudinalDecrementBtnCLicked:(id)sender
{
    if(touchDown)
    {
    currentLongitudinalValue = ((currentLongitudinalValue-LONGITUDINALINCREMENTALSTEP) <= ORIENTATIONLONGITUDINALMIN)? ORIENTATIONLONGITUDINALMIN:currentLongitudinalValue-LONGITUDINALINCREMENTALSTEP;
    }
    else
    {
    currentLongitudinalValue = (currentLongitudinalValue <= ORIENTATIONLONGITUDINALMIN)? ORIENTATIONLONGITUDINALMIN:currentLongitudinalValue-1;
    }
    NSString *str = [NSString stringWithFormat: @"%.01f", currentLongitudinalValue];
    longitudinalLabel.text = str;
    [currentCArmPos setValue:str forKey:@"LongitudinalPos"];

}

// Orientaion Height
- (IBAction)orientatioHeightIncrementBtnCLicked:(id)sender
{
    if(touchDown)
    {
    currentHeightValue = ((currentHeightValue+HEIGHTINCREMENTALSTEP) >= ORIENTATIONHEIGHTMAX)? ORIENTATIONHEIGHTMAX:currentHeightValue+HEIGHTINCREMENTALSTEP;
    }
    else
    {
    currentHeightValue = (currentHeightValue >= ORIENTATIONHEIGHTMAX)? ORIENTATIONHEIGHTMAX:currentHeightValue+1;
    }
    NSString *str = [NSString stringWithFormat: @"%.01f", currentHeightValue];
    heightLabel.text = str;
    [currentCArmPos setValue:str forKey:@"HeightPos"];

}

- (IBAction)orientatioHeightDecrementBtnCLicked:(id)sender
{
    if(touchDown)
    {
    currentHeightValue = ((currentHeightValue-HEIGHTINCREMENTALSTEP) <= ORIENTATIONHEIGHTMIN)? ORIENTATIONHEIGHTMIN:currentHeightValue-HEIGHTINCREMENTALSTEP;
    }
    else
    {
    currentHeightValue = (currentHeightValue <= ORIENTATIONHEIGHTMIN)? ORIENTATIONHEIGHTMIN:currentHeightValue-1;
    }
    NSString *str = [NSString stringWithFormat: @"%.01f", currentHeightValue];
    heightLabel.text = str;
    [currentCArmPos setValue:str forKey:@"HeightPos"];

}

-(void)simulateCARM:(id)sender
{
    touchDown=YES;
    switch(currentActiveButton)
    {
        case ROTATIONINCREMENT:
            [self orientationRotationIncrementBtnCLicked:nil];
            break;
            
        case ROTATIONDECREMENT:
            [self orientationRotationDecrementBtnCLicked:nil];
            break;

        case ANGULATIONINCREMENT:
            [self orientationAngulationIncrementBtnCLicked:nil];
            break;
            
        case ANGULATIONDECREMENT:
            [self orientationAngulationDecrementBtnCLicked:nil];
            break;
            
        case LONGITUDINALINCREMENT:
            [self orientationLongitudinalncrementBtnCLicked:nil];
            break;
            
        case LONGITUDINALDECREMENT:
            [self orientationLongitudinalDecrementBtnCLicked:nil];
            break;
        case HEIGHTINCREMENT:
            [self orientatioHeightIncrementBtnCLicked:nil];
            break;
        case HEIGHTDECREMENT:
            [self orientatioHeightDecrementBtnCLicked:nil];
            break;
        default:
            touchDown=NO;
            break;
    }
}



@end
