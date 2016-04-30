//
//  StandUIViewController.m
//  StandUI
//
//  Created by CLPricingTeam on 8/2/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "StandUIViewController.h"
#import "Constants.h"
#import "ExaminationTypeSelection/ExaminationTypeSelView.h"
#import "ExaminationTypeSelection/ExaminationTypeConstants.h"
#import "StandUI.h"
#import "ScrollPanelView.h"
#import "System/StandUISystem.h"



#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)
#define KVINCREMENT 01
#define KVDECREMENT 02

#define RUUD_COMMENTS 1

@interface StandUIViewController ()
@property (nonatomic,assign) NSString *selectedFluoroMode;
@property (nonatomic,assign) NSString *selectedDose;
@property (nonatomic,assign) NSString *selectedPulses;
@property (nonatomic,assign) NSString *selectedFluroStore;
@property (nonatomic,assign) NSString *selectedExpMode;
@property (nonatomic,assign) NSString *selectedExpPulse;
@property (nonatomic,assign) NSString *selectedExpStore;
@property (nonatomic,assign) int defaultVascularModeChanged;
@property (nonatomic,assign) int defaultSkeletonModeChanged;
@property (nonatomic,assign) int defaultExpPulseChanged;
@property (nonatomic,assign) int currentExpandedSettings;
@property (nonatomic,assign) int defaultUrologynModeChanged;
@property (nonatomic,assign) int defaultEndoscopyModeChanged;
@property (nonatomic,assign) int defaultPainModeChanged;
@property (nonatomic,assign) int defaultCardioModeChanged;
@property (nonatomic,assign) int defaultExpModeChanged;
@property (nonatomic,assign) NSString *PreviousExpPulseVal;
@property (nonatomic,assign) NSString *PreviousFluoroPulseVal;

@property (nonatomic,strong) UILabel *pulseHyphenLabel;
@property (nonatomic,assign) NSString *examinationCellTytle;
@property (nonatomic,assign) NSString *fluoroCellTytle;
@property (nonatomic,assign) NSString *expCellTytle;

@property (nonatomic, strong) NSString* procedureType;
@property (nonatomic, strong) NSString* detailedProcedureType;
@property (nonatomic, strong) NSString* anatomyType;
@property(nonatomic,strong)  UIImageView *zoomImage;
@property (nonatomic)    NSInteger state ;
@property (nonatomic)BOOL zoomButtonCLicked;

@property (nonatomic)BOOL tubeButtonCLicked;

@property (nonatomic)BOOL blurButtonCLicked;
@property (nonatomic)BOOL noiseButtonCLicked;

@property (nonatomic,assign)int kvManualValue;
@property(nonatomic)BOOL AutoBtn;

@property (strong, atomic)NSTimer *KVManualTimer;
@property (atomic,assign)int KVManualActiveButton;

@property (strong, nonatomic) IBOutlet StandUISystem  *systemMenu;
@property (strong, nonatomic) IBOutlet UIView  *HelpMenu;
@property(nonatomic) IBOutlet UIButton *helpCloseBtn;


@end

@implementation StandUIViewController
@synthesize selectedFluoroMode;
@synthesize selectedDose;
@synthesize selectedPulses;
@synthesize selectedFluroStore;
@synthesize selectedExpMode;
@synthesize selectedExpStore;
@synthesize examinationCellTytle;
@synthesize fluoroCellTytle;
@synthesize expCellTytle;
@synthesize selectedExpPulse;
@synthesize zoomButton,tubeButton,positionMemoryButton,kvManualButton,clearGuideButton,detectorButton;
@synthesize zoomImage;
@synthesize state;
@synthesize procedureType;
@synthesize anatomyType;
@synthesize detailedProcedureType;
@synthesize defaultVascularModeChanged;
@synthesize defaultSkeletonModeChanged;
@synthesize defaultUrologynModeChanged;
@synthesize defaultEndoscopyModeChanged;
@synthesize defaultPainModeChanged;
@synthesize defaultCardioModeChanged;
@synthesize defaultExpPulseChanged;
@synthesize currentExpandedSettings;
@synthesize pulseHyphenLabel;
@synthesize defaultExpModeChanged;;
@synthesize PreviousExpPulseVal;
@synthesize PreviousFluoroPulseVal;

// KV Manual view
@synthesize kvManualView;
@synthesize kvManualValue;
@synthesize kvManualLbl;
@synthesize kvManualStatusBarLbl;
@synthesize KVManualTimer;
@synthesize KVManualActiveButton;

// Contrast and Brightness
@synthesize contrastSlider;
@synthesize contrastLbl;
@synthesize AutoButton;
@synthesize contrastView;
@synthesize AutoBtn;
@synthesize ContrastBrightnessBtn;
@synthesize contrastBtnLbl;
@synthesize brightnessLbl;
@synthesize posMemView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //for gradiant effects of each view
    [self gradiantEffect_forrightPanel];
    [self gradiantEffect_forbottomPanel];
    [self cornerBackground];
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    self.dashboardTable.dataSource = self.dashboardTable;
    self.dashboardTable.delegate = self.dashboardTable;
    self.dashboardTable.exDelegate = self;
    buttonSelected = 0;
    state = 1;
    [self.dashboardTable inittableSelect];
    _collinatorTouched=NO;
    
    [ self InitialiseListItems ];
    
     celltitle=nil;
    self.dashboardTable.tableCellViewLabels=cellNames;
    
   
    
    _bottomSectionButtonArray=[[NSArray alloc]initWithObjects:@"Select fluroscopy acquisition mode",@"Select fluroscopy dose",@"Select fluroscopy pulse rate",@"Select which fluroscopy images should be stored",@"Reduce motion blur",@"Reduce noise",nil];
    
    list=[[NSMutableArray alloc]init];
    
    _collimatorclicked=NO ;
    scrollviewpressed=NO ;
    
    procedureType = SKELETON;
    anatomyType = SKELETONPROCEDURELEGS;
    detailedProcedureType = ANATOMYSKELETONLEGS;
    defaultVascularModeChanged = 0;
    defaultSkeletonModeChanged = 0;
    defaultUrologynModeChanged = 0;
    defaultEndoscopyModeChanged = 0;
    defaultPainModeChanged = 0;
    defaultCardioModeChanged = 0;
    defaultExpModeChanged = 0;
    PreviousExpPulseVal = @"";
    PreviousFluoroPulseVal = @"";
    posMemView = nil;
    
    [self createCollinator];
    [self CreatePositionMemoryView];
    
    kvManualView.layer.cornerRadius = 20.0f;
    kvManualView.layer.borderWidth = 1;
    kvManualView.layer.borderColor = [[UIColor blackColor]CGColor];
    kvManualValue = KVMANUALMIN;
    NSString *str = [NSString stringWithFormat: @"%d", kvManualValue];
    kvManualLbl.text = str;
    kvManualStatusBarLbl.text = str;
    [kvManualView setHidden:YES];
    
    [self MaskButtonlayer:self.kvManualDecrementButton :(UIRectCornerTopLeft | UIRectCornerBottomLeft)];
    [self MaskButtonlayer:self.kvManualIncrementButton:( UIRectCornerTopRight| UIRectCornerBottomRight)];
    
    [self.standuiView shareInstance:self];
    [self.standuiView ChangeFluoroMode:selectedFluoroMode];
    [self.standuiView ChangeExposureMode:selectedExpMode];
        
    NSLog(@"standui centre values are %f %f",_standuiView.center.x,_standuiView.center.y);
    
    [self setupTouchButton:self.kvManualIncrementButton :KVINCREMENT];
    [self setupTouchButton:self.kvManualDecrementButton :KVDECREMENT];
    
    [self InitialiseSlider];
  
    //[self CreateScrollView];
  //  [self loadQuestionmarks];
    
    examinationTypeSelView = nil;
    controller = nil;
   
}



- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)InitialiseListItems
{
    self.zoomButtonCLicked = YES;
    self.detectorButtonCLicked = YES;
    self.tubeButtonCLicked = YES;
    self.kvManualButtonCLicked= YES;
    self.positionMemoryButtonCLicked= YES;
    self.blurButtonCLicked =YES;
    self.noiseButtonCLicked =YES;
    
    modeArray = [NSArray arrayWithObjects:FLUORO,ROADMAP,nil];
    doseArray = [NSArray arrayWithObjects:LOW, NORMAL,INCREASED,HIGHLEVEL, nil];
    pulsesArray = [NSArray arrayWithObjects:FOURPERSEC, EIGHTPERSEC, FIFTEENPERSEC, nil];
    storeArray = [NSArray arrayWithObjects:LIH, NOSTORAGE, STOREALL, nil];
    expModeArray = [NSArray arrayWithObjects:SINGLEEXPOSURE, EXPOSURERUN, SUBTRACT,TRACE, nil];
    expStoreArray = [NSArray arrayWithObjects:EXPLIH,EXPSTOREALL, nil];
    
    
    selectedFluoroMode  = FLUORO;
    selectedDose        = NORMAL ;
    selectedPulses      = FIFTEENPERSEC;
    selectedFluroStore  = NOSTORAGE;
    selectedExpMode     = SINGLEEXPOSURE;
    selectedExpStore    = EXPLIH;
    selectedExpPulse    = TWOPERSEC;
    
    fluoroCellTytle = [NSString stringWithFormat:@"%@\r%@ %@", selectedFluoroMode,selectedPulses,selectedFluroStore];
    expCellTytle = [NSString stringWithFormat:@"%@\r %@", selectedExpMode,selectedExpStore];
    cellNames=[[NSMutableArray alloc]init];
    [cellNames addObject:@"Skeleton\rLegs"];
    [cellNames addObject:fluoroCellTytle];
    [cellNames addObject:expCellTytle];
}

-(void)InitialiseSlider
{
    // Rotate the slider
    [contrastSlider removeConstraints:contrastSlider.constraints];
    [contrastSlider setTranslatesAutoresizingMaskIntoConstraints:YES];
    contrastSlider.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-90));
    
    [contrastSlider setThumbImage:[UIImage imageNamed:@"Sliderarrow.png"] forState:UIControlStateNormal];
    [contrastSlider setMinimumTrackTintColor:[UIColor grayColor]];
    [contrastSlider setMaximumTrackTintColor:[UIColor grayColor]];
   

    contrastLbl.lineBreakMode = NSLineBreakByWordWrapping;
    contrastLbl.numberOfLines = 0;
    
    contrastSlider.maximumValue = CONTRASTSLIDELINEMAX;
    contrastSlider.minimumValue = CONTRASTSLIDElINEMIN;
    contrastSlider.value  = CONTRASTSLIDEMIN;
    contrastSlider.continuous = YES;
    
    AutoButton.layer.cornerRadius = 2;
    AutoButton.layer.borderWidth = 0.5;
    AutoButton.layer.borderColor = [UIColor blackColor].CGColor;
    AutoButton.backgroundColor = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];
 
    [AutoButton setTintColor:[UIColor whiteColor]];
    [contrastView setHidden:YES];
    AutoBtn = NO;
    
  }


