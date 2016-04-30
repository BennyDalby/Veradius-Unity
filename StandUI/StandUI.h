//
//  StandUI.h
//  StandUI
//
//  Created by CLPricingTeam on 8/2/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "StandUIViewController.h"
#import "imageReview.h"
#import "ScrollPanelView.h"
#import "BottomPanelSuperView.h"

@class BottomPanelSuperView;

@interface StandUI : UIView<UIGestureRecognizerDelegate,scrollviewprotocol>
{
    CGPoint touch1,touch2,touchDownpointRight,touchDownpointLeft,colimatorPOint,presentpoint,pointon_MainView,Pointin_standuiView,mainViewleftShutterCenter,mainViewleftShutterCenterLeft ;
    CGFloat leftcroplineAngle,rightcroplineAngle,angle_mirror,angle_flip,cumulatedAngle,thetaoangleRight,thetaangleLeft,old_X,old_Y,distanceright,distanceleft,rotationangle,no_of_times,left_angle ;
    BOOL left_lastTouched,XRayImageExists,right_lastTouched,rotatingviewtouched,applaunch,hidden,positionbuttonclicked,mirror,flip,couplingshuttersON,auto_shutter,pagedownbutonpressed,pageupbutonpressed,onlyonce,overviewButtonClicked,navigationshadowViewsExists,overlapExists;
    StandUIViewController *standController ;
    CAShapeLayer *borderCircle ;
    UIView *parkview,*scrollbar,*bar,*navigationshadow  ;
    UIImageView *parkpanel1,*parkpanel2 ;
    UIBezierPath *path ;
    ScrollPanelView *scrollpanel ;
    NSArray *runarray,*imageArray,*runarray1,*imageArray1,*singleimageNumbers ;
    int overviewNumber ;
    NSMutableArray  *navigationshadowViews;
    NSInteger NoofObjectsOnEachBtn[4],rotating_Symbol_layered_onBtn,right_shutter_layered_onBtn,left_shutter_layered_onBtn;
}

@property(nonatomic) IBOutlet UIView *topview ;
@property(nonatomic) BOOL OverviewSelected ;
@property (nonatomic) IBOutlet UIButton *parkButton ;
@property (nonatomic) IBOutlet UIButton *recallButton ;
@property(nonatomic) CGFloat flipAngle,mirrorAngle ;
@property(nonatomic) IBOutlet UIView *topviewpanel ;
@property(nonatomic) BOOL runcycleButtonclicked ;
@property (nonatomic) IBOutlet UIButton *flipButton ;
@property (nonatomic) IBOutlet UIButton *mirrorButton ;
@property (nonatomic) IBOutlet UIButton *couplingButton ;
@property (nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic) IBOutlet UIButton *otherExambutton ;
@property(nonatomic) IBOutlet UISwitch *FluroxraySwitch ;
@property(nonatomic) IBOutlet UISwitch *ExpoxraySwitch ;
@property(nonatomic) IBOutlet UIImageView *statusImage ;
@property(nonatomic) IBOutlet UIImageView *bottompanelStatusImage ;
@property(nonatomic) BOOL collimator_leftview ;
@property(nonatomic) BOOL collimator_rightview ;
@property(nonatomic) IBOutlet UIImageView *pageupimage ;
@property(nonatomic) IBOutlet UIImageView *pagedownimage ;
@property(nonatomic) IBOutlet UIView *toppageupView ;
@property(nonatomic) IBOutlet UIView *bottompageupView ;
@property(nonatomic) BOOL leftviewtouched,rightviewtouched ;
@property(nonatomic) BOOL flipisON ,mirrorisON ;

@property(nonatomic) IBOutlet UIView *subview ;
@property (nonatomic) CGFloat circleRadius;
@property (nonatomic) CGPoint circleCenter;
@property(nonatomic) BOOL xrayOn ;
@property(nonatomic)BOOL xrayOff ;
@property(nonatomic)BOOL otherExam ;
@property(nonatomic)BOOL normalState ;
@property(nonatomic)BOOL clearGuideButtonSelected ;
@property(nonatomic) IBOutlet UILabel *noImage ;
@property(nonatomic)BOOL showcollimator ;
@property(nonatomic)BOOL collimatorOverlapped ;
@property(nonatomic)BOOL collimatorOverlapped_leftcropView ;
@property(nonatomic)BOOL collimatorOverlapped_rightcropView ;

@property(nonatomic) IBOutlet UIButton *coupleshutter_button ;

