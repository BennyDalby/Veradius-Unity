//
//  StandUIViewController.h
//  StandUI
//
//  Created by CLPricingTeam on 8/2/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExpandedTable.h"
#import "DropDown.h"
#import "ExaminationTypeSelection/ExaminationTypeSelView.h"
#import "PositionMemory.h"
#import "ImageReview/imageReview.h"
#import "ScrollPanelView.h"
#import "StandUISystem.h"
#import "HTMLHelp.h"
#import "AboutScreen/AboutScreen.h"

@class StandUI ;

@interface StandUIViewController : UIViewController<BOExpandableTableViewDelegate,ExaminationTypeSeldelegate,HelpDialogdelegate, UIGestureRecognizerDelegate>
{
    DropDown *dropdownTable ;
    CommentTableCell *comment_cell ;
    NSMutableArray *cellNames ;
    NSString *celltitle ;
  
    NSMutableArray *list;
    UIButton *listboxButton ;
    UIButton *modeButton;
    UIButton *doseButton;
    UIButton *pulsesButton;
    UIButton *storeButton;
    UIButton *blurButton;
    UIButton *noiseButton;
    UIButton *expModeButton;
    UIButton *expPulseButton;
    UILabel *Expstorelabel;
    
    NSArray *modeArray;
    NSArray *doseArray;
    NSArray *pulsesArray;
    NSArray *storeArray;
    NSArray *expModeArray;
    NSArray *expStoreArray;
    NSArray *expPulseArray;
    
    UITextField *currentEntryTextField;
    int buttonSelected;
    NSIndexPath *path ;
    
    CGPoint oldpoint,newpoint ;
    
    BOOL scrollviewpressed ;
    
    ExaminationTypeSelView *examinationTypeSelView;
    StandUISystem *standUISystemView;
    HTMLHelp *HelpView;
    
    AboutScreen *controller;
    UIPopoverController *popoverController;
    
}

@property (strong, nonatomic) IBOutlet UIView *BottomPanel;
@property (strong, nonatomic) IBOutlet UIView *LeftSidePanel;
@property (strong, nonatomic) IBOutlet UIView *RightsidePanel;
@property (strong, nonatomic) IBOutlet UIView *kvManualView;
@property (strong, nonatomic) IBOutlet ExpandedTable *dashboardTable;
@property (weak, nonatomic) IBOutlet ExaminationTypeSelView *examinationTypeSelView;
@property(nonatomic)   UIImageView *collinator ;
@property(nonatomic) BOOL collimatorclicked;
@property(nonatomic) CGFloat count1 ;
@property(nonatomic) BOOL collinatorTouched ;
@property(nonatomic) IBOutlet UIView *mainView ;
@property(nonatomic) IBOutlet UIView *simulationSuperView ;
@property(nonatomic) UITapGestureRecognizer *panGesture;
@property(nonatomic) NSInteger tagbuttonofBottomsection ;
@property(nonatomic) NSArray *bottomSectionButtonArray ;
@property(nonatomic) NSArray *bottomSectionButtonArraycell3 ;

@property(nonatomic) IBOutlet UIButton *zoomButton;
@property(nonatomic) IBOutlet UIButton *clearGuideButton;
@property(nonatomic) IBOutlet UIButton *detectorButton;
@property(nonatomic) IBOutlet UIButton *tubeButton;
@property (nonatomic)BOOL detectorButtonCLicked;
@property (nonatomic)BOOL kvManualButtonCLicked;

// KVManual
@property(nonatomic) IBOutlet UIButton *kvManualButton;
@property(nonatomic) IBOutlet UIButton *kvManualIncrementButton;
@property(nonatomic) IBOutlet UIButton *kvManualDecrementButton;
@property(nonatomic) IBOutlet UILabel *kvManualLbl;
@property(nonatomic) IBOutlet UILabel *kvManualStatusBarLbl;

@property(nonatomic) IBOutlet UIButton *positionMemoryButton;
@property (strong, nonatomic) IBOutlet StandUI *standuiView;
@property (atomic)BOOL positionMemoryButtonCLicked;

// Contrast & Brightness slider

@property (strong, nonatomic) IBOutlet UIView *contrastView;
@property (nonatomic, retain) IBOutlet UISlider *contrastSlider;
@property(nonatomic) IBOutlet UILabel *contrastLbl;
@property(nonatomic) IBOutlet UIButton *AutoButton;
@property(nonatomic) IBOutlet UIButton *ContrastBrightnessBtn;
@property(nonatomic) IBOutlet UILabel *contrastBtnLbl;
@property(nonatomic) IBOutlet UILabel *brightnessLbl;
@property(nonatomic) IBOutlet UIView *standviewParent ;
@property(nonatomic) IBOutlet UIButton *AboutScreenBtn;

- (IBAction)zoomButtonCLicked:(id)sender;
- (IBAction)detectorButtonCLicked:(id)sender;
- (IBAction)tubeButtonCLicked:(id)sender;
- (IBAction)kvManualButtonCLicked:(id)sender;
- (IBAction)positionMemoryButtonCLicked:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
-(void)SetUserInteraction:(BOOL)status;
-(IBAction)pageup:(id)sender ;


@property (strong, nonatomic)  PositionMemory *posMemView;

-(void)createCollinator ;
-(void)loadQuestionmarks;
-(void)hideQuestionMarks ;


@end