- (IBAction)sliderValueChanged:(id)sender {
    
    [contrastSlider setMinimumTrackTintColor:[UIColor grayColor]];
    AutoButton.layer.borderWidth = 0.5;
    AutoButton.layer.borderColor = [UIColor blackColor].CGColor;
    [AutoButton setTitleColor:[UIColor colorWithRed:255.0/256.0 green:255.0/256.0 blue:255.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    AutoBtn = NO;
    NSUInteger index = contrastSlider.value;
    if(index < CONTRASTSLIDEMIN)
    {
         contrastSlider.value  = CONTRASTSLIDEMIN;
    }
    else if( index >  CONTRASTSLIDEMAX)
    {
        contrastSlider.value  = CONTRASTSLIDEMAX;
    }
}

- (IBAction)ContrastButtonTapped:(id)sender {

    if( contrastView.hidden == YES)
    {
        ContrastBrightnessBtn.layer.cornerRadius = 2;
        ContrastBrightnessBtn.layer.borderWidth = 1.0;
        ContrastBrightnessBtn.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        contrastBtnLbl.textColor = [UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:0.8];
        brightnessLbl.textColor = [UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:0.8 ];
        contrastView.hidden = NO;
        
//        for (UIView *view in [contrastView subviews])
//        {
//            if ([view isKindOfClass:[UIButton class]])
//            {
//               
//                 UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
//                
//                [self.contrastView addSubview:questionmarkVIEW];
//                
//                questionmarkVIEW.center = view.center ;
//                
//                
//            }
//            
//            
//            if ([view isKindOfClass:[UISlider class]])
//            {
//                
//                UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
//                
//                [self.contrastView addSubview:questionmarkVIEW];
//                
//                questionmarkVIEW.center = view.center ;
//                
//                
//            }
//            
//            
//        }
//        
        
    }
    else
    {
        contrastBtnLbl.textColor = [UIColor whiteColor];
        brightnessLbl.textColor = [UIColor whiteColor];
        ContrastBrightnessBtn.layer.borderColor =[UIColor clearColor].CGColor;
        contrastView.hidden = YES;
    }
}

- (IBAction)AutoButtonTapped:(id)sender {
    
    AutoBtn = !AutoBtn;
    if(AutoBtn)
    {
        AutoButton.layer.borderWidth = 1.0;
        AutoButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        [AutoButton setTitleColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    }
    else
    {
        AutoButton.layer.borderWidth = 0.5;
        AutoButton.layer.borderColor = [UIColor blackColor].CGColor;
        [AutoButton setTitleColor:[UIColor colorWithRed:255.0/256.0 green:255.0/256.0 blue:255.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    }
}

#pragma mark - Gradiant Effects

-(void)gradiantEffect_forrightPanel
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.RightsidePanel.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:43/255.0 green:42/255.0 blue:39/255.0 alpha:1.0] CGColor], (id)[[UIColor grayColor] CGColor], nil];
    [self.RightsidePanel.layer insertSublayer:gradient atIndex:1];
}

-(void)gradiantEffect_forbottomPanel
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.BottomPanel.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:43/255.0 green:42/255.0 blue:39/255.0 alpha:1.0] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [self.BottomPanel.layer insertSublayer:gradient atIndex:0];
    
}

-(void)cornerBackground
{
    self.BottomPanel.layer.borderColor=[[UIColor grayColor]CGColor];
    self.BottomPanel.layer.borderWidth=1.0;
    self.LeftSidePanel.layer.cornerRadius=5.0;
}

- (void) customizeCell: (CommentTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( self.standuiView.xrayOff)
    {
        if(indexPath.row == 0 ) {
            [self CreateExaminationTypeSelectionView ];
        }
        
        if (indexPath.row==1) {
            [self CreateFluoroScopySettings:cell];
        }
        
        if (indexPath.row==2) {
            [self CreateExposureSettings:cell];
        }
    }
}

-(void)CreateExaminationTypeSelectionView
{
    if( examinationTypeSelView==nil)
    {
        [self.collinator setHidden:YES];
        // [examinationTypeSelView setHidden:NO];
        CGRect examTypeSelFrame = CGRectMake( 127, 15, 768, 665 );
        examinationTypeSelView =  [[[NSBundle mainBundle] loadNibNamed:@"ExaminationTypeSelView" owner:self options:nil] firstObject];
        examinationTypeSelView.frame =examTypeSelFrame;
        [examinationTypeSelView initExamTypeSelectionView];
        examinationTypeSelView.examinationTypeSelectiondelegate=self;
        [self.view addSubview:examinationTypeSelView];
        examinationTypeSelView.hidden=NO;
    }
    else
    {   examinationTypeSelView.hidden=NO;
        [self.view bringSubviewToFront:examinationTypeSelView];
        [self.standuiView Hide_UnhideNavigationToolbar:YES];
    }
}

