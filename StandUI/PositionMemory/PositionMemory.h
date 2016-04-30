//
//  PositionMemory.h
//  StandUI
//
//  Created by PhilipsIT5 on 8/21/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StandUICARMPosition.h"


@interface PositionMemory : UIView
{
    StandUICARMPosition *CArmPos;
}

// C-ARM indicators view
@property(nonatomic) IBOutlet UIView *cARMControlsView;

// A Stores Properties & IBActions
@property(nonatomic) IBOutlet UIView *aStoreView;
@property(nonatomic) IBOutlet UIButton *aStoreClearBtn;
@property(strong, nonatomic) IBOutlet UILabel *aStoreLabel;
@property(nonatomic) IBOutlet UIImageView *aStoreImageView;

// C- ARM Postion labels for Store A
@property(nonatomic) IBOutlet UIView *aStoreExpandableView;
@property(strong, nonatomic) IBOutlet UILabel *aRotationLabel;
@property(strong, nonatomic) IBOutlet UILabel *aAngulationLabel;
@property(strong, nonatomic) IBOutlet UILabel *aLongitudinalLabel;
@property(strong, nonatomic) IBOutlet UILabel *aHeightLabel;


// IB Actions
- (IBAction)aStoreCleaerBtnClicked:(id)sender;


///////////////////////////////

// B Store Outlets
@property(nonatomic) IBOutlet UIView *bStoreView;
@property(nonatomic) IBOutlet UIButton *bStoreClearBtn;
@property(strong, nonatomic) IBOutlet UILabel *bStoreLabel;
@property(nonatomic) IBOutlet UIImageView *bStoreImageView;

// C-ARM Postion labels for Store B
@property(nonatomic) IBOutlet UIView *bStoreExpandableView;
@property(strong, nonatomic) IBOutlet UILabel *bRotationLabel;
@property(strong, nonatomic) IBOutlet UILabel *bAngulationLabel;
@property(strong, nonatomic) IBOutlet UILabel *bLongitudinalLabel;
@property(strong, nonatomic) IBOutlet UILabel *bHeightLabel;

// IB Actions
- (IBAction)bStoreCleaerBtnClicked:(id)sender;


//////////////////////////////////////
// C Store Outlets
@property(nonatomic) IBOutlet UIView *cStoreView;
@property(nonatomic) IBOutlet UIButton *cStoreClearBtn;
@property(strong, nonatomic) IBOutlet UILabel *cStoreLabel;
@property(nonatomic) IBOutlet UIImageView *cStoreImageView;

// C-ARM Postion labels for Store C
@property(nonatomic) IBOutlet UIView *cStoreExpandableView;
@property(strong, nonatomic) IBOutlet UILabel *cRotationLabel;
@property(strong, nonatomic) IBOutlet UILabel *cAngulationLabel;
@property(strong, nonatomic) IBOutlet UILabel *cLongitudinalLabel;
@property(strong, nonatomic) IBOutlet UILabel *cHeightLabel;

// IB Actions
- (IBAction)cStoreCleaerBtnClicked:(id)sender;


///////////////////////////////////

// Selected Run
@property(nonatomic) IBOutlet UIView *selectedRunView;
@property(nonatomic) IBOutlet UIImageView *selectedRunImageView;
@property(nonatomic) IBOutlet UIView *selectedRunExpandableView;
@property(strong, nonatomic) IBOutlet UILabel *srRotationLabel;
@property(strong, nonatomic) IBOutlet UILabel *srAngulationLabel;
@property(strong, nonatomic) IBOutlet UILabel *srLongitudinalLabel;
@property(strong, nonatomic) IBOutlet UILabel *srHeightLabel;

////////////////////


// Current Position Outlets
@property(nonatomic) IBOutlet UIView *currentPositionView;
@property(strong, nonatomic) IBOutlet UILabel *cpRotationLabel;
@property(strong, nonatomic) IBOutlet UILabel *cpAngulationLabel;
@property(strong, nonatomic) IBOutlet UILabel *cpLongitudinalLabel;
@property(strong, nonatomic) IBOutlet UILabel *cpHeightLabel;
@property(nonatomic) IBOutlet UIButton *finalStoreBtn;

// IB Actions
- (IBAction)finalStoreBtnClicked:(id)sender;


// Business Logic
@property(nonatomic,strong) NSMutableArray *cArmPostionDict;
@property(nonatomic,strong) NSMutableArray *cArmPostionStatus;
@property(nonatomic,assign) int currentStoreIdx;


@property (nonatomic, assign) int  currentRotationValue;
@property (nonatomic, assign) int  currentAngulationValue;
@property (nonatomic, assign) float  currentLongitudinalValue;
@property (nonatomic, assign) float  currentHeightValue;
@property (nonatomic, assign) NSInteger  pmCurrSystemMode;


-(void)initPositionMemoryView;
-(void)ResetSystemPositions;
@end

