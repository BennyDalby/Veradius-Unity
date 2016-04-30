//
//  BottomPanelSuperView.h
//  StandUI
//
//  Created by PhilipsIT5 on 8/19/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StandUIViewController.h"
#import "StandUICARMPosition.h"


@interface BottomPanelSuperView : UIView
{
    StandUICARMPosition *currentCArmPos;
}


// Buttons Properties
@property(nonatomic) IBOutlet UIButton *otherExamButton;
@property(nonatomic) IBOutlet UISwitch *fluoroXraySwitch;
@property(nonatomic) IBOutlet UISwitch *exposureXraySwitch;
@property(nonatomic) IBOutlet UIButton *orientationRotationIncrement;
@property(nonatomic) IBOutlet UIButton *orientationRotationDecrement;
@property(nonatomic) IBOutlet UIButton *orientationAngulationIncrement;
@property(nonatomic) IBOutlet UIButton *orientationLongitudinalncrement;
@property(nonatomic) IBOutlet UIButton *orientationLongitudinalDecrement;
@property(nonatomic) IBOutlet UIButton *orientatioHeightIncrement;
@property(nonatomic) IBOutlet UIButton *orientatioHeightDecrement;

@property(nonatomic) IBOutlet UIButton *AngulationDecrement;

// lable Properties
@property(strong, nonatomic) IBOutlet UILabel *rotationLabel;
@property(strong, nonatomic) IBOutlet UILabel *angulationLabel;
@property(strong, nonatomic) IBOutlet UILabel *longitudinalLabel;
@property(strong, nonatomic) IBOutlet UILabel *heightLabel;

// Orientation Rotation
- (IBAction)orientationRotationIncrementBtnCLicked:(id)sender;
- (IBAction)orientationRotationDecrementBtnCLicked:(id)sender;

// Orientation Angulation
- (IBAction)orientationAngulationIncrementBtnCLicked:(id)sender;
- (IBAction)orientationAngulationDecrementBtnCLicked:(id)sender;


// Orientation Longitudinal
- (IBAction)orientationLongitudinalncrementBtnCLicked:(id)sender;
- (IBAction)orientationLongitudinalDecrementBtnCLicked:(id)sender;

// Orientaion Height
- (IBAction)orientatioHeightIncrementBtnCLicked:(id)sender;
- (IBAction)orientatioHeightDecrementBtnCLicked:(id)sender;


//Business logic variables
@property (nonatomic, assign) BOOL xRayState;
@property (nonatomic, assign) int  currentRotationValue;
@property (nonatomic, assign) int  currentAngulationValue;
@property (nonatomic, assign) float  currentLongitudinalValue;
@property (nonatomic, assign) float  currentHeightValue;


@property (strong, nonatomic) IBOutlet UIView *simulationView;
@property (strong, nonatomic) IBOutlet UIView *simulationSuperView;

@property (strong, atomic)NSTimer *timer;
@property (strong, atomic)NSTimer *cARMPositionTimer;


-(void)hideSimulationView:(NSTimer *)timer;
-(void)initBottomPanelSuperView;

@property (nonatomic,assign)int currentActiveButton;



@end