-(void)CreateFluoroScopySettings:(CommentTableCell *)cell
{
    cell.ytdTextField.hidden = NO;
    
    cell.viewForBottomSection.layer.borderColor=[[UIColor blackColor]CGColor];
    cell.viewForBottomSection.layer.borderWidth=1;
    
    cell.viewForBottomSection.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    
    CGFloat x,y,width,height,offset;
    x =60.0;
    y = 15.0;
    width = 130;
    height = 35.0;
    offset = 5.0;
    
    currentExpandedSettings = FLUOROSCOPYSETTINGS;
   
    // Creating the Mode Label & Button
    
    CGRect labelFrame = CGRectMake( 20, y, 100, 30 );
    UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
    [label setText: @"Mode"];
    [label setTextColor: [UIColor whiteColor]];
    label.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [cell.viewForBottomSection addSubview:label];

#ifdef RUUD_COMMENTS

  
        UIButton *modeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        modeBtn.tag = MODE;
        [modeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [modeBtn setTitle:selectedFluoroMode forState:UIControlStateNormal];
        modeBtn.titleLabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
        modeBtn.frame = CGRectMake(70, y, width, height);
    
        if([procedureType  isEqual: VASCULAR])
        {
            [modeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [modeBtn addTarget:self
                        action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
            
            [modeBtn setBackgroundImage:[UIImage imageNamed:@"ListBoxImage.png"] forState:UIControlStateNormal];
        }
        modeButton=modeBtn;
        [cell.viewForBottomSection addSubview:modeBtn];
    
#else
    
    UIButton *modeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    modeBtn.tag = MODE;
    [modeBtn addTarget:self
               action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    [modeBtn setBackgroundImage:[UIImage imageNamed:@"ListBoxImage.png"] forState:UIControlStateNormal];
    [modeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [modeBtn setTitle:selectedFluoroMode forState:UIControlStateNormal];
    modeBtn.titleLabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    modeBtn.frame = CGRectMake(70, y, width, height);
    modeButton=modeBtn;
    [cell.viewForBottomSection addSubview:modeBtn];

#endif
    
    // Creating the Dose Label and Button
    
    CGRect doselabelFrame = CGRectMake( 20,y+40 , 100, 30 );
    UILabel* doselabel = [[UILabel alloc] initWithFrame: doselabelFrame];
    doselabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [doselabel setText: @"Dose"];
    [doselabel setTextColor: [UIColor whiteColor]];
    [cell.viewForBottomSection addSubview:doselabel];
    
    UIButton *doseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doseBtn.tag = DOSE;
    [doseBtn addTarget:self
                action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    [doseBtn setBackgroundImage:[UIImage imageNamed:@"ListBoxImage.png"] forState:UIControlStateNormal];
    [doseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doseBtn setTitle:selectedDose forState:UIControlStateNormal];
    doseBtn.titleLabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    doseBtn.frame = CGRectMake(70,y+40 , width, height);
    doseButton=doseBtn;
    [cell.viewForBottomSection addSubview:doseBtn];
    
     // Creating the Pulse Label and Button
    CGRect pulselabelFrame = CGRectMake( 20,y+80, 100, 30 );
    UILabel* pulselabel = [[UILabel alloc] initWithFrame: pulselabelFrame];
    pulselabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [pulselabel setText: @"Pulse"];
    [pulselabel setTextColor: [UIColor whiteColor]];
    [cell.viewForBottomSection addSubview:pulselabel];
    
    UIButton *pulsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pulsBtn setTitle:selectedPulses forState:UIControlStateNormal];
    [pulsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pulsBtn.titleLabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [pulsBtn setBackgroundImage:[UIImage imageNamed:@"ListBoxImage.png"] forState:UIControlStateNormal];
    pulsBtn.tag = PULSES;
    [pulsBtn addTarget:self
                action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    pulsBtn.frame = CGRectMake(70, y+80, width, height);
    pulsesButton=pulsBtn;
    [cell.viewForBottomSection addSubview:pulsBtn];

    
    // creating the store Label and  button
    CGRect storelabelFrame = CGRectMake( 20, y+120, 100, 30 );
    UILabel* storelabel = [[UILabel alloc] initWithFrame: storelabelFrame];
    storelabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [storelabel setText: @"Store"];
    [storelabel setTextColor: [UIColor whiteColor]];
    [cell.viewForBottomSection addSubview:storelabel];
    
    
    UIButton *strBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    strBtn.tag = STORE;
    [strBtn addTarget:self
                action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    [strBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [strBtn setBackgroundImage:[UIImage imageNamed:@"ListBoxImage.png"] forState:UIControlStateNormal];

    [strBtn setTitle:selectedFluroStore forState:UIControlStateNormal];
    strBtn.titleLabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    strBtn.frame = CGRectMake(70, y+120, width, height);
    storeButton=strBtn;
    [cell.viewForBottomSection addSubview:strBtn];
    

    // creating the Reduce Blur Button
    blurButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [blurButton addTarget:self
               action:@selector(reduceBlur:) forControlEvents:UIControlEventTouchUpInside];
    [blurButton setBackgroundImage:[UIImage imageNamed:@"Reduce_Blur_1.png"] forState:UIControlStateNormal];
    //[blurButton setTitle:@"Reduce Blur" forState:UIControlStateNormal];
    blurButton.frame = CGRectMake(15, y+190, 90, 40);
    // blurButton.layer.cornerRadius=5.0;
    [cell.viewForBottomSection addSubview:blurButton];
    
   // creating the Reduce Noise Button
    noiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noiseButton addTarget:self
                   action:@selector(reduceNoise:) forControlEvents:UIControlEventTouchUpInside];
    [noiseButton setBackgroundImage:[UIImage imageNamed:@"reduce_Noise_1.png"] forState:UIControlStateNormal];
   if(self.noiseButtonCLicked == NO )
   {
       self.noiseButtonCLicked = YES;
       [self reduceNoise:nil];
   }
   else if (self.blurButtonCLicked == NO)
   {
       self.blurButtonCLicked = YES;
       [self reduceBlur:nil];
   }
    
   // [noiseButton setTitle:@"Reduce Noise" forState:UIControlStateNormal];
    noiseButton.frame = CGRectMake(115,y+190, 90, 40);
   // noiseButton.layer.cornerRadius=5.0;
    [cell.viewForBottomSection addSubview:noiseButton];
    comment_cell=cell;
    
    
}

-(void)SetUserInteraction:(BOOL)status
{
    modeButton.userInteractionEnabled = status;
    doseButton.userInteractionEnabled = status;
    pulsesButton.userInteractionEnabled = status;
    storeButton.userInteractionEnabled = status;
    blurButton.userInteractionEnabled = status;
    noiseButton.userInteractionEnabled = status;
    expModeButton.userInteractionEnabled = status;
    expPulseButton.userInteractionEnabled = status;
}

-(void)CreateExposureSettings:(CommentTableCell *)cell
{
    cell.ytdTextField.hidden = NO;
    
    cell.viewForBottomSection.layer.borderColor=[[UIColor blackColor]CGColor];
    cell.viewForBottomSection.layer.borderWidth=1;
    cell.viewForBottomSection.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    
    CGFloat x,y,width,height,offset;
    x =60.0;
    y = 20.0;
    width = 100;
    height = 40.0;
    offset = 5.0;
    
    currentExpandedSettings = EXPOSURESETTINGS;
    
    // Creating  Mode label and button
    
    CGRect modeFrame = CGRectMake( 30, y, 100, 30 );
    UILabel* modelabel = [self createLabel:modeFrame :@"Mode" ];
    modelabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [cell.viewForBottomSection addSubview:modelabel];
    
    expModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    expModeButton.tag = EXPMODE;
    [expModeButton addTarget:self
                      action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    if([procedureType  isEqual: UROLOGY]  && defaultUrologynModeChanged == 0)
    {
        selectedExpMode = SINGLEEXPOSURE;
    }
    else if ([procedureType  isEqual: ENDOSCOPY] && defaultEndoscopyModeChanged == 0)
    {
        selectedExpMode = SINGLEEXPOSURE;
    }
    else if ([procedureType  isEqual: PAIN] && defaultPainModeChanged == 0)
    {
        selectedExpMode = SINGLEEXPOSURE;
    }
    else if([procedureType  isEqual: SKELETON] && defaultSkeletonModeChanged ==0)
    {
        selectedExpMode = SINGLEEXPOSURE;
    }
    else if([procedureType  isEqual: VASCULAR] && [selectedFluoroMode isEqual:ROADMAP])
    {
        selectedExpMode = TRACE;
    }
    else if([procedureType  isEqual: VASCULAR]   && defaultVascularModeChanged == 0)
    {
        selectedExpMode = SUBTRACT;
    }
    if([procedureType  isEqual: CARDIO] && defaultCardioModeChanged == 0)
    {
        selectedExpMode = EXPOSURERUN;
    }
    [expModeButton setTitle:selectedExpMode forState:UIControlStateNormal];
    expModeButton.frame = CGRectMake(70, y, 125, 30);
    [expModeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    expModeButton.titleLabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [expModeButton setBackgroundImage:[UIImage imageNamed:@"ListBoxImage.png"] forState:UIControlStateNormal];
    [cell.viewForBottomSection addSubview:expModeButton];
    
    // Creating Pulse Label and Button
    modeFrame = CGRectMake( 30, y+height, width, height );
    UILabel *pulselabel= [self createLabel:modeFrame :@"Pulses" ];
    pulselabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [cell.viewForBottomSection addSubview:pulselabel];
    
    // Create Pulse Selection Fixed label and hide and Unhide deopending upon the ExpMode selection
    
    modeFrame = CGRectMake( 130, y+height, width, height );
    pulseHyphenLabel= [self createLabel:modeFrame :@"-" ];
    pulseHyphenLabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [cell.viewForBottomSection addSubview:pulseHyphenLabel];
    pulseHyphenLabel.hidden=YES;
    
    expPulseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    expPulseButton.tag = EXPPULSES;
    [expPulseButton addTarget:self
                       action:@selector(aMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([ selectedExpMode isEqual:SINGLEEXPOSURE] ) {
        selectedExpPulse = HYPHEN;
        expPulseButton.hidden=YES;
        pulseHyphenLabel.hidden=NO;
    }
    else  if( !defaultExpPulseChanged )
    {
        if([procedureType  isEqual: SKELETON] && ([ selectedExpMode isEqual:EXPOSURERUN] && defaultExpPulseChanged == 0) )
        {
            selectedExpPulse = FOURPERSEC;
        }
        else if([procedureType  isEqual: VASCULAR] && !([ selectedExpMode isEqual:SINGLEEXPOSURE] && defaultExpPulseChanged == 0) )
        {
            selectedExpPulse = TWOPERSEC;
        }
        else if ([ selectedExpMode isEqual:EXPOSURERUN]  &&  !([procedureType  isEqual: SKELETON] || [procedureType  isEqual: VASCULAR] ))
        {
            selectedExpPulse = FOURPERSEC;
        }
    }
    
    [expPulseButton setTitle:selectedExpPulse forState:UIControlStateNormal];
    
    [expPulseButton setTitle:selectedExpPulse forState:UIControlStateNormal];
    expPulseButton.frame = CGRectMake(70, y+height+offset, 125, 30);
    [expPulseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    expPulseButton.titleLabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [expPulseButton setBackgroundImage:[UIImage imageNamed:@"ListBoxImage.png"] forState:UIControlStateNormal];
    [cell.viewForBottomSection addSubview:expPulseButton];
    
    modeFrame = CGRectMake( 30, y+(height*2)+offset, width, 30 );
    UILabel *storelabel = [self createLabel:modeFrame :@"Store" ];
    storelabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [cell.viewForBottomSection addSubview:storelabel];
    
    modeFrame = CGRectMake( 120, y+(height*2)+offset, width, 30 );
    Expstorelabel = [self createLabel:modeFrame :selectedExpStore ];
    Expstorelabel.font=[UIFont fontWithName:@"Gill Sans" size:13.0f];
    [cell.viewForBottomSection addSubview:Expstorelabel];
    comment_cell=cell;
    
    
    
}

-(UILabel*)createLabel:(CGRect )frame :(NSString*)labeltext
{
    UILabel* label = [[UILabel alloc] initWithFrame: frame];
    [label setText: labeltext];
    [label setTextColor: [UIColor whiteColor]];
    return label;
}


-(void)aMethod:(UIButton *)sender
{
    NSArray *selectedArray ;
    if (dropdownTable==nil) {
        
        UIButton *button = (UIButton*) sender;
        dropdownTable=[[DropDown alloc]initWithFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, sender.frame.size.width, 0)];
        
        switch (button.tag) {
            case MODE:
#ifdef RUUD_COMMENTS
                if([procedureType  isEqual: VASCULAR])
                {
                    NSArray *tmpmodeArray = [NSArray arrayWithObjects:FLUORO,ROADMAP,Nil];
                    [dropdownTable initialiseDataSource:tmpmodeArray with:selectedFluoroMode];
                    selectedArray= [ NSArray arrayWithArray:tmpmodeArray];

                }
            
#else
                [dropdownTable initialiseDataSource:modeArray];
                selectedArray= [ NSArray arrayWithArray:modeArray];
#endif
                break;
            case DOSE:
                 [dropdownTable initialiseDataSource:doseArray with:selectedDose];
                    selectedArray= [ NSArray arrayWithArray:doseArray];
                break;
            case PULSES:
                [dropdownTable initialiseDataSource:pulsesArray with:selectedPulses];
                selectedArray= [ NSArray arrayWithArray:pulsesArray];
                break;
            case STORE:
                [dropdownTable initialiseDataSource:storeArray with:selectedFluroStore];
                selectedArray= [ NSArray arrayWithArray:storeArray];
                break;
            case EXPMODE:
#ifdef RUUD_COMMENTS
               
                if(([procedureType  isEqual: SKELETON]  ||
                    [procedureType  isEqual: UROLOGY]   ||
                    [procedureType  isEqual: ENDOSCOPY] ||
                    [procedureType  isEqual: CARDIO])
                   )
                {
                    expModeArray = [NSArray arrayWithObjects:SINGLEEXPOSURE, EXPOSURERUN, nil];
                    [dropdownTable initialiseDataSource:expModeArray with:selectedExpMode];
                  //  selectedExpMode     = SINGLEEXPOSURE;
                    selectedArray= [ NSArray arrayWithArray:expModeArray];
                }
                else if([procedureType  isEqual: VASCULAR])
                {
                    expModeArray = [NSArray arrayWithObjects:SINGLEEXPOSURE, EXPOSURERUN,SUBTRACT,TRACE, nil];
                    [dropdownTable initialiseDataSource:expModeArray with:selectedExpMode];
                 //   selectedExpMode     = SUBTRACT;
                    selectedArray= [ NSArray arrayWithArray:expModeArray];

                }
                else if([procedureType  isEqual: PAIN])
                {
                    expModeArray = [NSArray arrayWithObjects: SINGLEEXPOSURE, EXPOSURERUN,SUBTRACT, nil];
                    [dropdownTable initialiseDataSource:expModeArray with:selectedExpMode];
                    //selectedExpMode     = SINGLEEXPOSURE;
                    selectedArray= [ NSArray arrayWithArray:expModeArray];
                    
                }
                
#endif
               
            break;
            case EXPPULSES:
#ifdef RUUD_COMMENTS
                
                if([selectedExpMode isEqual:SINGLEEXPOSURE])
                {
                    expPulseArray = [NSArray arrayWithObjects:HYPHEN,nil];
                    [dropdownTable initialiseDataSource:expPulseArray with:selectedExpPulse];
                    selectedExpPulse     = HYPHEN;
                    expPulseButton.hidden=YES;
                    pulseHyphenLabel.hidden=NO;
                    selectedArray= [ NSArray arrayWithArray:expPulseArray];
                }
                else if(([procedureType  isEqual: SKELETON] ||
                         [procedureType  isEqual: UROLOGY] ||
                         [procedureType  isEqual: ENDOSCOPY] ||
                         [procedureType  isEqual: CARDIO] )
                          && [selectedExpMode isEqual:EXPOSURERUN])
                {
                    expPulseArray = [NSArray arrayWithObjects:FOURPERSEC, EIGHTPERSEC, FIFTEENPERSEC,nil];
                    [dropdownTable initialiseDataSource:expPulseArray with:selectedExpPulse];
                    selectedArray= [ NSArray arrayWithArray:expPulseArray];
                }
                else if([procedureType  isEqual: VASCULAR]  && ![selectedExpMode  isEqual:SINGLEEXPOSURE])
                {
                    expPulseArray = [NSArray arrayWithObjects:TWOPERSEC, FOURPERSEC,EIGHTPERSEC, nil];
                    [dropdownTable initialiseDataSource:expPulseArray with:selectedExpPulse];
                   // selectedExpPulse     = TWOPERSEC;
                    selectedArray= [ NSArray arrayWithArray:expPulseArray];
                }
                else if([procedureType  isEqual: PAIN]  &&
                          ([selectedExpMode  isEqual:EXPOSURERUN] ||
                            [selectedExpMode  isEqual:SUBTRACT])
                           )
                  {
                      expPulseArray = [NSArray arrayWithObjects:TWOPERSEC, FOURPERSEC,EIGHTPERSEC, nil];
                      [dropdownTable initialiseDataSource:expPulseArray with:selectedExpPulse];
                    //  selectedExpPulse     = TWOPERSEC;
                      selectedArray= [ NSArray arrayWithArray:expPulseArray];
                  }
                [expPulseButton setTitle:selectedExpPulse forState:UIControlStateNormal];
                
#endif
                break;
                
            default:
                break;
        }
        buttonSelected = button.tag;
        dropdownTable.delegate=dropdownTable;
        dropdownTable.dataSource=dropdownTable;
        dropdownTable.dropdowndelegate=self;

        [comment_cell.viewForBottomSection addSubview:dropdownTable];
        CGRect frame = dropdownTable.frame ;
        [self expandTable:frame withSelectedArrayCount:selectedArray.count];
    }
    else
    {
        CGRect frame = dropdownTable.frame ;
        [self collapseTable:frame rowNumber:-1] ;
    }
}

-(void)reduceBlur:(UIButton *)sender
{
    if (self.blurButtonCLicked ==YES) {
        blurButton.layer.cornerRadius = 2;
        blurButton.layer.borderWidth  = 1;
        blurButton.layer.borderColor  = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.blurButtonCLicked =NO;
        [self deActivateButton:noiseButton];
        self.noiseButtonCLicked = YES;
        [blurButton setBackgroundImage:[UIImage imageNamed:@"Reduce_Blur_Yellow.png"] forState:UIControlStateNormal];
        [noiseButton setBackgroundImage:[UIImage imageNamed:@"reduce_Noise_1.png"] forState:UIControlStateNormal];
        
    }else{
        blurButton.layer.cornerRadius = 2;
        blurButton.layer.borderWidth  = 1;
        blurButton.layer.borderColor  = [UIColor clearColor].CGColor;
        self.blurButtonCLicked =YES;
        [blurButton setBackgroundImage:[UIImage imageNamed:@"Reduce_Blur_1.png"] forState:UIControlStateNormal];
    }
}

-(void)reduceNoise:(UIButton *)sender
{
    if (self.noiseButtonCLicked ==YES) {
        noiseButton.layer.cornerRadius = 2;
        noiseButton.layer.borderWidth  = 1;
        noiseButton.layer.borderColor  = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.noiseButtonCLicked =NO;
        [self deActivateButton:blurButton];
        self.blurButtonCLicked = YES;
        [noiseButton setBackgroundImage:[UIImage imageNamed:@"reduce_Noise_Yellow.png"] forState:UIControlStateNormal];
        [blurButton setBackgroundImage:[UIImage imageNamed:@"Reduce_Blur_1.png"] forState:UIControlStateNormal];
    }else{
        noiseButton.layer.cornerRadius = 2;
        noiseButton.layer.borderWidth  = 1;
        noiseButton.layer.borderColor  = [UIColor clearColor].CGColor;
        self.noiseButtonCLicked =YES;
        [noiseButton setBackgroundImage:[UIImage imageNamed:@"reduce_Noise_1.png"] forState:UIControlStateNormal];
    }
}


-(void)deActivateButton:(UIButton *)btn
{
    btn.layer.cornerRadius = 2;
    btn.layer.borderWidth  = 1;
    btn.layer.borderColor  = [UIColor blackColor].CGColor;
}

-(void)expandTable:(CGRect) frame withSelectedArrayCount:(int)count
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    NSInteger height = 32;
    NSLog(@"Anil Count %d",count);
    frame.size.height=height*count;
    NSLog(@"frame.size.height %f",frame.size.height);
    dropdownTable.frame=frame;
    [UIView commitAnimations];
}

-(void)collapseTable:(CGRect) frame rowNumber:(int)row
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    frame.size.height=0;
    dropdownTable.frame=frame;
    [UIView commitAnimations];
    
    dropdownTable=nil;
    
    if (row!=-1) {
        
        switch (buttonSelected) {
            case MODE:
            {
                selectedFluoroMode = [modeArray objectAtIndex:row];
                [modeButton setTitle:selectedFluoroMode forState:UIControlStateNormal];
                if([selectedFluoroMode isEqual:ROADMAP])
                {
                     selectedExpMode = TRACE;
                    if(defaultExpModeChanged)
                    {
                        selectedExpPulse = PreviousExpPulseVal;
                    }
                }
                else if ([selectedFluoroMode isEqual:FLUORO])
                {
                    selectedExpMode = SUBTRACT;
                    if(defaultExpModeChanged)
                    {
                        selectedExpPulse = PreviousExpPulseVal;
                    }
                }
                [self.standuiView ChangeFluoroMode:selectedFluoroMode];
                [self.standuiView ChangeExposureMode:selectedExpMode];
            }
                break;
            case DOSE:
                selectedDose = [doseArray objectAtIndex:row];
                [doseButton setTitle:selectedDose forState:UIControlStateNormal];
                break;
            case PULSES:
                selectedPulses = [pulsesArray objectAtIndex:row];
                [pulsesButton setTitle:selectedPulses forState:UIControlStateNormal];
                break;
            case STORE:
                selectedFluroStore = [storeArray objectAtIndex:row];
                [storeButton setTitle:selectedFluroStore forState:UIControlStateNormal];
                break;
            case EXPMODE:
                 if (! [selectedExpMode isEqual:[expModeArray objectAtIndex:row]])
                 {
                     if(!([selectedExpMode isEqual:SINGLEEXPOSURE]  || [[expModeArray objectAtIndex:row]  isEqual:SINGLEEXPOSURE] ))
                     {
                         defaultExpModeChanged = 1;
                         PreviousExpPulseVal = selectedExpPulse;
                         PreviousFluoroPulseVal = selectedPulses;
                     }
                     else if([PreviousExpPulseVal isEqual:@""] )
                     {
                         defaultExpModeChanged = 0;
                         PreviousExpPulseVal = selectedExpPulse;
                         PreviousFluoroPulseVal = selectedPulses;
                     }
                     else
                     {
                         defaultExpModeChanged = 1;
                         if(![selectedExpPulse isEqual:HYPHEN])
                         {
                             PreviousExpPulseVal = selectedExpPulse;
                         }
                     }
                 }
                selectedExpMode = [expModeArray objectAtIndex:row];
                [expModeButton setTitle:selectedExpMode forState:UIControlStateNormal];
                if(row == 0){
                    selectedExpStore = [expStoreArray objectAtIndex:0];
                }
                else {
                    selectedExpStore = [expStoreArray objectAtIndex:1];
                }
                [Expstorelabel setText: selectedExpStore];
                
                if([procedureType  isEqual: VASCULAR])
                {
                    defaultVascularModeChanged = 1;
                }
                else if([procedureType  isEqual:SKELETON ])
                {
                    defaultSkeletonModeChanged = 1;
                }
                else if([procedureType  isEqual:UROLOGY ])
                {
                    defaultUrologynModeChanged = 1;
                }
                else if ([procedureType  isEqual:ENDOSCOPY ])
                {
                    defaultEndoscopyModeChanged = 1;
                }
                else if ([procedureType  isEqual:PAIN ])
                {
                    defaultPainModeChanged = 1;
                }
                else if ([procedureType  isEqual:CARDIO ])
                {
                    defaultCardioModeChanged = 1;
                }
                if ([ selectedExpMode isEqual:SINGLEEXPOSURE] ) {
                    selectedExpPulse = HYPHEN;
                    expPulseButton.hidden = YES;
                    pulseHyphenLabel.hidden=NO;
                }
                else
                {
                    expPulseButton.hidden = NO;
                    pulseHyphenLabel.hidden=YES;
                }
                if([selectedExpMode isEqual:EXPOSURERUN] ||  [selectedExpMode isEqual:SUBTRACT] ||  [selectedExpMode isEqual:TRACE] )
                {
                    selectedExpStore = STOREALL;
                }
                if([procedureType  isEqual: VASCULAR] && [ selectedExpMode isEqual:TRACE])
                {
                    selectedFluoroMode = ROADMAP;
                }
                else if([procedureType  isEqual: VASCULAR] && ![ selectedExpMode isEqual:TRACE])
                {
                    selectedFluoroMode = FLUORO;
                }
                
                if(!defaultExpModeChanged  )
                {
                    if(([procedureType  isEqual: SKELETON] ||
                        [procedureType  isEqual: UROLOGY] ||
                        [procedureType  isEqual: ENDOSCOPY] ||
                        [procedureType  isEqual: CARDIO] )
                       && [selectedExpMode isEqual:EXPOSURERUN] )
                    {
                        selectedExpPulse = FOURPERSEC;
                    }
                    else if([procedureType  isEqual: VASCULAR] && ![ selectedExpMode isEqual:SINGLEEXPOSURE])
                    {
                        selectedExpPulse = TWOPERSEC;
                    }
                    else if([procedureType isEqual:PAIN]  &&
                            ([selectedExpMode isEqual:EXPOSURERUN] ||
                             [selectedExpMode isEqual:SUBTRACT]))
                    {
                        selectedExpPulse = TWOPERSEC;
                    }
                }
                else
                {
                     if ([ selectedExpMode isEqual:SINGLEEXPOSURE] )
                     {
                         selectedExpPulse = HYPHEN;
                     }
                    else
                    {
                        selectedExpPulse = PreviousExpPulseVal;
                    }
                }
                [expPulseButton setTitle:selectedExpPulse forState:UIControlStateNormal];
                [self.standuiView ChangeExposureMode:selectedExpMode];
                [self.standuiView ChangeFluoroMode:selectedFluoroMode];
                break;
            case EXPPULSES:
                defaultExpPulseChanged = 1;
                selectedExpPulse =[expPulseArray objectAtIndex:row];
                [expPulseButton setTitle:selectedExpPulse forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        fluoroCellTytle = [NSString stringWithFormat:@"%@\n%@ %@", selectedFluoroMode,selectedPulses,selectedFluroStore];
        expCellTytle = [NSString stringWithFormat:@"%@\n%@ %@", selectedExpMode,selectedExpPulse, selectedExpStore];
        
        NSLog(@"Floroscopy %@ \n Exp %@",fluoroCellTytle,expCellTytle);
        for(int i=1;i<=2;i++)
        {
            NSIndexPath *myIP = [ NSIndexPath indexPathForRow:i inSection:0] ;
            [self updateHeader:myIP];
        }
    }
}

-(NSInteger)customizeNumberOfRowsInSection:(NSInteger)section
{
    return 3;
    
   
    
}


- (void) customizeCollapsedCell: (CommentTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.commentTextLabel.textColor = [UIColor whiteColor];
    cell.subCommentTextLabel.textColor = [UIColor whiteColor];
    
    if (celltitle)
    {
        [self.dashboardTable.tableCellViewLabels replaceObjectAtIndex:indexPath.row withObject:celltitle];
        celltitle=nil ;
    }
}

- (CGFloat) customizeHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( self.standuiView.xrayOff )
    {
        if (indexPath.row==0) {
            return 20+20;
        }
        else if(indexPath.row==1)
        {
            return 300+23;
        }
        else
            return 210.0 + 23;
    }
    else
    {
        return 20+20;
    }
}

- (void)customizeDidSelectCollapsedRowAtIndexPath:(NSIndexPath *)indexPath
{
  // UITableViewCell *cell = [self.dashboardTable cellForRowAtIndexPath:indexPath];
    
    
////    CommentTableCell *cell = (CommentTableCell *)[self.dashboardTable cellForRowAtIndexPath:indexPath];
//    cell.commentTextLabel.text=_title ;
//    [self.dashboardTable reloadInputViews];
    
     }
- (void)customizeDidSelectExpandedRowAtIndexPath:(NSIndexPath *)indexPath
{
    path=indexPath ;

}
- (void)customizeDidSelectExpandedRowAtIndexPath:(CommentTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
      if (indexPath.row==0) {
      [self updateExaminationHaderCellsImage:cell];
      }
}


-(void)updateExaminationHaderCellsImage:(CommentTableCell *)cell {
    CGRect frame = cell.leftImage.frame;
    
    if([anatomyType isEqual:PROCEDUREELECTROPHYSIOLOGY] ||
       [anatomyType isEqual:PROCEDUREPACEMAKER] )
    {
        frame.origin.x = 145;//cell.toggleImage.frame.origin.x-50;
        frame.size.width=60;
        frame.origin.y=0;
        frame.size.height= 38;
    }
    else if ([anatomyType isEqual:PROCEDURELITHOTRIPSY])
    {
        frame.origin.x = 165;
        frame.size.width=35;
        frame.origin.y=0;
        frame.size.height= 40;
    }
    else if( [procedureType isEqual:UROLOGY] ||
            [anatomyType isEqual:PROCEDURECORONARIES] ||
            [anatomyType isEqual:PROCEDUREVENTRICLES] ||
            [anatomyType isEqual:SKELETONPROCEDURESKULL] ||
            [anatomyType isEqual:VASCULARPROCEDUREAORTA] ||
            [anatomyType isEqual:VASCULARPROCEDURECEREBRAL] ||
            [anatomyType isEqual:PROCEDUREBRONCHUS] )
    {
        frame.origin.x = 165;
        frame.size.width=30;
        frame.origin.y=0;
        frame.size.height= 38;
    }
    else if(  [anatomyType isEqual:PROCEDUREOESOPHAGUS])
    {
        frame.origin.x = 180;
        frame.size.width=20;
        frame.origin.y=0;
        frame.size.height= 38;
    }
    else
    {
        frame.origin.x =  165;//cell.toggleImage.frame.origin.x-30;
        frame.origin.y=0;
        frame.size.height= 38;
        frame.size.width= 40;
    }
    cell.leftImage.frame=frame ;
    cell.leftImage.image=[UIImage imageNamed:anatomyType];
}

-(void)createCollinator
{
    UIImage *image = [UIImage imageNamed:@"Collinator.png"];
    
    self.collinator = [[UIImageView alloc]initWithImage:image];
   // self.collinator.center=CGPointMake(self.view.bounds.size.width/2+47,400);
    
    self.collinator.layer.borderWidth =1.0 ;
    self.collinator.layer.borderColor=[[UIColor grayColor]CGColor];
    self.collinator.layer.cornerRadius=5.0;
    
    self.collinator.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(-30), 0.0, 0.0, 1.0);
    
    [self.view addSubview:self.collinator];
    
    [self.view bringSubviewToFront:self.collinator];
    
    _count1=-30 ;
    
}

-(void)ExaminationTypeSelComplete:(NSString*)proceduretype :(NSString*)detailedprocedureSelected :(NSString*)anatomyyype
{
    procedureType = proceduretype;
    anatomyType = anatomyyype ;
    detailedProcedureType = detailedprocedureSelected;
    
    NSLog(@"Procedure Type %@    \t AnatomyType%@",procedureType,anatomyType);
    
    examinationTypeSelView.hidden=YES;
    
    if (!self.standuiView.leftcropImageview.hidden)
    {
          self.collinator.hidden=NO;
    }
    else
    {
        self.collinator.hidden=YES ;
    }
  
    NSIndexPath *indexZero =[NSIndexPath indexPathForRow:0 inSection:0];
    
    CommentTableCell *cell =(CommentTableCell *)[self.dashboardTable cellForRowAtIndexPath:indexZero];
    if (proceduretype!=nil) {
        
        NSString  *examTypeSelCell = [NSString stringWithFormat:@"%@\n%@", procedureType,detailedProcedureType];
        cell.commentTextLabel.text=examTypeSelCell;
        
        [self.dashboardTable.tableCellViewLabels replaceObjectAtIndex:0 withObject:cell.commentTextLabel.text];
        if([proceduretype isEqual:VASCULAR])
        {
            selectedExpMode     =   SUBTRACT;
            selectedExpPulse    =   TWOPERSEC;
            selectedExpStore    =   EXPSTOREALL;
            selectedFluoroMode  =   FLUORO;
        }
        else if([proceduretype isEqual:SKELETON])
        {
            selectedFluoroMode  =   FLUORO;
            selectedExpMode     =   SINGLEEXPOSURE;
            selectedExpPulse    =   HYPHEN;
            selectedExpStore    =   LIH;
        }
        else if([proceduretype isEqual:CARDIO])
        {
            selectedFluoroMode  =   FLUORO;
            selectedExpMode     =   EXPOSURERUN;
            selectedExpPulse    =   FOURPERSEC;
            selectedExpStore    =   STOREALL;
        }
        else if([proceduretype isEqual:ENDOSCOPY] || [proceduretype isEqual:UROLOGY]  )
        {
            selectedFluoroMode  =   FLUORO;
            selectedExpPulse    =   HYPHEN;
            selectedExpStore    =   LIH;
            selectedExpMode     =   SINGLEEXPOSURE;
        }
        else if([proceduretype isEqual:PAIN])
        {
            selectedFluoroMode  =   FLUORO;
            selectedExpPulse    =   HYPHEN;
            selectedExpStore    =   LIH;
            selectedExpMode     =   SINGLEEXPOSURE;
        }
        defaultExpModeChanged = 0;
        defaultExpPulseChanged = 0;
        PreviousExpPulseVal = @"";
        PreviousFluoroPulseVal = @"";
        [self.standuiView ChangeFluoroMode:selectedFluoroMode];
        [self.standuiView ChangeExposureMode:selectedExpMode];
        
        for(int i=1;i<=2;i++)
        {
            NSIndexPath *myIP = [ NSIndexPath indexPathForRow:i inSection:0] ;
            [self updateHeader:myIP];
        }
    }
    if (anatomyType!=nil) {
        [self updateExaminationHaderCellsImage:cell];
        cell.leftImage.image=[UIImage imageNamed:anatomyType];
            
    }
    [self UpdateXRayImage];
    [self.standuiView Hide_UnhideNavigationToolbar:NO];
}

-(void)updateHeader:(NSIndexPath*)pathIdx
{
    fluoroCellTytle = [NSString stringWithFormat:@"%@\n%@ %@", selectedFluoroMode,selectedPulses,selectedFluroStore];
    
    if( [selectedExpPulse isEqual:HYPHEN])
    {
    expCellTytle = [NSString stringWithFormat:@"%@\n%@", selectedExpMode, selectedExpStore];
    }
    else
    {
    expCellTytle = [NSString stringWithFormat:@"%@\n%@ %@", selectedExpMode,selectedExpPulse, selectedExpStore];
    }
    
    NSLog(@"Floroscopy %@ \n Exp %@",fluoroCellTytle,expCellTytle);
    
    CommentTableCell *cell = (CommentTableCell *)[self.dashboardTable cellForRowAtIndexPath:pathIdx];
    
    if( pathIdx.row == 1)
    {
        cell.commentTextLabel.text=fluoroCellTytle;
        [cellNames replaceObjectAtIndex:1 withObject:fluoroCellTytle];
    }
    if( pathIdx.row == 2)
    {
        cell.commentTextLabel.text=expCellTytle;
        [cellNames replaceObjectAtIndex:2 withObject:expCellTytle];
    }
}

-(void)UpdateXRayImage
{
    if ([procedureType isEqual:SKELETON])
    {
        self.standuiView.examinationType = SKELETONVIEW;
    }
    else if([procedureType isEqual:VASCULAR] )
    {
        self.standuiView.examinationType = VASCULARVIEW;
    }
    else
    {
        self.standuiView.examinationType =PAINVIEW;
    }
}

- (IBAction)zoomButtonCLicked:(id)sender
{
    if (self.zoomButtonCLicked ==YES) {
        zoomButton.layer.cornerRadius = 2;
        zoomButton.layer.borderWidth  = 1;
        zoomButton.layer.borderColor  = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.zoomButtonCLicked =NO;

    }else{
        zoomButton.layer.cornerRadius = 2;
        zoomButton.layer.borderWidth  = 1;
        zoomButton.layer.borderColor  = [UIColor clearColor].CGColor;
        self.zoomButtonCLicked =YES;
        [zoomButton setBackgroundImage:[UIImage imageNamed:@"detectorZoom.png"] forState:UIControlStateNormal];
    }
      if(state==1)
      {
           [zoomButton setBackgroundImage:[UIImage imageNamed:@"Detector_Zoom_Yellow_1.png"] forState:UIControlStateNormal];
          self.zoomImage.frame = CGRectMake(56, 8, 38 ,38);
          [zoomButton addSubview:self.zoomImage];

          zoomButton.layer.cornerRadius = 2;
          zoomButton.layer.borderWidth  = 1;
          zoomButton.layer.borderColor  = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
          self.zoomButtonCLicked =NO;
          state=2;
      }
    else
        if(state==2)
    {
        zoomButton.layer.cornerRadius = 2;
        zoomButton.layer.borderWidth  = 1;
        zoomButton.layer.borderColor  = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.zoomButtonCLicked =NO;
        [zoomButton setBackgroundImage:[UIImage imageNamed:@"Detector_Zoom_Yellow_2.png"] forState:UIControlStateNormal];
        state=0;
    }
    else
    {
        [self.zoomImage removeFromSuperview];
        state=1;

    }
}

- (IBAction)detectorButtonCLicked:(id)sender
{
    if (self.detectorButtonCLicked==YES) {
        detectorButton.layer.cornerRadius = 2;
        detectorButton.layer.borderWidth = 1;
        detectorButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.detectorButtonCLicked=NO;
         [detectorButton setBackgroundImage:[UIImage imageNamed:@"Detector_Laser_Yellow.png"] forState:UIControlStateNormal];
    }
    else
    {
        detectorButton.layer.cornerRadius = 2;
        detectorButton.layer.borderWidth = 1;
        detectorButton.layer.borderColor = [UIColor clearColor].CGColor;
        self.detectorButtonCLicked=YES;
         [detectorButton setBackgroundImage:[UIImage imageNamed:@"Detecctor_Laser_1.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)tubeButtonCLicked:(id)sender
{
    if (self.tubeButtonCLicked==YES) {
        tubeButton.layer.cornerRadius = 2;
        tubeButton.layer.borderWidth = 1;
        tubeButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.tubeButtonCLicked=NO;
        [tubeButton setBackgroundImage:[UIImage imageNamed:@"Tube_Laser_Yellow.png"] forState:UIControlStateNormal];
    }
     else{
         tubeButton.layer.cornerRadius = 2;
         tubeButton.layer.borderWidth = 1;
         tubeButton.layer.borderColor = [UIColor clearColor].CGColor;
         self.tubeButtonCLicked=YES;
         [tubeButton setBackgroundImage:[UIImage imageNamed:@"Tube_Laser_1.png"] forState:UIControlStateNormal];
     }
}

- (IBAction)kvManualButtonCLicked:(id)sender
{
    if (self.kvManualButtonCLicked==YES) {
        [kvManualView setHidden:NO];
        kvManualButton.layer.cornerRadius = 2;
        kvManualButton.layer.borderWidth = 1;
        kvManualButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.kvManualButtonCLicked=NO;
        [kvManualButton setBackgroundImage:[UIImage imageNamed:@"KV_Manual_Yellow.png"] forState:UIControlStateNormal];
    }
    else{
        [kvManualView setHidden:YES];
        kvManualButton.layer.cornerRadius = 2;
        kvManualButton.layer.borderWidth = 1;
        kvManualButton.layer.borderColor = [UIColor clearColor].CGColor;
        self.kvManualButtonCLicked=YES;
        [kvManualButton setBackgroundImage:[UIImage imageNamed:@"KV_Manual_1.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)positionMemoryButtonCLicked:(id)sender
{
    if (self.positionMemoryButtonCLicked == YES)
    {
        [self CreatePositionMemoryView];
        posMemView.hidden=NO;
        positionMemoryButton.layer.cornerRadius = 2;
        positionMemoryButton.layer.borderWidth = 1;
        positionMemoryButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.positionMemoryButtonCLicked=NO;
        [positionMemoryButton setBackgroundImage:[UIImage imageNamed:@"Position_Memory_Yellow.png"] forState:UIControlStateNormal];
    }
    else
    {
        [posMemView setHidden:YES];
        positionMemoryButton.layer.cornerRadius = 2;
        positionMemoryButton.layer.borderWidth = 1;
        positionMemoryButton.layer.borderColor = [UIColor clearColor].CGColor;
        self.positionMemoryButtonCLicked = YES;
        [positionMemoryButton setBackgroundImage:[UIImage imageNamed:@"Position_Memory_1.png"] forState:UIControlStateNormal];
    }
}

-(void)CreatePositionMemoryView
{
    if(posMemView==nil)
    {
        CGRect posMemFrame = CGRectMake( 240, 20, 640, 560 );
        posMemView =  [[[NSBundle mainBundle] loadNibNamed:@"PositionMemory" owner:self options:nil] firstObject];
        posMemView.frame =posMemFrame;
        [posMemView initPositionMemoryView];
        [self.view addSubview:posMemView];
        [posMemView setHidden:YES];
    }
}

-(IBAction)newExamBtnTapped:(id)sender
{
    self.detectorButtonCLicked = NO;
    [self detectorButtonCLicked:nil];
   
    self.kvManualButtonCLicked = NO;
    [self kvManualButtonCLicked:nil];
   
    self.tubeButtonCLicked=NO;
    [self tubeButtonCLicked:nil];
    
    self.zoomButtonCLicked =NO;
    state=0;
    [self zoomButtonCLicked:nil];
    
    self.blurButtonCLicked = NO;
    [self reduceBlur:nil];
    
    self.noiseButtonCLicked=NO;
    [self reduceNoise:nil];
    
    self.positionMemoryButtonCLicked=NO;
    [self positionMemoryButtonCLicked:nil];
    
    
    defaultVascularModeChanged = 0;
    defaultSkeletonModeChanged = 0;
    defaultUrologynModeChanged = 0;
    defaultEndoscopyModeChanged = 0;
    defaultPainModeChanged = 0;
    defaultCardioModeChanged = 0;
    defaultExpModeChanged = 0;
    defaultExpPulseChanged = 0;
    PreviousExpPulseVal = @"";
    PreviousFluoroPulseVal = @"";
    
    // Reset Contrast Brightness slider
    contrastSlider.value = CONTRASTSLIDEMIN;
    [self sliderValueChanged:nil];
    if(AutoBtn)
    {
        [self AutoButtonTapped:nil];
    }
    if(contrastView.hidden == NO)
    {
        [self ContrastButtonTapped:nil];
    }
    
    
}

-(void)standuiComponentsAtPoint:(CGPoint)nowPoint5
{
    
    for (UIView *subview in [self.view subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
        
        
        if (subview.tag==250 && CGRectContainsPoint(subview.frame, nowPoint5) && !self.collinator.hidden)
        {
            
            UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x, subview.center.y, 200, 50)];
            
            popupview.layer.cornerRadius=4.0 ;
            
            NSString *string= @"Drag to change collinator aperture" ;
            //  CGSize maxSize = CGSizeMake(300, CGFLOAT_MAX); //250 is max desired width
            
            
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"Gill Sans" size:12];
            
            
            popupview.tag=300 ;
            
            [popupview addSubview:label];
            
            label.text = string ;
            
            // CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
            CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
            
            popupview.backgroundColor=[UIColor blackColor];
            
            popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
            
            
            
            label.frame=CGRectMake(0+10, 0, textSize.width, 50);
            popupview.frame=CGRectMake(subview.center.x, subview.center.y-textSize.height, textSize.width+20, 50);
            popupview.center = CGPointMake(subview.center.x, subview.center.y);
            
            [self.view addSubview:popupview];
            
            
        }
    }
}

-(void)previousViewsfromSuperView
{
    for (UIView *subview in [self.standuiView.topviewpanel subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
            
        }
    }
    
    for (UIView *subview in [self.standuiView.rightPanel subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }
    
    for (UIView *subview in [self.standuiView subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }

    
}

-(void)leftsidePanelComponentsAtPoint:(CGPoint)nowPoint
{
    for(UIView *subview in [self.LeftSidePanel subviews])
    {
        
        
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
        
        
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint))
        {
            
            for (UIView *subview in [self.view subviews])
            {
                if (subview.tag==300)
                {
                    [subview removeFromSuperview];
                }
            }
            
            NSLog(@"the content is %@",[self.standuiView.leftpanelbuttonInfoList objectAtIndex:subview.tag-100]);
            
            NSString *string =[self.standuiView.leftpanelbuttonInfoList objectAtIndex:subview.tag-100] ;
            
            UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x, subview.center.y, 200, 50)];
            popupview.backgroundColor=[UIColor grayColor];
            // popupview.layer.borderColor=[[UIColor whiteColor]CGColor];
            popupview.layer.cornerRadius=4.0 ;
            //  popupview.layer.borderWidth=1.0 ;
            
            
            
            //  CGSize maxSize = CGSizeMake(400, CGFLOAT_MAX); //250 is max desired width
            
            
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
            label.textColor=[UIColor whiteColor];
            
            popupview.tag=300 ;
            
            [popupview addSubview:label];
            
            label.text = string ;
            label.font=[UIFont fontWithName:@"Gill Sans" size:12];
            
            //   CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
            CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
            
            label.frame=CGRectMake(0+10, 0, textSize.width, 50);
            popupview.frame=CGRectMake(subview.center.x, subview.center.y, textSize.width+20, 50);
            
            popupview.backgroundColor=[UIColor blackColor];
            
            popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
            
            [self.view addSubview:popupview];
            
            
        }
        
    }
}

-(void)rightsidePanelComponentsAtPoint:(CGPoint)nowPoint2
{
    for(UIView *subview in [self.standuiView.rightPanel subviews])
    {
        
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint2) && subview.tag>=200)
        {
            
            for (UIView *subview in [self.standuiView.rightPanel subviews])
            {
                if (subview.tag==300)
                {
                    [subview removeFromSuperview];
                }
            }
            
            NSLog(@"subview tag value is %d",subview.tag) ;
            
            if (self.standuiView.OverviewSelected)
            {
                
                self.standuiView.rightpanelbuttonInfoList = [[NSArray alloc]initWithObjects:@"Copy the current image to ref monitor",@"Copy image from ref monitor to the examination monitor",@"Change the Contrast Brightness",@"Flag(Protect and store) current image run",@"Display all images of the examination",@"Display one image per run",@"Flip the image up/down",@"Couple Shutters movement",@"Reset shutters and collimator to default position",nil]  ;
                
                
            }
            
            else
            {
                
                
                self.standuiView.rightpanelbuttonInfoList = [[NSArray alloc]initWithObjects:@"Automatically Position shutters",@"Copy the current image to ref monitor",@"Copy image from ref monitor to the examination monitor ",@"Change the Contrast Brightness",@"Flag(Protect and store) current image run",@"Mirror the image left/right",@"Flip the image up/down",@"Couple Shutters movement",@"Reset shutters and collimator to default position",nil]  ;
                
                
            }
            
            
            NSLog(@"the content is %@",[self.standuiView.rightpanelbuttonInfoList objectAtIndex:subview.tag-200]);
            
            NSString *string =[self.standuiView.rightpanelbuttonInfoList objectAtIndex:subview.tag-200] ;
            
            UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x-3*subview.bounds.size.width, subview.center.y, 200, 50)];
            popupview.backgroundColor=[UIColor grayColor];
            // popupview.layer.borderColor=[[UIColor whiteColor]CGColor];
            popupview.layer.cornerRadius=4.0 ;
            // popupview.layer.borderWidth=1.0 ;
            
            
            
            //  CGSize maxSize = CGSizeMake(350, CGFLOAT_MAX); //250 is max desired width
            
            
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"Gill Sans" size:12];
            
            popupview.tag=300 ;
            
            [popupview addSubview:label];
            
            label.text = string ;
            
            //  CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
            CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
            popupview.backgroundColor=[UIColor blackColor];
            
            popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
            
            label.frame=CGRectMake(0+10, 0, textSize.width, 50);
            popupview.frame=CGRectMake(subview.center.x-textSize.width, subview.center.y-20, textSize.width+20, 50);
            
            
            [self.standuiView.rightPanel addSubview:popupview];
            
            
        }
        
    }

    
}

-(void)mainviewComponentsAtPoint:(CGPoint)nowPoint3
{
    for (UIView *subview in [self.standuiView.imageNavigationtoolbar subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }
    
    for(UIView *subview in [self.standuiView subviews])
    {
        
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint3) && subview.tag>=400 && !subview.hidden)
        {
            
            for (UIView *subview in [self.standuiView subviews])
            {
                if (subview.tag==300)
                {
                    [subview removeFromSuperview];
                }
            }
            
            NSLog(@"subview tag value is %d",subview.tag) ;
            
            NSLog(@"the content is %@",[self.standuiView.standUIpanelbuttonInfoList objectAtIndex:subview.tag-400]);
            
            NSString *string =[self.standuiView.standUIpanelbuttonInfoList objectAtIndex:subview.tag-400] ;
            
            UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x, subview.center.y, 200, 50)];
            popupview.backgroundColor=[UIColor grayColor];
            // popupview.layer.borderColor=[[UIColor whiteColor]CGColor];
            popupview.layer.cornerRadius=4.0 ;
            //  popupview.layer.borderWidth=1.0 ;
            
            
            
            // CGSize maxSize = CGSizeMake(300, CGFLOAT_MAX); //250 is max desired width
            
            
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"Gill Sans" size:12];
            
            
            popupview.tag=300 ;
            
            [popupview addSubview:label];
            
            label.text = string ;
            
            //   CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
            CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
            
            popupview.backgroundColor=[UIColor blackColor];
            
            popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
            
            
            
            label.frame=CGRectMake(0+10, 0, textSize.width, 50);
            popupview.frame=CGRectMake(subview.center.x, subview.center.y-textSize.height, textSize.width+20, 50);
            popupview.center = CGPointMake(subview.center.x, subview.center.y);
            
            
            
            [self.standuiView addSubview:popupview];
            
            popupview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS( self.standuiView.standuiCumulativeAngle), 0.0, 0.0, 1.0);
            if (self.standuiView.flipisON)
            {
                popupview.layer.transform=CATransform3DRotate(popupview.layer.transform,self.standuiView.flipAngle, 1.0, 0.0, 0.0);
            }
            
            if (self.standuiView.mirrorisON)
            {
                popupview.layer.transform = CATransform3DRotate(popupview.layer.transform,self.standuiView.mirrorAngle, 0.0, 1.0, 0.0) ;
            }
            
        }
        
        
    }

    
}


-(void)imageNavigationTollbarComponentsAtPOint:(CGPoint)nowPoint4
{
    for (UIView *subview in [self.standuiView.imageNavigationtoolbar subviews])
    {
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint4) && subview.tag>=600 && !subview.hidden)
        {
            for (UIView *subview in [self.standuiView.imageNavigationtoolbar subviews])
            {
                if (subview.tag==300)
                {
                    [subview removeFromSuperview];
                }
            }
            
            if (self.standuiView.imageNavigationtoolbar.singleimagepressed)
            {
                [self.standuiView.imageNavigationtollbarList replaceObjectAtIndex:2 withObject:@"Display image overview"];
            }
            
            if (!self.standuiView.imageNavigationtoolbar.singleimagepressed)
            {
                [self.standuiView.imageNavigationtollbarList replaceObjectAtIndex:2 withObject:@"Switch from overview to single image review."];
            }
            
            
            if (self.standuiView.runcycleButtonclicked)
            {
                [self.standuiView.imageNavigationtollbarList replaceObjectAtIndex:1 withObject:@"Pause run cycle and switch to single image review."];
            }
            
            if (!self.standuiView.runcycleButtonclicked)
            {
                [self.standuiView.imageNavigationtollbarList replaceObjectAtIndex:1 withObject:@"View images of a run in a cycle."];
            }
            
            NSLog(@"subview tag value is %d",subview.tag) ;
            
            NSLog(@"the content is %@",[self.standuiView.imageNavigationtollbarList objectAtIndex:subview.tag-600]);
            
            NSString *string =[self.standuiView.imageNavigationtollbarList objectAtIndex:subview.tag-600] ;
            
            UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x, subview.center.y, 200, 50)];
            
            popupview.layer.cornerRadius=4.0 ;
            
            
            // CGSize maxSize = CGSizeMake(300, CGFLOAT_MAX); //250 is max desired width
            
            
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"Gill Sans" size:12];
            
            
            popupview.tag=300 ;
            
            [popupview addSubview:label];
            
            label.text = string ;
            
            //  CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
            CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
            
            popupview.backgroundColor=[UIColor blackColor];
            
            popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
            
            
            
            label.frame=CGRectMake(0+10, 0, textSize.width, 50);
            popupview.frame=CGRectMake(subview.center.x, subview.center.y-textSize.height, textSize.width+20, 50);
            popupview.center = CGPointMake(subview.center.x, subview.center.y-40);
            
            
            
            [self.standuiView.imageNavigationtoolbar addSubview:popupview];
            
            
            
            
            
            
        }
        
    }
    
}