@property(nonatomic)StandUIViewController *controller ;
@property (nonatomic, weak) CAShapeLayer *circleLayer;
@property (nonatomic, weak) CAShapeLayer *boundingcircleLayer;
@property (nonatomic, weak) CAShapeLayer *maskLayer;
@property (nonatomic)  UIImageView *rotate_circle_view ;
@property (nonatomic)  UIImageView *leftImageview ;
@property (nonatomic)  UIImageView *rightImageview ;
@property (nonatomic)  UIImageView *leftcropImageview ;
@property (nonatomic)  UIImageView *rightcropImageview ;
@property(nonatomic)   UIImageView *collinator ;
@property(nonatomic)   UIImageView *cascadeImageview ;
@property(nonatomic)   UIImageView *cascadeImageviewRight ;
@property(nonatomic) IBOutlet UIImageView *number12 ;
@property(nonatomic) IBOutlet UIImageView *number3;
@property(nonatomic) IBOutlet UIImageView *number6;
@property(nonatomic) IBOutlet UIImageView *number9 ;
@property(nonatomic) IBOutlet UIButton *clearGuide ;
@property (nonatomic, weak) UIPinchGestureRecognizer *pinch;
@property (nonatomic, weak) UIPanGestureRecognizer   *pan;
@property(nonatomic) IBOutlet UIButton *detectorLaser ;
@property(nonatomic) IBOutlet UIButton *questionmark ;
@property(nonatomic) IBOutlet UIView *rightPanel ;
@property(nonatomic) BOOL questionmarkPressed ;

@property(nonatomic) NSInteger tagValueLeftPanel ;
@property(nonatomic) NSArray *leftpanelbuttonInfoList ;
@property(nonatomic) NSInteger tagValueRightPanel ;
@property(nonatomic) NSArray *rightpanelbuttonInfoList ;
@property(nonatomic) NSInteger tagValuestanduiPanel ;
@property(nonatomic) NSArray *standUIpanelbuttonInfoList ;
@property(nonatomic) NSInteger tagValuesimagenavigationtollbar ;
@property(nonatomic) NSMutableArray *imageNavigationtollbarList ;
@property(nonatomic) NSInteger tagValuetopPanel ;
@property(nonatomic) NSArray *TopPanelList ;
@property(nonatomic) NSInteger tagValuepagecontrol ;
@property(nonatomic) NSArray *pageControllerList ;

@property(nonatomic) CGFloat standuiCumulativeAngle ;
@property(nonatomic) IBOutlet UIView *maskViewforbottompanel ;
@property(nonatomic) IBOutlet UIImageView *questionImage ;

@property(nonatomic)IBOutlet UIButton *position_memory ;
@property(nonatomic) IBOutlet UIButton *reset_shutters_collinators;

-(void)shareInstance:(StandUIViewController *)controller ;

// Image review toolbar
@property(nonatomic) IBOutlet imageReview *imageNavigationtoolbar;
@property(nonatomic)IBOutlet UIButton *overviewButton ;

// Outlets of Image
@property(nonatomic) IBOutlet UILabel *flipLabel ;
@property(nonatomic) IBOutlet UILabel *mirrorLabel;
@property(nonatomic) IBOutlet UILabel *resetShutters ;
@property(nonatomic) IBOutlet UILabel *resetCollincators;
@property(nonatomic) IBOutlet UILabel *coupleshutters;
@property(nonatomic) IBOutlet UILabel *Automatic;
@property(nonatomic) IBOutlet UILabel *shutterPos;
@property(nonatomic) IBOutlet UIButton *AutomaticShutterBtn;
@property(nonatomic) IBOutlet UIButton *AutomaticShutterBtn1;
@property (nonatomic) IBOutlet UIImageView *flipImage;
@property (nonatomic) IBOutlet UIImageView *mirrorImage;
@property (nonatomic) IBOutlet UIImageView *resetShuttersCollinators;
@property (nonatomic) IBOutlet UIImageView *coupleshuttersImage;

@property(nonatomic) IBOutlet UILabel *RunLabel;
@property(nonatomic) IBOutlet UILabel *imageNolabel;

@property(nonatomic) IBOutlet UIButton *previousButton;
@property(nonatomic) IBOutlet UIButton *nextButton;

@property(nonatomic) IBOutlet UIImageView *previousBtnImage;
@property(nonatomic) IBOutlet UIImageView *nextBtnImage;

@property(nonatomic) IBOutlet UIButton *AllImageButton;
@property (nonatomic) IBOutlet UIImageView *AllImage_RightPanel;
@property(nonatomic) IBOutlet UILabel *AllImage_Lbl;

@property(nonatomic) IBOutlet UIButton *OneImageButton;
@property (nonatomic) IBOutlet UIImageView *OneImage_RightPanel;
@property(nonatomic) IBOutlet UILabel *OneImage_Lbl;

@property(nonatomic) IBOutlet UIButton *pageUpButton;
@property(nonatomic) IBOutlet UIButton *pageDownButton;

@property (strong, nonatomic) IBOutlet BottomPanelSuperView *bottomPanelSuperView;

- (void)updateCirclePathAtLocation:(CGPoint)location radius:(CGFloat)radius ;
// To display clinical images
@property(nonatomic)int examinationType;
-(void)changeXRayImage:(NSString *) imageName;
-(void)ChangeFluoroMode:(NSString*)str;
-(void)ChangeExposureMode:(NSString*)str;
-(void)Hide_UnhideNavigationToolbar:(BOOL)val;

- (IBAction)AllImagesBtnClicked:(id)sender;
- (IBAction)OnePage_RunBtnClicked:(id)sender;
-(void)switchtoImageReviewMode;
-(void)hide_UnHide_PageNavigationButtons:(BOOL)val;
-(NSString*)getCurrentClinicalImage;

- (IBAction)PageUpBtnClicked:(id)sender ;
- (IBAction)PageDownBtnClicked:(id)sender;

@end