-(void)topviewPanelComponentsAtPoint:(CGPoint)nowPoint6
{
    for (UIView *subview in [self.standuiView.topviewpanel subviews])
    {
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint6) && subview.tag>=700)
        {
            NSString *string =[self.standuiView.TopPanelList objectAtIndex:subview.tag-700] ;
            
            UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x, subview.center.y, 200, 50)];
            
            popupview.layer.cornerRadius=4.0 ;
            
            
            //   CGSize maxSize = CGSizeMake(300, CGFLOAT_MAX); //250 is max desired width
            
            
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"Gill Sans" size:12];
            
            popupview.tag=300 ;
            
            [popupview addSubview:label];
            
            label.text = string ;
            
            // CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
            
            CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
            
            popupview.backgroundColor=[UIColor blackColor];
            
            popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
            
            
            
            label.frame=CGRectMake(0+10, 0, textSize.width, 50);
            popupview.frame=CGRectMake(subview.center.x, subview.center.y+2*textSize.height, textSize.width+20, 50);
            popupview.center = CGPointMake(subview.center.x, subview.center.y+3*textSize.height);
            
            [self.standuiView.topviewpanel addSubview:popupview];
            
            
            
        }
        
        
    }

    
}

-(void)pageNavigationtoolbarComponentsAtPoint:(CGPoint)nowPoint7
{
    
    for (UIView *subview in [self.standuiView.imageNavigationtoolbar.pageNavigationtoolbar subviews])
    {
        
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
        
    }
    
    
    for (UIView *subview in [self.standuiView.imageNavigationtoolbar.pageNavigationtoolbar subviews])
    {
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint7) && subview.tag>=800)
        {
            NSString *string =[self.standuiView.pageControllerList objectAtIndex:subview.tag-800] ;
            
            UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x, subview.center.y, 200, 50)];
            
            popupview.layer.cornerRadius=4.0 ;
            
            
            // CGSize maxSize = CGSizeMake(300, CGFLOAT_MAX); //250 is max desired width
            
            
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"Gill Sans" size:12];
            
            
            popupview.tag=300 ;
            
            [popupview addSubview:label];
            
            label.text = string ;
            
            //   CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
            
            CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
            
            popupview.backgroundColor=[UIColor blackColor];
            
            popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
            
            
            
            label.frame=CGRectMake(0+10, 0, textSize.width, 50);
            popupview.frame=CGRectMake(subview.center.x, subview.center.y+2*textSize.height, textSize.width+20, 50);
            popupview.center = CGPointMake(subview.center.x-1.2*textSize.width, subview.center.y);
            
            
            
            [self.standuiView.imageNavigationtoolbar.pageNavigationtoolbar addSubview:popupview];
            
            
        }
    }

    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.standuiView.questionmarkPressed) {
        
    
    [super touchesBegan:touches withEvent:event];
    CGPoint nowPoint  = [[touches anyObject] locationInView: self.view];
     NSLog(@"TOUCH POINT IS %f %f",nowPoint.x,nowPoint.y);
        
        if (!self.collinator.hidden)
        {
        
    for(UIView *subview in [self.view subviews])
    {
        
        if (subview==self.collinator && self.standuiView.showcollimator==YES)
        {
            if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint) && !self.standuiView.collimatorOverlapped && !self.standuiView.collimatorOverlapped_leftcropView && !self.standuiView.collimatorOverlapped_rightcropView)
            {
                if (!self.standuiView.collimator_leftview && !self.standuiView.collimator_rightview)
                {
                     _collinatorTouched=YES ;
                }
               
                self.collinator.image=[UIImage imageNamed:@"Collinator_yellow.png"];
                 self.collinator.alpha=1.0 ;
                [self.view bringSubviewToFront:self.collinator];
               
            }
            
        }
        
           }
        }//hidden collinator
    }
    
    else
    {
        CGPoint nowPoint   = [[touches anyObject]locationInView:self.LeftSidePanel];
        CGPoint nowPoint2  = [[touches anyObject]locationInView:self.standuiView.rightPanel];
        CGPoint nowPoint3  = [[touches anyObject]locationInView:self.standuiView];
        CGPoint nowPoint4  = [[touches anyObject]locationInView:self.standuiView.imageNavigationtoolbar];
        CGPoint nowPoint5  = [[touches anyObject]locationInView:self.view];
        CGPoint nowPoint6  = [[touches anyObject]locationInView:self.standuiView.topviewpanel] ;
        CGPoint nowPoint7  = [[touches anyObject] locationInView:self.standuiView.imageNavigationtoolbar.pageNavigationtoolbar] ;
        
        
        NSLog(@"TOUCH POINT IS %f %f",nowPoint.x,nowPoint.y);
        
        
        
        [self standuiComponentsAtPoint:nowPoint5];
        [self previousViewsfromSuperView];
        [self leftsidePanelComponentsAtPoint:nowPoint];
        [self rightsidePanelComponentsAtPoint:nowPoint2];
        [self mainviewComponentsAtPoint:nowPoint3];
        [self imageNavigationTollbarComponentsAtPOint:nowPoint4] ;
        [self topviewPanelComponentsAtPoint:nowPoint6];
        [self pageNavigationtoolbarComponentsAtPoint:nowPoint7];
        
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.standuiView.questionmarkPressed) {

    
    [super touchesMoved:touches withEvent:event];
    
    //  UIView *touch = [touches anyObject];
    CGPoint nowPoint  = [[touches anyObject] locationInView: self.view];
    CGPoint previousPoint = [[touches anyObject] previousLocationInView:self.view];
    
    CGPoint centreOfCircle ;
    centreOfCircle.x =547.00;
    centreOfCircle.y =347.5;
       
    
    if (_collinatorTouched) {
        
        
        [self.collinator setExclusiveTouch:NO];
       // _collimatorclicked=YES;
        
        self.standuiView.circleLayer.strokeColor=[[UIColor colorWithRed:249/255.0 green:217/255.0 blue:143.0/255.0 alpha:1.0]CGColor];
        
        self.standuiView.circleLayer.lineWidth=2.0;
        
        //if(previousPoint.y<nowPoint.y)
        {
            
            CGFloat xMove = nowPoint.x - previousPoint.x;
            CGFloat yMove = nowPoint.y - previousPoint.y;
            CGFloat distance = sqrt ((xMove * xMove) + (yMove * yMove));
            CGFloat newRadius;
            if (previousPoint.y<nowPoint.y)
            {
                newRadius=_standuiView.circleRadius-distance ;
            }
            else
            {
                newRadius=_standuiView.circleRadius+distance ;
                
            }
          
            if (newRadius>226.0)
            {
                newRadius=226.0;
                self.collinator.center=CGPointMake(434.0, 121.0);
                
            }
            
            else if (newRadius<90) {
                newRadius=90;
                self.collinator.center=CGPointMake(495.0,242.5);
            }
            else
            {
                
                
                CGFloat slope =[self slopeOFline:self.collinator.center and:centreOfCircle];
                
                CGPoint pointOnCircle ;
                
                CGFloat radius = newRadius+29 ;
                
                 NSLog(@"THE POINTS ARE %f %f",self.collinator.center.x,self.collinator.center.y);
                
                pointOnCircle.y = centreOfCircle.y+((slope*radius)/-sqrt(slope*slope +1))  ;
                
                pointOnCircle.x = centreOfCircle.x+((pointOnCircle.y - centreOfCircle.y)/slope) ;
                
                self.collinator.center=pointOnCircle ;
                
                 NSLog(@"THE POINTS ARE %f %f",self.collinator.center.x,self.collinator.center.y);
           }
            
            
            [_standuiView updateCirclePathAtLocation:_standuiView.circleCenter radius:newRadius];
            
            
        }
        
         
    }
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    if (_collinatorTouched)
    {
        self.standuiView.circleLayer.strokeColor=[[UIColor clearColor]CGColor];
    }
    
    self.standuiView.circleLayer.lineWidth=1.0;
    _collinatorTouched=NO;
    self.collinator.image=[UIImage imageNamed:@"Collinator.png"];
    
    
    if (self.collinator.center.y<124+5)
    {
        [self.view sendSubviewToBack:self.collinator];
        self.collinator.alpha=1.0 ;
        
    }
    
    else
    {
        self.collinator.alpha=0.4 ;
        
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    
}
- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
        {
            CGPoint pointvalue ;
            pointvalue.x=553.0;
            pointvalue.y=342.0;
            _standuiView.center=pointvalue ;
            
        }
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
        {
            CGPoint pointvalue ;
            pointvalue.x=553.0;
            pointvalue.y=342.0;
            _standuiView.center=pointvalue ;
            
        }
            
            break;
            
        default:
        {
            CGPoint pointvalue ;
            pointvalue.x=553.0;
            pointvalue.y=342.0;
            _standuiView.center=pointvalue ;
            
        }
            break;
    };
    
    _standuiView.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(0.0), 0.0, 0.0, 1.0);
    _standuiView.rotate_circle_view.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(0.0), 0.0, 0.0, 1.0);
    
}


#pragma mark - KVMAnual


-(void)MaskButtonlayer:(UIButton*)btn :(UIRectCorner)val
{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds
                                     byRoundingCorners:val
                                           cornerRadii:CGSizeMake(20.0, 3.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = btn.bounds;
    maskLayer.path = maskPath.CGPath;
    btn.layer.mask = maskLayer;
}

-(IBAction)kvManualIncrementButtonCLicked:(id)sender
{
    kvManualValue = (kvManualValue  >=KVMANUALMAX)? KVMANUALMAX :kvManualValue+1;
    NSString *str = [NSString stringWithFormat: @"%d", kvManualValue];
    kvManualLbl.text = str;
    kvManualStatusBarLbl.text = str;
}

-(IBAction)kvManualDecrementButtonCLicked:(id)sender
{
    kvManualValue = (kvManualValue  <=KVMANUALMIN)? KVMANUALMIN :kvManualValue-1;
    NSString *str = [NSString stringWithFormat: @"%d", kvManualValue];
    kvManualLbl.text = str;
    kvManualStatusBarLbl.text = str;
}


-(void)setupTouchButton:(UIButton *)button :(int)tagid
{
    [button addTarget:self action:@selector(handleTouchDownEvent:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(handleTouchReleaseEvent:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tagid;
}

-(void)handleTouchDownEvent:(UIButton *)sender
{
    KVManualActiveButton = sender.tag;
    KVManualTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(ContinueslyChange:) userInfo:Nil repeats:YES];
    sender.backgroundColor = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];
}

-(void)handleTouchReleaseEvent:(UIButton *)sender
{
    if ([KVManualTimer isValid]) {
        [KVManualTimer invalidate];
        KVManualTimer = nil;
    }
    KVManualActiveButton = 0;
    sender.backgroundColor = [UIColor clearColor];
}

-(void)ContinueslyChange:(id)sender
{
    NSLog(@"Value of Active bttons is %d",KVManualActiveButton);
    if( KVManualActiveButton == KVINCREMENT)
    {
        [self kvManualIncrementButtonCLicked:nil];
    }
    else if (KVManualActiveButton == KVDECREMENT )
    {
        [self kvManualDecrementButtonCLicked:nil];
    }
}


-(CGFloat)slopeOFline:(CGPoint)p1 and:(CGPoint)p2
{
    CGFloat slope = (p2.y-p1.y)/(p2.x-p1.x);
    
    NSLog(@"SLOPE %f",slope);
    
    return slope ;
}


- (IBAction)systemButtonTapped:(id)sender
{
    [self CreateSystemView];
}

- (IBAction)HelpButtonTapped:(id)sender
{
   /* self.systemMenu.hidden = NO;
    self.HelpMenu.hidden=NO;
    self.systemMenu.systemMainView.hidden=YES;
    */
    if(HelpView==nil)
    {
        CGRect helpFrame = CGRectMake( 0, 10, 1024, 760 );
        HelpView =  [[[NSBundle mainBundle] loadNibNamed:@"HTMLHelp" owner:self options:nil] firstObject];
        HelpView.frame = helpFrame;
        HelpView.helpDlgDelegate=self;
        [HelpView initHekpView];
        [self.view addSubview:HelpView];
    }
    HelpView.hidden=NO;
    [self.standuiView Hide_UnhideNavigationToolbar:YES];
    //HelpView.backgroundColor=[UIColor clearColor];

}



-(void)HelpViewClosed
{
    [self.standuiView Hide_UnhideNavigationToolbar:NO];
}

-(void)loadQuestionmarkIntoLeftPanel
{
    for (UIButton *subview in [self.LeftSidePanel subviews])
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
            
            
            UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
            
            if (!subview.hidden && self.standuiView.questionmarkPressed)
            {
                [self.LeftSidePanel addSubview:questionmarkVIEW];
                questionmarkVIEW.tag=self.standuiView.tagValueLeftPanel++ ;
                
                questionmarkVIEW.center =subview.center;
                questionmarkVIEW.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(0), 0.0, 0.0, 1.0);
                
                subview.alpha=0.2 ;
                subview.userInteractionEnabled=NO ;
                
                
            }
            
            else if(subview.hidden || !self.standuiView.questionmarkPressed)
            {
                questionmarkVIEW.hidden=YES ;
                
            }
            
            
        }
    }
    

}

-(void)loadQuestionmarksIntoDashBoardTable
{
    for (int i=0; i<3; i++)
    {
        NSIndexPath *index =[NSIndexPath indexPathForRow:i inSection:0];
        
        CommentTableCell *cell =(CommentTableCell *)[_dashboardTable cellForRowAtIndexPath:index];
        
        UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
        
        questionmarkVIEW.tag = 100 ;
        
        [cell.viewForTopSection addSubview:questionmarkVIEW];
        
        questionmarkVIEW.center=cell.viewForTopSection.center ;
        
        cell.commentTextLabel.textColor=[UIColor grayColor];
        cell.toggleImage.alpha=0.4;
        cell.leftImage.alpha=0.4 ;
        
        [cell.viewForTopSection setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.1]];
        
        cell.userInteractionEnabled=NO ;
        
    }
    
    
    for (int i=0; i<3; i++)
    {
        NSIndexPath *index =[NSIndexPath indexPathForRow:i inSection:0];
        
        CommentTableCell *cell =(CommentTableCell *)[_dashboardTable cellForRowAtIndexPath:index];
        
        
        for (UIView *subview in [cell.viewForBottomSection subviews])
        {
            if ([subview isKindOfClass:[UIButton class]])
            {
                UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
                
                questionmarkVIEW.tag = _tagbuttonofBottomsection++ ;
                
                [cell.viewForBottomSection addSubview:questionmarkVIEW];
                
                questionmarkVIEW.center=subview.center ;
                
                [cell.viewForBottomSection setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.1]];
                
                cell.userInteractionEnabled=NO ;
                
            }
        }
        
        
    }

}

-(void)loadQuestionmarks
{
    
    _simulationSuperView.userInteractionEnabled = NO ;
     _tagbuttonofBottomsection =500 ;
    
    _panGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    _panGesture.delegate = self;
    [self.dashboardTable addGestureRecognizer:_panGesture];
    [self loadQuestionmarkIntoLeftPanel] ;
    [self loadQuestionmarksIntoDashBoardTable];
    
    
    if (!self.collinator.hidden)
    {
        UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
        
        questionmarkVIEW.center=self.collinator.center ;
        questionmarkVIEW.tag=250 ;
        
        [self.view addSubview:questionmarkVIEW];
        self.standuiView.showcollimator=YES ;
        self.collinator.alpha=0.4;
    }
    
    
    
  
}

-(void)hideQuestionmarkfromLeftSidePanel
{
    for (UIButton *subview in [self.LeftSidePanel subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            if (subview.tag>=100 && subview.tag<=106)
            {
                [subview removeFromSuperview];
            }
            
            
        }
        
        
        subview.alpha=1.0 ;
        subview.userInteractionEnabled=YES ;
        
    }
    
    
    for (UIView *subview in [self.LeftSidePanel subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }
 
    
}

-(void)hideQuestionmarksfromImageNavigationToolBar
{
    for (UIView *subview in [self.standuiView.imageNavigationtoolbar.pageNavigationtoolbar subviews])
    {
        
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
        
    }
    
    
    for (UIView *subview in [self.standuiView.imageNavigationtoolbar subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }


}

-(void)hideQuestionmarkfromTopviewPanel
{
    for (UIView *subview in [self.standuiView.topviewpanel subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
            
        }
        
        if (subview.tag==700 || subview.tag==701)
        {
            [subview removeFromSuperview];
        }
    }
    

    
}

-(void)hideQuestionmarkfromDashBoardTable
{
    for (int i=0; i<3; i++)
    {
        NSIndexPath *index =[NSIndexPath indexPathForRow:i inSection:0];
        
        CommentTableCell *cell =(CommentTableCell *)[_dashboardTable cellForRowAtIndexPath:index];
        cell.commentTextLabel.textColor=[UIColor whiteColor];
        cell.toggleImage.alpha=1.0;
        cell.leftImage.alpha=1.0 ;
        
        for (UIView *subview in [cell.viewForTopSection subviews])
        {
            if (subview.tag==100)
            {
                [subview removeFromSuperview];
            }
            
            cell.alpha=1.0;
            
            cell.userInteractionEnabled=YES ;
            
        }
        
        
    }
    
    for (int i=0; i<3; i++)
    {
        NSIndexPath *index =[NSIndexPath indexPathForRow:i inSection:0];
        
        CommentTableCell *cell =(CommentTableCell *)[_dashboardTable cellForRowAtIndexPath:index];
        
        for (UIView *subview in [cell.viewForBottomSection subviews])
        {
            if (subview.tag>=500)
            {
                [subview removeFromSuperview];
            }
            
            cell.alpha=1.0 ;
            
            cell.userInteractionEnabled=YES ;
            
        }
        
        
    }
    
    for (UIView *subview in [self.view subviews])
    {
        if (subview.tag==300 || subview.tag==250)
        {
            [subview removeFromSuperview];
        }
    }

    
}

-(void)hideQuestionMarks
{
    
    _simulationSuperView.userInteractionEnabled = YES ;
    //_simulationSuperView.alpha=1.0 ;
    [self.dashboardTable removeGestureRecognizer:_panGesture];
    
    [self hideQuestionmarkfromLeftSidePanel];
    [self hideQuestionmarksfromImageNavigationToolBar];
    [self hideQuestionmarkfromTopviewPanel];
    [self hideQuestionmarkfromDashBoardTable];
    
    
    if (!self.collinator.hidden) {
        
        self.standuiView.showcollimator=YES ;
        self.collinator.alpha=1.0 ;
    }
    
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


-(void)removePreviousQuetionamrks
{
    for (UIView *subview in [self.LeftSidePanel subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }
    
    for (UIView *subview in [self.standuiView.topviewpanel subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }
    
    for (UIView *subview in [self.standuiView.imageNavigationtoolbar.pageNavigationtoolbar subviews])
    {
        
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
        
    }
    
    
    for (UIView *subview in [self.view subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }
    for (UIView *subview in [self.standuiView.rightPanel subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }
    
    for (UIView *subview in [self.standuiView subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }
    
    
    for (UIView *subview in [self.standuiView.imageNavigationtoolbar subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }

    
}

-(void)loadQuestionmarksForTableCells
{
    
    
}


- (void)panGestureDetected:(UIPanGestureRecognizer *)recognizer
{
    

    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *index2=[NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *index3=[NSIndexPath indexPathForRow:2 inSection:0];
            CommentTableCell *cell1 =(CommentTableCell *)[self.dashboardTable cellForRowAtIndexPath:index];
    CommentTableCell *cell2 =(CommentTableCell *)[self.dashboardTable cellForRowAtIndexPath:index2];
    CommentTableCell *cell3 =(CommentTableCell *)[self.dashboardTable cellForRowAtIndexPath:index3];
    CGPoint questionmarkPoint = [recognizer locationInView:cell1.viewForTopSection];
     CGPoint questionmarkPoint2 = [recognizer locationInView:cell2.viewForTopSection];
     CGPoint questionmarkPoint3 = [recognizer locationInView:cell3.viewForTopSection];
    
    [self removePreviousQuetionamrks];
    
   
  //As UITouch does not work for cells of a table or buttons we need to implement the tap gesture and determine the position of the touch .
    
    for (UIView *subview in [cell1.viewForTopSection subviews])
    {
        
        
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, questionmarkPoint))
        {
            
            UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x, subview.center.y, 200, 50)];
            popupview.layer.cornerRadius=4.0 ;
            //  CGSize maxSize = CGSizeMake(400, CGFLOAT_MAX);
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
            label.textColor=[UIColor whiteColor];
            popupview.tag=300 ;
            [popupview addSubview:label];
            NSString *string =@"Change the examination type." ;
            label.text = string ;
            label.font=[UIFont fontWithName:@"Gill Sans" size:12];
            //  CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
            
            CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
            
            label.frame=CGRectMake(0+10, 0, textSize.width, 50);
            
            popupview.frame=CGRectMake(questionmarkPoint.x, questionmarkPoint.y-20, textSize.width+20, 50);
            popupview.backgroundColor=[UIColor blackColor];
            popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
            
            [self.LeftSidePanel addSubview:popupview];
            
            
        }
    }
    
    for (UIView *subview in [cell2.viewForTopSection subviews])
    {
        
        if (subview.tag==300) {
            [subview removeFromSuperview];
        }
        
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, questionmarkPoint2))
        {
            
            UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x, subview.center.y, 200, 50)];
            popupview.layer.cornerRadius=4.0 ;
            //  CGSize maxSize = CGSizeMake(400, CGFLOAT_MAX);
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
            label.textColor=[UIColor whiteColor];
            popupview.tag=300 ;
            [popupview addSubview:label];
            
            
            NSString *string =@"Change Fluroscopy settings";
            label.text = string ;
            label.font=[UIFont fontWithName:@"Gill Sans" size:12];
            //  CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
            CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
            
            label.frame=CGRectMake(0+10, 0, textSize.width, 50);
            
            popupview.frame=CGRectMake(questionmarkPoint2.x, questionmarkPoint2.y+20, textSize.width+20, 50);
            popupview.backgroundColor=[UIColor blackColor];
            popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
            
            [self.LeftSidePanel addSubview:popupview];
            
            
        }
    }
    
    for (UIView *subview in [cell3.viewForTopSection subviews])
    {
        if (subview.tag==300) {
            [subview removeFromSuperview];
        }
        
        
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, questionmarkPoint3))
        {
            
            UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x, subview.center.y, 200, 50)];
            popupview.layer.cornerRadius=4.0 ;
            // CGSize maxSize = CGSizeMake(400, CGFLOAT_MAX);
            UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
            label.textColor=[UIColor whiteColor];
            popupview.tag=300 ;
            [popupview addSubview:label];
            NSString *string =@"Change the Exposure Settings" ;
            label.text = string ;
            label.font=[UIFont fontWithName:@"Gill Sans" size:12];
            //  CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
            
            CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
            
            label.frame=CGRectMake(0+10, 0, textSize.width, 50);
            
            popupview.frame=CGRectMake(questionmarkPoint3.x, questionmarkPoint3.y+40, textSize.width+20, 50);
            popupview.backgroundColor=[UIColor blackColor];
            popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
            
            [self.LeftSidePanel addSubview:popupview];
            
            
        }
    }
    
    for (int i=0; i<3; i++)
    {
        NSIndexPath *index =[NSIndexPath indexPathForRow:i inSection:0];
        
        CommentTableCell *cell =(CommentTableCell *)[_dashboardTable cellForRowAtIndexPath:index];
        
        CGPoint questionmark = [recognizer locationInView:cell.viewForBottomSection];
        
        for (UIView *subview in [cell.viewForBottomSection subviews])
        {
            if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, questionmark))
            {
                //if (subview.tag==100)
                {
                    
                    UIView *popupview =[[UIView alloc]initWithFrame:CGRectMake(subview.center.x, subview.center.y, 200, 50)];
                    popupview.layer.cornerRadius=4.0 ;
                    // CGSize maxSize = CGSizeMake(400, CGFLOAT_MAX);
                    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0,200, 50)];
                    label.textColor=[UIColor whiteColor];
                    popupview.tag=300 ;
                    [popupview addSubview:label];
                    NSLog(@"subview tag value is %d",subview.tag);
                    
                    
                    
                    NSString *string =[_bottomSectionButtonArray objectAtIndex:subview.tag-500];
                    
                    if (i==2)
                    {
                        
                        _bottomSectionButtonArraycell3=[[NSArray alloc]initWithObjects:@"Select the exposure aquisition mode.",@"Change the Exposure pulse rate",nil];
                        
                        string =[_bottomSectionButtonArraycell3 objectAtIndex:subview.tag-500];
                        
                        
                        
                    }
                    
                    label.text = string ;
                    label.font=[UIFont fontWithName:@"Gill Sans" size:12];
                    //     CGSize textSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize];
                    CGSize textSize = [[label text] sizeWithAttributes:@{NSFontAttributeName:[label font]}];
                    
                    label.frame=CGRectMake(0+10, 0, textSize.width, 50);
                    
                    popupview.frame=CGRectMake(questionmark.x, questionmark.y+50, textSize.width+20, 50);
                    
                    if (i==2)
                    {
                        popupview.frame=CGRectMake(questionmark.x, questionmark.y+90, textSize.width+20, 50);
                    }
                    popupview.backgroundColor=[UIColor blackColor];
                    popupview.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.5];
                    
                    [self.LeftSidePanel addSubview:popupview];
                    
                    
                }
                
                
            }
        }
    }

 }

-(BOOL)checkOutsideCircle_Bounds:(CGPoint)pointoutside
{
    CGPoint circleCenter =CGPointMake(544.5, 349.5);
    
    CGFloat lhs = (pointoutside.x-circleCenter.x)*(pointoutside.x-circleCenter.x)+(pointoutside.y-circleCenter.y)*(pointoutside.y-circleCenter.y);
    CGFloat rhs =(self.standuiView.circleRadius+28)*(self.standuiView.circleRadius+28) ;
    
    if (lhs>rhs)
    {
        return NO ;
    }
    else
    {
        return YES ;
    }
}

-(void)CreateSystemView
{
    if(standUISystemView==nil)
    {
        CGRect systemViewFrame = CGRectMake( 0, 10, 1024, 760 );
        standUISystemView =  [[[NSBundle mainBundle] loadNibNamed:@"StandUISystem" owner:self options:nil] firstObject];
        standUISystemView.frame =systemViewFrame;
         [standUISystemView initSystemView];
        [self.view addSubview:standUISystemView];
        
    }
   
    standUISystemView.hidden=NO;
    
    
}
- (IBAction)AboutScreenButtonTapped:(id)sender {
    
    if(controller == nil)
    {
    controller = [[AboutScreen alloc] initWithNibName:@"AboutScreen" bundle:nil];
    popoverController = [[UIPopoverController alloc] initWithContentViewController:controller];
    }
    
    if ([popoverController isPopoverVisible]) {
        [popoverController dismissPopoverAnimated:YES];
    } else {
        //the rectangle here is the frame of the object that presents the popover,
        //in this case, the UIButton…
        CGRect popRect = CGRectMake(self.AboutScreenBtn.frame.origin.x,
                                    self.AboutScreenBtn.frame.origin.y,
                                    self.AboutScreenBtn.frame.size.width,
                                    self.AboutScreenBtn.frame.size.height);
       
        [popoverController presentPopoverFromRect:popRect
                                           inView:sender
                         permittedArrowDirections:UIPopoverArrowDirectionUp
                                         animated:YES];
    }
}
@end
