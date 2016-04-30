//
//  StandUI.m
//  StandUI
//
//  Created by CLPricingTeam on 8/2/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "StandUI.h"
#import "Constants.h"
#import "imageReview.h"
#import "ImageReview/imageReview.h"

#define   DEGREES_TO_RADIANS(degrees)  ((3.14 * degrees)/ 180)
#define   offsetValue   20


@interface StandUI ()

@property (nonatomic, strong) NSString *currFluoroMode;
@property (nonatomic, strong) NSString *currExposureMode;
@property (strong, atomic)NSTimer *xRayTimer;
@property (nonatomic, strong)UISwipeGestureRecognizer *swipeRight;
@property (nonatomic, strong)UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic, strong)UISwipeGestureRecognizer *swipeDown;
@property (nonatomic, strong)UISwipeGestureRecognizer *swipeUp;
@property (nonatomic,assign) int AllImageBtnTapped;
@property (nonatomic,assign) int SingleImageBtnTapped;
@property (nonatomic,assign) BOOL reinitByIBAction;

@property (nonatomic,copy) StandUI *PrevStandUIObjStatus;
@property (nonatomic,assign) int currentSystemMode;
@end

@implementation StandUI


@synthesize  currFluoroMode;
@synthesize  currExposureMode;
@synthesize examinationType;
@synthesize xRayTimer;
@synthesize reset_shutters_collinators;
@synthesize swipeRight,swipeLeft,swipeDown,swipeUp;
@synthesize currentSystemMode;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
            }
    return self;
}

#pragma mark - Initialization implementation

-(void)initialize_arrays
{
    runarray=[[NSArray alloc]initWithObjects:@"11",@"11",@"11",@"11",@"11",@"11",@"12",@"12",@"12",@"12",@"12",@"12",@"12",@"12",nil];
    imageArray=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",nil];
    
    
    runarray1=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"9",@"9",@"9",@"10",@"10",@"10",@"10",nil];
    imageArray1=[[NSArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",nil];
    
    singleimageNumbers=[[NSArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"2",@"2",@"3",@"4", nil];
    
    _leftpanelbuttonInfoList=[[NSArray alloc]initWithObjects:@"Change Detector Zoom factor",@"Display direction indcators to select image orientation",@"Turn the detector laser on or off.",@"Manually change KV settings",@"Store or recall the position of C-Arc",@"Turn tube laser on/off",nil]  ;
    
    _rightpanelbuttonInfoList = [[NSArray alloc]initWithObjects:@"Automatically position the shutters.",@"Copy the current image to the reference monitor.",@"Copy image from ref monitor to the examination monitor ",@"Change the contrast and brightness of the current image.",@"Flag(protect and store) current image/run",@"Mirror the current image left/right.",@"Flip the current image up/down.",@"Couple shutter movement.",@"Reset shutters and collimator to default positions.",nil]  ;
    
    _standUIpanelbuttonInfoList = [[NSArray alloc]initWithObjects:@"Clear Guide 12",@"Clear Guide 3",@"Clear Guide 6",@"Clear Guide 9",@"Drag to rotate the image",@"Drag to change shutter position",@"Drag to shutter change position",@"Drag to change shutter position",@"Drag to change shutter position",@"Drag to change shutter position",@"Drag to change shutter position",nil]  ;
    
    _imageNavigationtollbarList=[[NSMutableArray alloc]initWithObjects:@"Previous image or previous run",@"View images of a run in a cycle",@"Display image overview",@"Next image or next run",@"4",@"5",@"6", nil];
    
    _TopPanelList=[[NSArray alloc]initWithObjects:@"Open System Menu.",@"Display help.",nil];
    
    _pageControllerList=[[NSArray alloc]initWithObjects:@"Previous page",@"Next page",nil];


    
}

-(void)resetBooleanvalues
{
    XRayImageExists = NO;
    self.xrayOn=NO ;
    self.xrayOff=YES;
    _questionmarkPressed=NO ;
    onlyonce=NO ;
    _collimatorOverlapped=NO;
    _collimatorOverlapped_leftcropView=NO;
    _collimatorOverlapped_rightcropView=NO;
    left_lastTouched=YES;
    right_lastTouched=YES;
    _collimator_leftview=NO ;
    _collimator_rightview=NO ;
    _runcycleButtonclicked=NO ;
    self.imageNavigationtoolbar.backgroundColor=[[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    
    self.otherExam=YES ;
    self.normalState=NO;
    self.clearGuideButtonSelected=NO ;
    applaunch=YES;
    hidden=YES ;
    positionbuttonclicked=NO ;
    examinationType=SKELETONVIEW;
    mirror=NO ;
    flip = NO ;
    angle_mirror=0.0;
    angle_flip=0.0 ;
    couplingshuttersON=NO ;
    rotationangle=0.0;
    self.controller.collinator.userInteractionEnabled=NO;
    no_of_times=0.0;
    auto_shutter=NO ;
    pagedownbutonpressed=NO ;
    pageupbutonpressed= YES ;
    self.reinitByIBAction = YES;
    
    
    _imageNavigationtoolbar.singleimagepressed=NO ;
    _imageNavigationtoolbar.allimagepressed = NO  ;
    
    
    _Automatic.textColor=[UIColor grayColor];
    _shutterPos.textColor=[UIColor grayColor];
    _AutomaticShutterBtn.userInteractionEnabled=NO ;
    
    
    [self initialize_arrays];
    
    overviewButtonClicked= NO ;
    
    currentSystemMode = NOIMAGE;
    navigationshadowViewsExists = NO;
    rotating_Symbol_layered_onBtn   = -1;
    right_shutter_layered_onBtn     = -1;
    left_shutter_layered_onBtn      = -1;
    
    swipeDown.enabled=NO ;
    swipeUp.enabled=NO ;
    
}

-(void)shadowForNumbers
{
    
    self.number12.layer.borderWidth = 3;
    self.number12.layer.borderColor = [UIColor clearColor].CGColor;
    self.number12.layer.shouldRasterize = YES;
    
    self.number12.layer.shadowOffset = CGSizeMake(0, -1);
    self.number12.layer.shadowOpacity = 0.5;
    self.number12.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    self.number6.layer.borderWidth = 3;
    self.number6.layer.borderColor = [UIColor clearColor].CGColor;
    self.number6.layer.shouldRasterize = YES;
    
    self.number6.layer.shadowOffset = CGSizeMake(0, -1);
    self.number6.layer.shadowOpacity = 0.5;
    self.number6.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    
    self.number3.layer.borderWidth = 3;
    self.number3.layer.borderColor = [UIColor clearColor].CGColor;
    self.number3.layer.shouldRasterize = YES;
    
    self.number3.layer.shadowOffset = CGSizeMake(0, -1);
    self.number3.layer.shadowOpacity = 0.5;
    self.number3.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    self.number9.layer.borderWidth = 3;
    self.number9.layer.borderColor = [UIColor clearColor].CGColor;
    self.number9.layer.shouldRasterize = YES;
    
    self.number9.layer.shadowOffset = CGSizeMake(0, -1);
    self.number9.layer.shadowOpacity = 0.5;
    self.number9.layer.shadowColor = [UIColor blackColor].CGColor;
    
    

}

-(void)shareInstance:(StandUIViewController *)controller
{
    
    [self resetBooleanvalues];
    [self shadowForNumbers];
   
    self.controller=controller ;
   
    standController=self.controller ;
    
    self.controller.collinator.center=CGPointMake(self.controller.view.bounds.size.width/2+47,120);
    colimatorPOint=self.controller.collinator.center ;
    
    CGPoint point =  CGPointMake(553, 342);
    
    self.controller.standviewParent.center = point ;
    [self InitImageNavigationToolbar];
    [self.bottomPanelSuperView initBottomPanelSuperView];
    
    scrollbar.hidden=YES ;
    

}

 // Image Navigation Initialisation
-(void)InitImageNavigationToolbar
{
    self.AllImageBtnTapped = FALSE;
    self.SingleImageBtnTapped =  FALSE;
    
    self.imageNavigationtoolbar.layer.cornerRadius = 20.0f;
    self.imageNavigationtoolbar.layer.borderWidth = 1;
    self.imageNavigationtoolbar.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.imageNavigationtoolbar InitialiseView];
    [self.imageNavigationtoolbar ShareInstance:(__bridge void *)(self)];
    
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;    swipeRight.delegate = self;
    [self addGestureRecognizer:swipeRight];
    
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeRight.delegate = self;
    [self addGestureRecognizer:swipeLeft];
    [self SwipeGestureEnable_Disable:NO];
    [self.imageNavigationtoolbar Hide_UnhideAllNavigationToolBarViews:YES];
    [self hide_UnHide_RightPanelButtons:NO];
    [self hide_UnHide_PageNavigationButtons:YES];
}

-(void)SwipeGestureEnable_Disable:(BOOL)val
{
    swipeRight.enabled = val;
    swipeLeft.enabled = val;

    
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer *)swipeRecognizer
{
    if(swipeRecognizer.direction & UISwipeGestureRecognizerDirectionRight )
    {
        [self.imageNavigationtoolbar PreviousImageBtnClicked:nil];
    }
    else if(swipeRecognizer.direction & UISwipeGestureRecognizerDirectionLeft)
    {
        [self.imageNavigationtoolbar NextImageBtnClicked:nil];
    }
    
    else if(swipeRecognizer.direction & UISwipeGestureRecognizerDirectionDown)
    {
        [self PageUpBtnClicked:nil];
        
    }
    
    else if(swipeRecognizer.direction & UISwipeGestureRecognizerDirectionUp)
    {
        [self PageDownBtnClicked:nil];
    }
    
    
}


-(void)handleSwipeDown:(UISwipeGestureRecognizer *)swipeRecognizer
{
    if(swipeRecognizer.direction & UISwipeGestureRecognizerDirectionRight )
    {
        [self.imageNavigationtoolbar PreviousImageBtnClicked:nil];
    }
    else if(swipeRecognizer.direction & UISwipeGestureRecognizerDirectionLeft)
    {
        [self.imageNavigationtoolbar NextImageBtnClicked:nil];
    }
}



-(void)StartTimer
{
     [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                target: self
                                              selector:@selector(stopXRay:)
                                              userInfo: nil repeats:NO];
   
}

-(void)stopXRay:(NSTimer *)Localtimer
{
    if( [self.FluroxraySwitch isOn] )
    {
       [self.FluroxraySwitch setOn:NO animated:YES];
       [self fluroSwitch:nil];
    }
    else if( [self.ExpoxraySwitch isOn])
    {
        [self.ExpoxraySwitch setOn:NO animated:YES];
        [self expoSwitch:nil];
    }
}

#pragma mark - Create StandUI element implementation

-(void)createMaskLayer
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    self.subview.layer.mask = maskLayer;
    self.maskLayer = maskLayer;
   
 
}

-(void)createCircleShapeLayer
{
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 1.0;
    circleLayer.fillColor = [[UIColor clearColor] CGColor];
   
    circleLayer.strokeColor = [[UIColor grayColor] CGColor];
    
    [self.layer addSublayer:circleLayer];
    self.circleLayer = circleLayer;
}


-(void)createboundingCircleShapeLayer:(CGFloat) radius
{
    
  
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
 
    [bezierPath addArcWithCenter:CGPointMake(384,502)
                    radius:radius
                startAngle:0.0
                  endAngle:DEGREES_TO_RADIANS(360)
                 clockwise:YES];
    
    bezierPath.lineWidth = 1.0;
    [[UIColor clearColor] setStroke];
    [bezierPath closePath];
     [bezierPath stroke];
    borderCircle.path=[bezierPath CGPath];
    
    [self.layer addSublayer:borderCircle];
}


-(void)createRotatingSymbol
{
    
    UIImage *rotate_circle = [UIImage imageNamed:@"resrt-act2x.png"];
    
    self.rotate_circle_view = [[UIImageView alloc]initWithImage:rotate_circle];
    
    self.rotate_circle_view.frame=CGRectMake(self.circleCenter.x-35,self.circleCenter.y
                                             -self.bounds.size.width*0.3-self.rotate_circle_view.frame.size.width/1.5,60, 60);
    
    [self addSubview:self.rotate_circle_view];
    self.rotate_circle_view.alpha=0.6;

    
}

- (void)updateCirclePathAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    self.circleCenter = location;
    self.circleRadius = radius;

    path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.circleCenter
                    radius:self.circleRadius
                startAngle:0.0
                  endAngle:DEGREES_TO_RADIANS(360)
                 clockwise:YES];
    UIColor* white = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.374];
    [path setLineWidth:1.0];
    [white setStroke];

   
    self.circleLayer.path = [path CGPath];
    
    if (!self.controller.collimatorclicked || self.reinitByIBAction == NO)
    {
         self.maskLayer.path = [path CGPath];
        
        
    }
}


-(void)UpdateCurrentSystemMode
{
    if ([self.FluroxraySwitch isOn] || [self.ExpoxraySwitch isOn] )
    {
        currentSystemMode = LIVE;
    }
    else if (![self.FluroxraySwitch isOn] && ![self.ExpoxraySwitch isOn] )
    {
        currentSystemMode = LIHMODE;
    }
/*  if((self.imageNavigationtoolbar.imageReviewMode == YES))
    {
         currentSystemMode = IMAGEREVIEW;
    }
*/
  //  [self.bottomPanelSuperView updateCArmPositionSelectedRun];
    if(self.controller.posMemView)
    {
        [self.controller.posMemView setValue:[NSNumber numberWithInteger:currentSystemMode]  forKey:@"pmCurrSystemMode"];
    }
}

-(void)createCropLines
{
    UIImage *left_line =[UIImage imageNamed:@"shutter_line_white_right.png"];
    UIImage *right_line=[UIImage imageNamed:@"shutter_line_white_left.png"];
    
    UIImage *left_crop =[UIImage imageNamed:@"iris_shutter_gray_left.png"];
    UIImage *right_crop=[UIImage imageNamed:@"iris_shutter_gray_right.png"];
    
    UIImage *left_cascade =[UIImage imageNamed:@"black_box_left.png"];
    UIImage *right_cascade = [UIImage imageNamed:@"black_box_right.png"];
    
    self.leftImageview=[[UIImageView alloc]initWithImage:left_line];
 
    self.cascadeImageview=[[UIImageView alloc]initWithImage:left_cascade];
    self.cascadeImageviewRight=[[UIImageView alloc]initWithImage:right_cascade];
    
   
    self.leftImageview.center = CGPointMake(self.circleCenter.x-self.bounds.size.width*0.3-25, self.circleCenter.y);
    
    

    self.leftcropImageview=[[UIImageView alloc]initWithImage:left_crop];
    self.leftcropImageview.center = self.leftImageview.center ;
  
    self.leftcropImageview.alpha = 1.0;
    
    self.cascadeImageview.center=self.leftImageview.center ;
    
   [self.subview addSubview:self.cascadeImageview];
   
    self.cascadeImageview.alpha=0.6;
    
   

    self.rightImageview=[[UIImageView alloc]initWithImage:right_line];
    

    self.rightImageview.center = CGPointMake(self.circleCenter.x+self.bounds.size.width*0.30+25, self.circleCenter.y);
    self.rightcropImageview=[[UIImageView alloc]initWithImage:right_crop];
    self.rightcropImageview.center=CGPointMake(self.rightImageview.center.x,self.rightImageview.center.y );
    self.rightcropImageview.alpha=1.0;

   
    self.cascadeImageviewRight.center=self.rightImageview.center;
    [self.subview addSubview:self.cascadeImageviewRight];
    self.cascadeImageviewRight.alpha=0.6;

    
    [self addSubview:self.leftImageview];
    [self addSubview:self.rightImageview];
    
    [self addSubview:self.leftcropImageview];
    [self addSubview:self.rightcropImageview];
    
    self.leftImageview.alpha=0.7;
    self.rightImageview.alpha=0.7;
    
}


/** Calculates the distance between point1 and point2. */
CGFloat distanceBetweenPoints(CGPoint point1, CGPoint point2)
{
    CGFloat dx = point1.x - point2.x;
    CGFloat dy = point1.y - point2.y;
    return sqrt(dx*dx + dy*dy);
}

CGFloat angleBetweenLinesInDegrees(CGPoint beginLineA,
                                   CGPoint endLineA,
                                   CGPoint beginLineB,
                                   CGPoint endLineB)
{
    CGFloat a = endLineA.x - beginLineA.x;
    CGFloat b = endLineA.y - beginLineA.y;
    CGFloat c = endLineB.x - beginLineB.x;
    CGFloat d = endLineB.y - beginLineB.y;
    
    CGFloat atanA = atan2(a, b);
    CGFloat atanB = atan2(c, d);
    
    // convert radiants to degrees
    return (atanA - atanB) * 180 / M_PI;
}


-(void)manageComponents:(CGFloat)lhs Righthandside:(CGFloat)rhs andCurrenttouchPoint:(CGPoint)nowPoint
{
    
    BOOL check2 ;
    
    if (lhs>rhs)
    {
        check2=NO;
    }
    
    else
    {
        check2=YES;
    }
    
    
    if (check2) {
        
        if (_leftviewtouched)
        {
            self.leftcropImageview.image=[UIImage imageNamed:@"iris_shutter_yellow_left.png"];
            self.leftImageview.image=[UIImage imageNamed:@"shutter_line_yellow_right.png"];
            
            rotatingviewtouched=NO;
            
            if (!self.xrayOff)
            {
                self.cascadeImageview.alpha=0.6;
                self.cascadeImageviewRight.alpha=0.6;
             }
            
            CGFloat lhs3 = (self.rightcropImageview.center.x-self.circleCenter.x)*(self.rightcropImageview.center.x-self.circleCenter.x)+(self.rightcropImageview.center.y-self.circleCenter.y)*(self.rightcropImageview.center.y-self.circleCenter.y);
            CGFloat rhs3 =self.circleRadius*self.circleRadius ;
            
            
            CGFloat lhs4 = (self.leftcropImageview.center.x-self.circleCenter.x)*(self.leftcropImageview.center.x-self.circleCenter.x)+(self.leftcropImageview.center.y-self.circleCenter.y)*(self.leftcropImageview.center.y-self.circleCenter.y);
            CGFloat rhs4 =self.circleRadius*self.circleRadius ;
            
            BOOL check4 ;
            NSLog(@"LHS3 AND RHS3 are %f %f",lhs3,rhs3);
            
            
            BOOL check3 ;
            
            if (lhs3>rhs3)
            {
                check3=YES ;
            }
            
            else
            {
                check3=NO ;
                
            }
            
            
            if (lhs4>rhs4)
            {
                check4=YES ;
            }
            
            else
            {
                check4=NO ;
                
            }
            
            if(check3 && (self.leftcropImageview.alpha!=1.0) && !check4)
            {
                CGPoint point;
                point=self.circleCenter ;
                point.x =self.circleCenter.x -(226+25);
                CGFloat y1,y2 ;
                
                y1 = self.circleCenter.x - (226+25);
                y2 = self.circleCenter.y + (226+25);
                
                
                
                
                CGFloat slope =[self slopeOFline:nowPoint and:self.circleCenter];
                
                CGPoint pointOnCircle ;
                
                int radius = 226+25 ;
                
                
                pointOnCircle.y = ((slope*radius)/-sqrt(slope*slope +1)) + self.circleCenter.y ;
                
                pointOnCircle.x = ((pointOnCircle.y - self.circleCenter.y)/slope) + self.circleCenter.x ;
                
                if (nowPoint.y==self.circleCenter.y && nowPoint.x<self.circleCenter.x)
                {
                    pointOnCircle.x = self.circleCenter.x+radius ;
                    pointOnCircle.y = self.circleCenter.y ;
                }
                
                else if (nowPoint.y==self.circleCenter.y && nowPoint.x>self.circleCenter.x)
                {
                    pointOnCircle.x = self.circleCenter.x-radius ;
                    pointOnCircle.y = self.circleCenter.y ;
                    
                }
                
                else if (nowPoint.x==self.circleCenter.x && nowPoint.y<self.circleCenter.y)
                {
                    pointOnCircle.x = self.circleCenter.x ;
                    pointOnCircle.y = self.circleCenter.y+radius ;
                    
                }
                
                else if (nowPoint.x==self.circleCenter.x && nowPoint.y>self.circleCenter.y)
                {
                    pointOnCircle.x = self.circleCenter.x ;
                    pointOnCircle.y = self.circleCenter.y-radius ;
                    
                }
                
                else if (nowPoint.x < self.circleCenter.x && nowPoint.y<self.circleCenter.y)
                {
                    
                    pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
                    pointOnCircle.y =  self.circleCenter.y-((slope*radius)/-sqrt(slope*slope +1))  ;
                    
                }
                
                else if(nowPoint.x < self.circleCenter.x && nowPoint.y>self.circleCenter.y)
                {
                    pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
                    pointOnCircle.y =  self.circleCenter.y-((slope*radius)/-sqrt(slope*slope +1))  ;
                    
                }
                
                
                
                self.leftImageview.alpha=1.0;
                
                CGFloat angle = angleBetweenLinesInDegrees(self.circleCenter, self.leftcropImageview.center, self.circleCenter, nowPoint);
                
                CGFloat angle2 =angle ;
                // fix value, if the 12 o'clock position is between prevPoint and nowPoint
                if (angle > 180)
                {
                    angle -= 360;
                }
                else if (angle < -180)
                {
                    angle += 360;
                }
                
                leftcroplineAngle += angle;
                
                
                if (angle2 > 180)
                {
                    angle2 -= 360;
                }
                else if (angle2 < -180)
                {
                    angle2 += 360;
                }
                rightcroplineAngle += angle2;
                
                self.leftcropImageview.center=nowPoint ;
                self.leftImageview.center=nowPoint ;
                
                self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                self.leftImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                
                
                
                
                self.rightcropImageview.center=pointOnCircle ;
                self.rightImageview.center=pointOnCircle ;
                
                self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                self.rightImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                
                rightcroplineAngle=leftcroplineAngle ;
                
                
            }
            
            
            else {
                
                
                CGFloat diff =0.0;
                CGFloat diffY =0.0 ;
                diff=nowPoint.x-self.leftcropImageview.center.x ;
                diffY=nowPoint.y-self.leftcropImageview.center.y ;
                
                
                CGPoint rightimageviewPoint;
                
                
                rightimageviewPoint=self.rightcropImageview.center ;
                rightimageviewPoint.x-=diff;
                rightimageviewPoint.y-=diffY ;
                
                CGFloat distance = distanceBetweenPoints(nowPoint, rightimageviewPoint);
                
                if (distance>120)
                {
                    
                    self.leftImageview.alpha=1.0;
                    
                    CGFloat angle = angleBetweenLinesInDegrees(self.circleCenter, self.leftcropImageview.center, self.circleCenter, nowPoint);
                    
                    CGFloat angle2 =angle ;
                    // fix value, if the 12 o'clock position is between prevPoint and nowPoint
                    if (angle > 180)
                    {
                        angle -= 360;
                    }
                    else if (angle < -180)
                    {
                        angle += 360;
                    }
                    
                    leftcroplineAngle += angle;
                    
                    
                    if (angle2 > 180)
                    {
                        angle2 -= 360;
                    }
                    else if (angle2 < -180)
                    {
                        angle2 += 360;
                    }
                    rightcroplineAngle += angle2;
                    
                    // sum up single steps
                    
                    lhs = (rightimageviewPoint.x-self.circleCenter.x)*(rightimageviewPoint.x-self.circleCenter.x)+(rightimageviewPoint.y-self.circleCenter.y)*(rightimageviewPoint.y-self.circleCenter.y);
                    rhs=(self.bounds.size.width*0.3+53-25)*(self.bounds.size.width*0.3+53-25) ;
                    
                    if (lhs>rhs)
                    {
                        check2=NO;
                    }
                    
                    else
                    {
                        check2=YES;
                    }
                    
                    
                    
                    if (check2)
                    {
                        
                        
                        self.leftcropImageview.center=nowPoint ;
                        self.leftImageview.center=nowPoint ;
                        
                        self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                        self.leftImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                        
                        
                        
                        self.rightcropImageview.center=rightimageviewPoint ;
                        self.rightImageview.center=rightimageviewPoint ;
                        
                        
                        
                        
                        self.rightImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                        self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                        
                        
                        
                        if (!self.xrayOff)
                        {
                            self.cascadeImageview.center=nowPoint;
                            self.cascadeImageviewRight.center=rightimageviewPoint ;
                            
                            self.cascadeImageview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                            
                            self.cascadeImageviewRight.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                        }
                        
                        
                        
                    }//check2
                    
                    else
                    {
                        
                        self.leftcropImageview.center=nowPoint ;
                        self.leftImageview.center=nowPoint ;
                        
                        self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                        self.leftImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                        
                        
                        if (!self.xrayOff)
                        {
                            self.cascadeImageview.center=nowPoint;
                            self.cascadeImageview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                        }
                        
                        
                    }
                    
                }
                
                
            }//end of check3
            
            
        }
        
        
        else if(_rightviewtouched)
        {
            rotatingviewtouched=NO;
            onlyonce=NO ;
            self.rightcropImageview.image=[UIImage imageNamed:@"iris_shutter_yellow_right.png"];
            self.rightImageview.image=[UIImage imageNamed:@"shutter_line_yellow_left.png"];
            
            if (!self.xrayOff)
            {
                self.cascadeImageview.alpha=0.6;
                self.cascadeImageviewRight.alpha=0.6;
             }
            
            
            CGFloat lhs3 = (self.leftcropImageview.center.x-self.circleCenter.x)*(self.leftcropImageview.center.x-self.circleCenter.x)+(self.leftcropImageview.center.y-self.circleCenter.y)*(self.leftcropImageview.center.y-self.circleCenter.y);
            CGFloat rhs3 =self.circleRadius*self.circleRadius ;
            
            
            
            CGFloat lhs4 = (self.rightcropImageview.center.x-self.circleCenter.x)*(self.rightcropImageview.center.x-self.circleCenter.x)+(self.rightcropImageview.center.y-self.circleCenter.y)*(self.rightcropImageview.center.y-self.circleCenter.y);
            CGFloat rhs4 =self.circleRadius*self.circleRadius ;
            
            
            BOOL check4 ;
            
            
            BOOL check3 ;
            
            if (lhs3>rhs3)
            {
                check3=YES ;
            }
            
            else
            {
                check3=NO ;
                
            }
            
            
            if (lhs4>rhs4)
            {
                check4=YES ;
            }
            
            else
            {
                check4=NO ;
                
            }
            
            
            
            
            if (check3 && self.rightcropImageview.alpha!=1.0 && !check4)
            {
                
                CGPoint point;
                point=self.circleCenter ;
                point.x =self.circleCenter.x -(226+25);
                CGFloat y1,y2 ;
                
                y1 = self.circleCenter.x - (226+25);
                y2 = self.circleCenter.y + (226+25);
                
                
                CGFloat slope =[self slopeOFline:nowPoint and:self.circleCenter];
                
                CGPoint pointOnCircle ;
                
                int radius = 226+25 ;
                
                
                pointOnCircle.y = ((slope*radius)/-sqrt(slope*slope +1)) + self.circleCenter.y ;
                
                pointOnCircle.x = ((pointOnCircle.y - self.circleCenter.y)/slope) + self.circleCenter.x ;
                
                if (nowPoint.y==self.circleCenter.y && nowPoint.x<self.circleCenter.x)
                {
                    pointOnCircle.x = self.circleCenter.x+radius ;
                    pointOnCircle.y = self.circleCenter.y ;
                }
                
                else if (nowPoint.y==self.circleCenter.y && nowPoint.x>self.circleCenter.x)
                {
                    pointOnCircle.x = self.circleCenter.x-radius ;
                    pointOnCircle.y = self.circleCenter.y ;
                    
                }
                
                else if (nowPoint.x==self.circleCenter.x && nowPoint.y<self.circleCenter.y)
                {
                    pointOnCircle.x = self.circleCenter.x ;
                    pointOnCircle.y = self.circleCenter.y+radius ;
                    
                }
                
                else if (nowPoint.x==self.circleCenter.x && nowPoint.y>self.circleCenter.y)
                {
                    pointOnCircle.x = self.circleCenter.x ;
                    pointOnCircle.y = self.circleCenter.y-radius ;
                    
                }
                
                else if (nowPoint.x < self.circleCenter.x && nowPoint.y<self.circleCenter.y)
                {
                    
                    pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
                    pointOnCircle.y =  self.circleCenter.y-((slope*radius)/-sqrt(slope*slope +1))  ;
                    
                }
                
                else if(nowPoint.x < self.circleCenter.x && nowPoint.y>self.circleCenter.y)
                {
                    pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
                    pointOnCircle.y =  self.circleCenter.y-((slope*radius)/-sqrt(slope*slope +1))  ;
                    
                }
                
                
                CGFloat angle = angleBetweenLinesInDegrees(self.circleCenter, self.rightcropImageview.center, self.circleCenter, nowPoint);
                
                CGFloat angle2 =angle ;
                self.rightImageview.alpha=1.0;
                
                
                // fix value, if the 12 o'clock position is between prevPoint and nowPoint
                if (angle > 180)
                {
                    angle -= 360;
                }
                else if (angle < -180)
                {
                    angle += 360;
                }
                
                rightcroplineAngle += angle;
                
                
                
                if (angle2 > 180)
                {
                    angle2 -= 360;
                }
                else if (angle2 < -180)
                {
                    angle2 += 360;
                }
                leftcroplineAngle += angle2;
                
                
                self.rightcropImageview.center=nowPoint ;
                self.rightImageview.center=nowPoint ;
                
                self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                self.rightImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                
                
                self.leftcropImageview.center=pointOnCircle ;
                self.leftImageview.center=pointOnCircle ;
                
                
                self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                self.leftImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                
                leftcroplineAngle=rightcroplineAngle ;
                
            }
            
            else {
                
                
                CGFloat diff =0.0;
                CGFloat diffY =0.0 ;
                diff=nowPoint.x-self.rightcropImageview.center.x ;
                diffY=nowPoint.y-self.rightcropImageview.center.y ;
                
                
                CGPoint rightimageviewPoint;
                
                
                rightimageviewPoint=self.leftcropImageview.center ;
                rightimageviewPoint.x-=diff;
                rightimageviewPoint.y-=diffY ;
                
                CGFloat distance = distanceBetweenPoints(nowPoint, rightimageviewPoint);
                
                if (distance>120) {
                    
                    CGFloat angle = angleBetweenLinesInDegrees(self.circleCenter, self.rightcropImageview.center, self.circleCenter, nowPoint);
                     CGFloat angle2 =angle ;
                    self.rightImageview.alpha=1.0;
                    
                    
                    // fix value, if the 12 o'clock position is between prevPoint and nowPoint
                    if (angle > 180)
                    {
                        angle -= 360;
                    }
                    else if (angle < -180)
                    {
                        angle += 360;
                    }
                    
                    rightcroplineAngle += angle;
                    
                    
                    
                    if (angle2 > 180)
                    {
                        angle2 -= 360;
                    }
                    else if (angle2 < -180)
                    {
                        angle2 += 360;
                    }
                    leftcroplineAngle += angle2;
                    
                    
                    lhs = (rightimageviewPoint.x-self.circleCenter.x)*(rightimageviewPoint.x-self.circleCenter.x)+(rightimageviewPoint.y-self.circleCenter.y)*(rightimageviewPoint.y-self.circleCenter.y);
                    rhs=(self.bounds.size.width*0.3+53-25)*(self.bounds.size.width*0.3+53-25) ;
                    
                    if (lhs>rhs)
                    {
                        check2=NO;
                    }
                    
                    else
                    {
                        check2=YES;
                    }
                    
                    
                    if (check2)
                    {
                        
                        self.rightcropImageview.center=nowPoint ;
                        self.rightImageview.center=nowPoint ;
                        
                        self.leftcropImageview.center=rightimageviewPoint ;
                        self.leftImageview.center=rightimageviewPoint ;
                        
                        
                        self.leftImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                        self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                        
                        
                        
                        if (!self.xrayOff)
                        {
                            self.cascadeImageview.center=rightimageviewPoint;
                            self.cascadeImageviewRight.center=nowPoint ;
                            
                            self.cascadeImageviewRight.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                            
                            self.cascadeImageview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
                        }
                        
                        
                        self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                        self.rightImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                        
                        
                    }//check2
                    
                    else
                    {
                        self.rightcropImageview.center=nowPoint ;
                        self.rightImageview.center=nowPoint ;
                        
                        self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                        self.rightImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                        if (!self.xrayOff)
                        {
                            self.cascadeImageviewRight.center=nowPoint ;
                            
                            self.cascadeImageviewRight.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
                        }
                        
                        
                    }
                }
                
                
            }//end of check3
            
            
            
        }
        
        
    }
    
}


-(void)leftshutter_moved:(CGPoint)nowPoint
{
 
    _showcollimator=NO;
    touchDownpointLeft=nowPoint;
    right_lastTouched=NO;
    rotatingviewtouched=NO ;
    self.leftcropImageview.image=[UIImage imageNamed:@"iris_shutter_yellow_left.png"];
    self.leftImageview.image=[UIImage imageNamed:@"shutter_line_yellow_right.png"];
    _collimator_leftview=YES ;
    
    
    self.leftcropImageview.alpha=1.0 ;
    
    
    if (self.leftcropImageview.center.x==self.rightcropImageview.center.x && self.leftcropImageview.center.y==self.rightcropImageview.center.y )
    {
        
        right_lastTouched=NO ;
        left_lastTouched=YES ;
        
    }
    
    
    {
        
        CGFloat angle = angleBetweenLinesInDegrees(self.circleCenter, self.leftcropImageview.center, self.circleCenter, nowPoint);
        if (!self.xrayOff)
        {
            self.cascadeImageview.alpha=0.6;
            self.cascadeImageviewRight.alpha=0.6;
        }
        
        
        self.leftImageview.alpha=1.0;
        
        NSLog(@"THE CENTER VALUES ARE %f %f",self.leftcropImageview.center.x,self.leftcropImageview.center.y);
        
        if ((self.leftcropImageview.center.x>240 && self.leftcropImageview.center.x<290.0) && self.leftcropImageview.center.y>260 && self.leftcropImageview.center.y<300)
        {
            _collimatorOverlapped_leftcropView=YES ;
        }
        
        else
        {
            
            _collimatorOverlapped_leftcropView=NO ;
        }
        
        
        
        if (angle > 180)
        {
            angle -= 360;
        }
        else if (angle < -180)
        {
            angle += 360;
        }
        
        // sum up single steps
        leftcroplineAngle += angle;
        
        self.leftcropImageview.center=nowPoint ;
        self.leftImageview.center=nowPoint ;
        
        CGPoint leftimageviewPoint = nowPoint ;
        
        leftimageviewPoint.x-=135;
        leftimageviewPoint.y=nowPoint.y ;
        
        if (nowPoint.x<self.circleCenter.x)
        {
            
            if (!self.xrayOff)
            {
                self.cascadeImageview.center=nowPoint;
            }
        }
        
        else
        {
            
            
            if (!self.xrayOff)
            {
                self.cascadeImageview.center=nowPoint;
            }
            
            
        }
        
        self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
        self.leftImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
        
        thetaangleLeft=leftcroplineAngle ;
        
        NSLog(@"LeftcropAngle is %f",leftcroplineAngle);
        
        if (!self.xrayOff)
        {
            self.cascadeImageview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
        }
        
    }
}

-(void)rightshutter_moved:(CGPoint)nowPoint
{
    
    
        touchDownpointRight=nowPoint;
        _showcollimator=NO;
        left_lastTouched=NO;
        rotatingviewtouched=NO ;
        _collimator_rightview=YES ;
        onlyonce=NO ;
        self.rightcropImageview.image=[UIImage imageNamed:@"iris_shutter_yellow_right.png"];
        self.rightImageview.image=[UIImage imageNamed:@"shutter_line_yellow_left.png"];
        rotatingviewtouched=NO;
        CGFloat angle = angleBetweenLinesInDegrees(self.circleCenter, self.rightcropImageview.center, self.circleCenter, nowPoint);
        self.rightImageview.alpha=1.0;
        self.rightcropImageview.alpha=1.0 ;
    
        if (!self.xrayOff)
        {
            self.cascadeImageview.alpha=0.6;
            self.cascadeImageviewRight.alpha=0.6;
         }
        
        
        
        if ((self.rightcropImageview.center.x>240 && self.rightcropImageview.center.x<290.0) && self.rightcropImageview.center.y>260 && self.rightcropImageview.center.y<300)             {
            _collimatorOverlapped_rightcropView=YES ;
        }
        
        else
        {
            
            _collimatorOverlapped_rightcropView=NO ;
        }
        
        
        
        
        // fix value, if the 12 o'clock position is between prevPoint and nowPoint
        if (angle > 180)
        {
            angle -= 360;
        }
        else if (angle < -180)
        {
            angle += 360;
        }
        
        // sum up single steps
        rightcroplineAngle += angle;
        
        
        self.rightcropImageview.center=nowPoint ;
        self.rightImageview.center=nowPoint ;
        
    
        if (nowPoint.x<self.circleCenter.x) {
            
            if (!self.xrayOff)
            {
                self.cascadeImageviewRight.center=nowPoint ;
            }
            
        }
        
        else
        {
            if (!self.xrayOff)
            {
                self.cascadeImageviewRight.center=nowPoint ;
            }
            
        }
        self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
        self.rightImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
        
        thetaoangleRight=rightcroplineAngle ;
        if (!self.xrayOff)
        {
            self.cascadeImageviewRight.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
        }
    
    
    
}

-(void)leftShutter_movedOutsideCircle:(CGPoint)prevpoint andnowPointis:(CGPoint)nowPoint
{
    
    CGPoint point1 ;
    _showcollimator=NO;
    rotatingviewtouched=NO ;
    onlyonce=NO ;
    point1=self.leftImageview.center ;
    
    
    if ((self.leftcropImageview.center.x>240 && self.leftcropImageview.center.x<290.0) && self.leftcropImageview.center.y>260 && self.leftcropImageview.center.y<300)
    {
        _collimatorOverlapped_leftcropView=YES ;
    }
    
    else
    {
        
        _collimatorOverlapped_leftcropView=NO ;
    }
    
    CGPoint point;
    point=self.circleCenter ;
    point.x =self.circleCenter.x -(226+25);
    CGFloat y1,y2 ;
    
    y1 = self.circleCenter.x - (226+25);
    y2 = self.circleCenter.y + (226+25);
    
    
    CGFloat slope =[self slopeOFline:nowPoint and:self.circleCenter];
    
    CGPoint pointOnCircle ;
    
    int radius = 226+25 ;
    
    pointOnCircle.y = ((slope*radius)/sqrt(slope*slope +1)) + self.circleCenter.y ;
    
    pointOnCircle.x = ((pointOnCircle.y - self.circleCenter.y)/slope) + self.circleCenter.x ;
    
    if (nowPoint.y==self.circleCenter.y && nowPoint.x<self.circleCenter.x)
    {
        pointOnCircle.x = self.circleCenter.x-radius ;
        pointOnCircle.y = self.circleCenter.y ;
    }
    
    else if (nowPoint.y==self.circleCenter.y && nowPoint.x>self.circleCenter.x)
    {
        pointOnCircle.x = self.circleCenter.x+radius ;
        pointOnCircle.y = self.circleCenter.y ;
        
    }
    
    else if (nowPoint.x==self.circleCenter.x && nowPoint.y<self.circleCenter.y)
    {
        pointOnCircle.x = self.circleCenter.x ;
        pointOnCircle.y = self.circleCenter.y-radius ;
        
    }
    
    else if (nowPoint.x==self.circleCenter.x && nowPoint.y>self.circleCenter.y)
    {
        pointOnCircle.x = self.circleCenter.x ;
        pointOnCircle.y = self.circleCenter.y+radius ;
        
    }
    
    else if (nowPoint.x < self.circleCenter.x && nowPoint.y<self.circleCenter.y)
    {
        
        pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
        pointOnCircle.y =  self.circleCenter.y-((slope*radius)/sqrt(slope*slope +1))  ;
        
    }
    
    else if(nowPoint.x < self.circleCenter.x && nowPoint.y>self.circleCenter.y)
    {
        pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
        pointOnCircle.y =  self.circleCenter.y -((slope*radius)/sqrt(slope*slope +1))  ;
        
    }
    
    
    self.leftcropImageview.center=pointOnCircle ;
    self.leftImageview.center=pointOnCircle ;
    
    
    CGFloat angle = angleBetweenLinesInDegrees(self.circleCenter, point1, self.circleCenter, self.leftImageview.center);
    
    
    
    if (angle > 180)
    {
        angle -= 360;
    }
    else if (angle < -180)
    {
        angle += 360;
    }
    
    leftcroplineAngle+=angle ;
    
    self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
    self.leftImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
    thetaangleLeft=leftcroplineAngle ;
    
    if (couplingshuttersON)
    {
        
        
        pointOnCircle.y = ((slope*radius)/-sqrt(slope*slope +1)) + self.circleCenter.y ;
        
        pointOnCircle.x = ((pointOnCircle.y - self.circleCenter.y)/slope) + self.circleCenter.x ;
        
        if (nowPoint.y==self.circleCenter.y && nowPoint.x<self.circleCenter.x)
        {
            pointOnCircle.x = self.circleCenter.x+radius ;
            pointOnCircle.y = self.circleCenter.y ;
        }
        
        else if (nowPoint.y==self.circleCenter.y && nowPoint.x>self.circleCenter.x)
        {
            pointOnCircle.x = self.circleCenter.x-radius ;
            pointOnCircle.y = self.circleCenter.y ;
            
        }
        
        else if (nowPoint.x==self.circleCenter.x && nowPoint.y<self.circleCenter.y)
        {
            pointOnCircle.x = self.circleCenter.x ;
            pointOnCircle.y = self.circleCenter.y+radius ;
            
        }
        
        else if (nowPoint.x==self.circleCenter.x && nowPoint.y>self.circleCenter.y)
        {
            pointOnCircle.x = self.circleCenter.x ;
            pointOnCircle.y = self.circleCenter.y-radius ;
            
        }
        
        else if (nowPoint.x < self.circleCenter.x && nowPoint.y<self.circleCenter.y)
        {
            
            pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
            pointOnCircle.y =  self.circleCenter.y-((slope*radius)/-sqrt(slope*slope +1))  ;
            
        }
        
        else if(nowPoint.x < self.circleCenter.x && nowPoint.y>self.circleCenter.y)
        {
            pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
            pointOnCircle.y =  self.circleCenter.y-((slope*radius)/-sqrt(slope*slope +1))  ;
            
        }
        
        self.rightcropImageview.center=pointOnCircle ;
        self.rightImageview.center=pointOnCircle ;
        
        self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
        self.rightImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
        
        rightcroplineAngle=leftcroplineAngle ;
        
    }
    self.leftcropImageview.image=[UIImage imageNamed:@"iris_shutter_yellow_left.png"];
    self.leftImageview.image=[UIImage imageNamed:@"shutter_line_yellow_right.png"];
    

}

-(void)rightShutter_movedOutsideCircle:(CGPoint)prevpoint andnowPointis:(CGPoint)nowPoint
{
    self.rightcropImageview.image=[UIImage imageNamed:@"iris_shutter_yellow_right.png"];
    self.rightImageview.image=[UIImage imageNamed:@"shutter_line_yellow_left.png"];
    
    CGPoint point1 ;
    rotatingviewtouched=NO ;
    
    point1=self.rightImageview.center ;
    _showcollimator=NO;
    onlyonce=NO ;
    
    
    if ((self.rightcropImageview.center.x>240 && self.rightcropImageview.center.x<290.0) && self.rightcropImageview.center.y>260 && self.rightcropImageview.center.y<300)
    {
        _collimatorOverlapped_rightcropView=YES ;
    }
    
    else
    {
        
        _collimatorOverlapped_rightcropView=NO ;
    }
    
    
    CGFloat slope =[self slopeOFline:nowPoint and:self.circleCenter];
    
    
    CGPoint pointOnCircle ;
    
    int radius = 226+25 ;
    
    pointOnCircle.y = ((slope*radius)/sqrt(slope*slope +1)) + self.circleCenter.y ;
    
    pointOnCircle.x = ((pointOnCircle.y - self.circleCenter.y)/slope) + self.circleCenter.x ;
    
    if (nowPoint.y==self.circleCenter.y && nowPoint.x<self.circleCenter.x)
    {
        pointOnCircle.x = self.circleCenter.x-radius ;
        pointOnCircle.y = self.circleCenter.y ;
    }
    
    else if (nowPoint.y==self.circleCenter.y && nowPoint.x>self.circleCenter.x)
    {
        pointOnCircle.x = self.circleCenter.x+radius ;
        pointOnCircle.y = self.circleCenter.y ;
        
    }
    
    else if (nowPoint.x==self.circleCenter.x && nowPoint.y<self.circleCenter.y)
    {
        pointOnCircle.x = self.circleCenter.x ;
        pointOnCircle.y = self.circleCenter.y-radius ;
        
    }
    
    else if (nowPoint.x==self.circleCenter.x && nowPoint.y>self.circleCenter.y)
    {
        pointOnCircle.x = self.circleCenter.x ;
        pointOnCircle.y = self.circleCenter.y+radius ;
        
    }
    
    
    else if (nowPoint.x < self.circleCenter.x && nowPoint.y<self.circleCenter.y)
    {
        
        pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
        pointOnCircle.y =  self.circleCenter.y-((slope*radius)/sqrt(slope*slope +1))  ;
        
    }
    
    else if(nowPoint.x < self.circleCenter.x && nowPoint.y>self.circleCenter.y)
    {
        pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
        pointOnCircle.y =  self.circleCenter.y -((slope*radius)/sqrt(slope*slope +1))  ;
        
    }
    
    self.rightcropImageview.center=pointOnCircle ;
    self.rightImageview.center=pointOnCircle ;
    
    
    CGFloat angle = angleBetweenLinesInDegrees(self.circleCenter, point1, self.circleCenter, self.rightImageview.center);
    
    
    
    if (angle > 180)
    {
        angle -= 360;
    }
    else if (angle < -180)
    {
        angle += 360;
    }
    
    rightcroplineAngle+=angle ;
    
    self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
    self.rightImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
    
    thetaoangleRight=rightcroplineAngle ;
    
    
    if (couplingshuttersON)
    {
        
        
        pointOnCircle.y = ((slope*radius)/-sqrt(slope*slope +1)) + self.circleCenter.y ;
        
        pointOnCircle.x = ((pointOnCircle.y - self.circleCenter.y)/slope) + self.circleCenter.x ;
        
        if (nowPoint.y==self.circleCenter.y && nowPoint.x<self.circleCenter.x)
        {
            pointOnCircle.x = self.circleCenter.x+radius ;
            pointOnCircle.y = self.circleCenter.y ;
        }
        
        else if (nowPoint.y==self.circleCenter.y && nowPoint.x>self.circleCenter.x)
        {
            pointOnCircle.x = self.circleCenter.x-radius ;
            pointOnCircle.y = self.circleCenter.y ;
            
        }
        
        else if (nowPoint.x==self.circleCenter.x && nowPoint.y<self.circleCenter.y)
        {
            pointOnCircle.x = self.circleCenter.x ;
            pointOnCircle.y = self.circleCenter.y+radius ;
            
        }
        
        else if (nowPoint.x==self.circleCenter.x && nowPoint.y>self.circleCenter.y)
        {
            pointOnCircle.x = self.circleCenter.x ;
            pointOnCircle.y = self.circleCenter.y-radius ;
            
        }
        
        else if (nowPoint.x < self.circleCenter.x && nowPoint.y<self.circleCenter.y)
        {
            
            pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
            pointOnCircle.y =  self.circleCenter.y-((slope*radius)/-sqrt(slope*slope +1))  ;
            
        }
        
        else if(nowPoint.x < self.circleCenter.x && nowPoint.y>self.circleCenter.y)
        {
            pointOnCircle.x =  self.circleCenter.x-((pointOnCircle.y - self.circleCenter.y)/slope)  ;
            pointOnCircle.y =  self.circleCenter.y-((slope*radius)/-sqrt(slope*slope +1))  ;
            
        }
        
        self.leftcropImageview.center=pointOnCircle ;
        self.leftImageview.center=pointOnCircle ;
        
        self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
        self.leftImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
        
        leftcroplineAngle=rightcroplineAngle ;
    }//if coupling is on
    
}

-(void)rotateview_oncircleView_dragged:(CGPoint)nowPoint
{
    _showcollimator=NO;
    rotatingviewtouched=YES ;
    CGFloat angle = angleBetweenLinesInDegrees(self.circleCenter, self.rotate_circle_view.center, self.circleCenter, nowPoint);
    self.rotate_circle_view.image=[UIImage imageNamed:@"rotating_symbol_yellow.png"];
    
    
        if (angle > 180)
        {
            angle -= 360;
        }
        else if (angle < -180)
        {
            angle += 360;
        }
        cumulatedAngle += angle;
        
    
    
    // sum up single steps
    
    //To determine if the collimator and rotating view collide
    
    int quotient = cumulatedAngle/360 + 1;
    
    int product = 360*quotient ;
    
    int lowerLimit = product-40 ;
    int upperlimit = product-20 ;
    
    if (cumulatedAngle>lowerLimit && cumulatedAngle<upperlimit)
    {
        
        _collimatorOverlapped=YES ;
        
        
    }
    
    else
    {
        
        _collimatorOverlapped=NO;
    }
    
    self.rotate_circle_view.alpha=1.0;
    
    self.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0) ;
    self.rotate_circle_view.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle),0.0, 0.0, 1.0);
    
    self.number12.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle),0.0, 0.0, 1.0);
    
    self.number3.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle),0.0, 0.0, 1.0);
    
    self.number9.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle),0.0, 0.0, 1.0);
    
    self.number6.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle),0.0, 0.0, 1.0);
    
    if (mirror) {
        self.number12.layer.transform =CATransform3DRotate(self.number12.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.number9.layer.transform =CATransform3DRotate(self.number9.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.number3.layer.transform =CATransform3DRotate(self.number3.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.number6.layer.transform =CATransform3DRotate(self.number6.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
    }
    
    if (flip) {
        self.number12.layer.transform =CATransform3DRotate(self.number12.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        self.number9.layer.transform =CATransform3DRotate(self.number9.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        self.number3.layer.transform =CATransform3DRotate(self.number3.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        self.number6.layer.transform =CATransform3DRotate(self.number6.layer.transform, angle_flip, 1.0, 0.0, 0.0);
    }

    
}

-(void)toucheEnd_ResetBooleanValues
{
    rotatingviewtouched=NO ;
    _leftviewtouched=NO;
    _rightviewtouched=NO;
    _showcollimator=YES;
    
    _collimator_leftview=NO;
    _collimator_rightview=NO;

    
}

-(void)changealphaValues
{
    self.leftImageview.alpha=0.7;
    self.rightImageview.alpha=0.7 ;
    
    BOOL check1 =[self checkOutsideCircle_Bounds:self.leftcropImageview.center] ;
    BOOL check2 =[self checkOutsideCircle_Bounds:self.rightcropImageview.center] ;
    
    if (check1)
    {
        self.leftcropImageview.alpha=0.6 ;
    }
    
    else
    {
        self.leftcropImageview.alpha=1.0 ;
    }
    
    
    if (check2)
    {
        self.rightcropImageview.alpha=0.6 ;
    }
    
    else
    {
        self.rightcropImageview.alpha=1.0 ;
        
    }
    
    
    //  self.controller.collinator.alpha=1.0;
    self.rotate_circle_view.alpha=0.6;
    
    
    if (self.leftcropImageview.center.x==self.rightcropImageview.center.x && self.leftcropImageview.center.y==self.rightcropImageview.center.y )
    {
        right_lastTouched=NO ;
        left_lastTouched=YES ;
    }
    else
    {
        right_lastTouched=YES ;
        left_lastTouched=YES ;
    }
    
}


#pragma mark - UIGestureRecognizer implementation


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesBegan:touches withEvent:event];
   Pointin_standuiView  = [[touches anyObject] locationInView: self];
    if (!_questionmarkPressed)
    {
        
        // ////Nslog(@"NOWPOINT VALUES ARE %f  %f",nowPoint.x,nowPoint.y);
    //[self reset];
    _leftviewtouched=NO;
        
        
    for(UIView *subview in [self subviews])
    {
        if(CGRectContainsPoint(subview.frame, Pointin_standuiView))
        {
            
            
            if (subview==self.rotate_circle_view)
            {
                
                rotatingviewtouched=YES ;
                
                if(!onlyonce)
                {
                CGPoint prevpoint = [[touches anyObject] locationInView:self.controller.mainView];
                    
                    [self initialRightCropPOsition:prevpoint];
                    [self initialLeftCropPOsition:prevpoint] ;
                

                }
            
               
            }
            
            
            
            
            else if (subview==self.leftcropImageview)
            {
                
                old_X=Pointin_standuiView.x;
                old_Y=Pointin_standuiView.y;
                
                ////Nslog(@"oldx and oldy are %f   %f",old_X,old_Y);
                _leftviewtouched=YES;
                
            }
            
            else if(subview==self.rightcropImageview)
            {
                _rightviewtouched=YES;
                
            }
            
        }
    }

    }
    
    else
    {
        
    }
    
   }

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_questionmarkPressed)
    {
        [super touchesMoved:touches withEvent:event];
        BOOL check ;
        
        CGPoint nowPoint  = [[touches anyObject] locationInView: self];
        
        NSLog(@"NOWPOINT VALUES ARE %f  %f",nowPoint.x,nowPoint.y);
        presentpoint=nowPoint;
        CGFloat lhs = (nowPoint.x-self.circleCenter.x)*(nowPoint.x-self.circleCenter.x)+(nowPoint.y-self.circleCenter.y)*(nowPoint.y-self.circleCenter.y);
        CGFloat rhs =(self.bounds.size.width*0.3+53-25)*(self.bounds.size.width*0.3+53-25) ;

        if (lhs>rhs)
        {
            check=NO;
        }
        
        else
        {
            check=YES;
        }
        
        
                if (check) // if the touch is inside the circle bounds
                {
                    
                    
                    if (couplingshuttersON)
                    {
                        
                        
                        CGFloat lhs = (nowPoint.x-self.circleCenter.x)*(nowPoint.x-self.circleCenter.x)+(nowPoint.y-self.circleCenter.y)*(nowPoint.y-self.circleCenter.y);
                        CGFloat rhs =(self.bounds.size.width*0.3+53-25)*(self.bounds.size.width*0.3+53-25) ;
                        
                          [self manageComponents:lhs Righthandside:rhs andCurrenttouchPoint:nowPoint];

                        
                    }  //END OF COUPLING SHUTTERS
                    
                    
                    
                   
                    else
                    {
                        
                        if(_leftviewtouched && left_lastTouched && !self.controller.collinatorTouched)
                        {
                        
                             [self leftshutter_moved:nowPoint];
                        }
                        
                        else if(_rightviewtouched && right_lastTouched && !self.controller.collinatorTouched)
                        {
                        
                            [self rightshutter_moved:nowPoint] ;
                        }
                        
                    }
                    
                    
                }//when touch is inside the circle
                
                else
                {
                    
                    if (_leftviewtouched && !self.controller.collinatorTouched)
                    {
                        
                        CGPoint prevpoint = [[touches anyObject] locationInView:self.controller.mainView];
                        [self CheckIsItemOverlapsOnToolbar:prevpoint];
                        
                        [self leftShutter_movedOutsideCircle:prevpoint andnowPointis:nowPoint];
                    }
                    
                    
                    else if(_rightviewtouched && !self.controller.collinatorTouched)
                    {
                        
                        CGPoint prevpoint = [[touches anyObject] locationInView:self.controller.mainView];
                        [self CheckIsItemOverlapsOnToolbar:prevpoint];
                        
                       [self rightShutter_movedOutsideCircle:prevpoint andnowPointis:nowPoint];
                       
                    }
                    
                    
               }//when the touch is outside the circle bounds
        
        
        
        if (rotatingviewtouched)
            
        {
            [self rotateview_oncircleView_dragged:nowPoint];
            
            CGPoint prevpoint = [[touches anyObject] locationInView:self.controller.mainView];
            
            [self CheckIsItemOverlapsOnToolbar:prevpoint];
        
        } //when rotationview pressed
        
    }
}




- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.leftImageview.image=[UIImage imageNamed:@"shutter_line_white_right.png"];
    self.rightImageview.image=[UIImage imageNamed:@"shutter_line_white_left.png"];
    self.rotate_circle_view.image=[UIImage imageNamed:@"resrt-act2x.png"];
    
    // for rotating control check is it lying on any of imaginatory view.
    CGPoint prevpoint = [[touches anyObject] locationInView:self.controller.mainView];
    if( _leftviewtouched)
    {
        overlapExists = NO;
       [self isOverLappingOnNavigationButton:prevpoint];
        if( !overlapExists)
        {
            left_shutter_layered_onBtn = -1;
            self.leftcropImageview.image=[UIImage imageNamed:@"iris_shutter_gray_left.png"];
            self.leftcropImageview.alpha = 0.6;
        }
        else
        {
            self.leftcropImageview.image=[UIImage imageNamed:@"arrow2_white.png"];
            self.leftcropImageview.alpha = 1.0;
        }
    }
    else if(_rightviewtouched)
    {
        overlapExists = NO;
        [self isOverLappingOnNavigationButton:prevpoint]; // Right
        if( !overlapExists)
        {
            right_shutter_layered_onBtn =-1;
            self.rightcropImageview.image=[UIImage imageNamed:@"iris_shutter_gray_right.png"];
            self.rightcropImageview.alpha = 0.6;
        }
        else
        {
            self.rightcropImageview.image=[UIImage imageNamed:@"arrow1_white.png"];
            self.rightcropImageview.alpha = 1.0;
        }
        
    }
    if( rotatingviewtouched)
    {
        overlapExists = NO;
        pointon_MainView = [[touches anyObject] locationInView:self.controller.mainView];
        
        [self isOverLappingOnNavigationButton:prevpoint];
        
        if( !overlapExists)
        {
            rotating_Symbol_layered_onBtn = -1;
        }
        // Calculate the left and right shutter position
        
        [self rightcropViewinMainView];
        [self leftcropViewinMainView];
        
        _rightviewtouched=YES;
        overlapExists = NO;
        [self isOverLappingOnNavigationButton:mainViewleftShutterCenter]; // Right
        if( !overlapExists)
        {
            right_shutter_layered_onBtn =-1;
            self.rightcropImageview.image=[UIImage imageNamed:@"iris_shutter_gray_right.png"];
            self.rightcropImageview.alpha = 0.6;
        }
        else
        {
            self.rightcropImageview.image=[UIImage imageNamed:@"arrow1_white.png"];
            self.rightcropImageview.alpha = 1.0;
        }
        
        _rightviewtouched=NO;
        
        _leftviewtouched=YES;
        overlapExists = NO;
        [self isOverLappingOnNavigationButton:mainViewleftShutterCenterLeft]; // left
        if( !overlapExists)
        {
            left_shutter_layered_onBtn = -1;
            self.leftcropImageview.image=[UIImage imageNamed:@"iris_shutter_gray_left.png"];
            self.leftcropImageview.alpha = 0.6;
        }
        else
        {
            self.leftcropImageview.image=[UIImage imageNamed:@"arrow2_white.png"];
            self.leftcropImageview.alpha = 1.0;
        }
        
        _leftviewtouched=NO;
    }
    
    [self toucheEnd_ResetBooleanValues];
    
    
    [self changealphaValues];
    
    
    [self removeImaginarySubViews];
    [self EnableNonOverLapViews];

}


-(void)leftcropViewinMainView
{
    CGPoint circleCenterPoint = CGPointMake(543.500000, 347.000000) ;
    
    
    CGFloat distance = distanceBetweenPoints(mainViewleftShutterCenterLeft, circleCenterPoint) ;
    
    CGPoint mainViewleftShutterCenter1;
    
    NSLog(@"MAIN CUMULATIVE ANGLE IS %f",thetaangleLeft);
    thetaangleLeft =leftcroplineAngle + cumulatedAngle ;
    
    mainViewleftShutterCenter1.x = circleCenterPoint.x -distance*cos(DEGREES_TO_RADIANS(thetaangleLeft));
    mainViewleftShutterCenter1.y = circleCenterPoint.y- distance*sin(DEGREES_TO_RADIANS(thetaangleLeft));
    
    thetaangleLeft=0;
    
    for (UIView *subview in [self.controller.mainView subviews])
    {
        if (subview.tag==23)
        {
            [subview removeFromSuperview];
        }
    }

    mainViewleftShutterCenterLeft=mainViewleftShutterCenter1 ;
    
    
}

-(void)rightcropViewinMainView
{
    
    CGPoint circleCenterPoint = CGPointMake(543.500000, 347.000000) ;
    CGFloat distance = distanceBetweenPoints(mainViewleftShutterCenter, circleCenterPoint) ;
    CGPoint mainViewleftShutterCenter1;
    
    NSLog(@"MAIN CUMULATIVE ANGLE IS %f",thetaoangleRight);
    thetaoangleRight =rightcroplineAngle + cumulatedAngle ;
    
    mainViewleftShutterCenter1.x = circleCenterPoint.x +distance*cos(DEGREES_TO_RADIANS(thetaoangleRight));
    mainViewleftShutterCenter1.y = circleCenterPoint.y+ distance*sin(DEGREES_TO_RADIANS(thetaoangleRight));
    
    thetaoangleRight=0;
    
    for (UIView *subview in [self.controller.mainView subviews])
    {
        if (subview.tag==22)
        {
            [subview removeFromSuperview];
        }
    }
    mainViewleftShutterCenter=mainViewleftShutterCenter1 ;
    
}

-(void)initialRightCropPOsition:(CGPoint) prevpoint
{
    CGFloat slope = [self slopeOFline:self.rotate_circle_view.center and:self.rightcropImageview.center];
    
    distanceright = distanceBetweenPoints(self.rotate_circle_view.center, self.rightcropImageview.center) ;
    
    onlyonce=YES ;
    
    mainViewleftShutterCenter.y = ((slope*distanceright)/sqrt(slope*slope +1)) + prevpoint.y ;
    
    mainViewleftShutterCenter.x = ((mainViewleftShutterCenter.y - prevpoint.y)/slope) + prevpoint.x ;
    
    NSLog(@"The center of the left shutter in main view is %f %f",mainViewleftShutterCenter.x,mainViewleftShutterCenter.y);
    
    for (UIView *subview in [self.controller.mainView subviews])
    {
        if (subview.tag==22)
        {
            [subview removeFromSuperview];
        }
    }
    
}

-(void)initialLeftCropPOsition:(CGPoint) prevpoint
{
    CGFloat slope = [self slopeOFline:self.rotate_circle_view.center and:self.leftcropImageview.center];
    
    distanceleft = distanceBetweenPoints(self.rotate_circle_view.center, self.leftcropImageview.center) ;
    
    onlyonce=YES ;
        mainViewleftShutterCenterLeft.y =  prevpoint.y-((slope*distanceleft)/sqrt(slope*slope +1))  ;
    
    mainViewleftShutterCenterLeft.x =  prevpoint.x -((mainViewleftShutterCenterLeft.y - prevpoint.y)/slope)  ;

    
    
    
    for (UIView *subview in [self.controller.mainView subviews])
    {
        if (subview.tag==23)
        {
            [subview removeFromSuperview];
        }
    }
    
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
    //[super touchesCancelled:touches withEvent:event
}

-(void)CheckIsItemOverlapsOnToolbar:(CGPoint)prevpoint
{
    int xPos =390;
    int Width = 75;
    if( ! navigationshadowViewsExists)
    {
        navigationshadowViews = [[NSMutableArray alloc] init];
        navigationshadowViewsExists = YES;
        for(int i=0;i<4;i++)
        {
            if( i==0 )
            {
                xPos=185;
                Width = 300;
            }
            else if(i==1)
            {
                xPos = 485;
                Width = 75;
            }
            else if(i==2)
            {
                xPos = 560;
                Width = 75;
            }
            else if (i==3)
            {
                xPos = 635;
                Width = 300;
            }
            UIView *tempview = [[UIView alloc] initWithFrame:CGRectMake(xPos, 575, Width, 500)];
            tempview.tag=0x100;
            tempview.backgroundColor = [UIColor clearColor];
            [navigationshadowViews addObject:tempview];
            NoofObjectsOnEachBtn[i] = 0;
            [self.controller.mainView addSubview:tempview] ;
            
           // xPos = xPos +TOOLBARBUTTONWIDTH;
        }
    }
    // send all the buttons to back
    [self DisableAllnavigationButtons];
    
    [self isOverLappingOnNavigationButton:prevpoint];
    
}


-(void)DisableAllnavigationButtons
{
    [self.controller.mainView sendSubviewToBack:self.imageNavigationtoolbar.prevButtonView];
    [self.controller.mainView sendSubviewToBack:self.imageNavigationtoolbar.RunButtonView];
    [self.controller.mainView sendSubviewToBack:self.imageNavigationtoolbar.overviewButtonView];
    [self.controller.mainView sendSubviewToBack:self.imageNavigationtoolbar.nextButtonView];
}

-(void)EnableAllnavigationButtons
{
    [self.controller.mainView bringSubviewToFront:self.imageNavigationtoolbar.prevButtonView];
    [self.controller.mainView bringSubviewToFront:self.imageNavigationtoolbar.RunButtonView];
    [self.controller.mainView bringSubviewToFront:self.imageNavigationtoolbar.overviewButtonView];
    [self.controller.mainView bringSubviewToFront:self.imageNavigationtoolbar.nextButtonView];

}

-(void)isOverLappingOnNavigationButton:(CGPoint)prevpoint
{
    for(int i=PREVIOUSBUTTON;i<=NEXTBUTTON;i++)
    {
        CGRect rect = [[navigationshadowViews objectAtIndex:i] frame]; // objects in array are in the order of Prev,Run,OVerview and Next. There is a 1-1 MAp from arrayinex to for loop
     //   [[navigationshadowViews objectAtIndex:i] setBackgroundColor:[UIColor clearColor]];
        if (CGRectContainsPoint(rect, prevpoint))
        {
            overlapExists = YES;
             switch (i) {
                case PREVIOUSBUTTON:
                    [self.controller.mainView sendSubviewToBack:self.imageNavigationtoolbar.prevButtonView];
                    [self UpdateTheButtonLayerPos:PREVIOUSBUTTON];
                    break;
                case RUNBUTTON:
                    [self.controller.mainView sendSubviewToBack:self.imageNavigationtoolbar.RunButtonView];
                    [self UpdateTheButtonLayerPos:RUNBUTTON];
                    break;
                case OVERVIEWBUTTON:
                    [self.controller.mainView sendSubviewToBack:self.imageNavigationtoolbar.overviewButtonView];
                        [self UpdateTheButtonLayerPos:OVERVIEWBUTTON];
                    break;
                case NEXTBUTTON:
                    [self.controller.mainView sendSubviewToBack:self.imageNavigationtoolbar.nextButtonView];
                    [self UpdateTheButtonLayerPos:NEXTBUTTON];
                    break;
                default:
                    break;
            }
            
        }
    }
}

 -(void) UpdateTheButtonLayerPos:(NSInteger)val
{
    NSLog(@"Button idx %ld\n",(long)val);
    if(rotatingviewtouched)
    {
        rotating_Symbol_layered_onBtn = val;
    }
    else if( _leftviewtouched)
    {
        left_shutter_layered_onBtn = val;
    }
    else if(_rightviewtouched)
    {
        right_shutter_layered_onBtn = val;
    }
}

-(void)EnableNonOverLapViews
{
    for(int i=PREVIOUSBUTTON;i<=NEXTBUTTON;i++) // 4 Buttons
    {
        if(!(rotating_Symbol_layered_onBtn == i || left_shutter_layered_onBtn == i || right_shutter_layered_onBtn == i))
            switch (i) {
                case PREVIOUSBUTTON:
                    [self.controller.mainView bringSubviewToFront:self.imageNavigationtoolbar.prevButtonView];
                    break;
                case RUNBUTTON:
                    [self.controller.mainView bringSubviewToFront:self.imageNavigationtoolbar.RunButtonView];
                    break;
                case OVERVIEWBUTTON:
                    [self.controller.mainView bringSubviewToFront:self.imageNavigationtoolbar.overviewButtonView];
                    break;
                case NEXTBUTTON:
                    [self.controller.mainView bringSubviewToFront:self.imageNavigationtoolbar.nextButtonView];
                    break;
                default:
                    break;
            }
    }
    
}

-(void)removeImaginarySubViews
{
    if( navigationshadowViewsExists )
    {
        for (UIView *subview in [self.controller.mainView subviews])
        {
            
            if (subview.tag==0x100)
            {
                navigationshadowViewsExists = NO;
                [subview removeFromSuperview];
            }
        }
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    [self createMaskLayer];
    
    rotatingviewtouched=NO ;
        [self createCircleShapeLayer];
    
    [self createboundingCircleShapeLayer:self.bounds.size.width*0.30];

    [self updateCirclePathAtLocation:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:226.0];
    
    self.imageView.frame=CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 226*2, 226*2);
    
     self.imageView.center=CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    _showcollimator=NO ;
    
    [self createRotatingSymbol];
    [self createCropLines];
    
   
    [self hideIndicators];
    [self removeGestureRecognizer:self.pinch];
    
    [self CreateScrollView];
    scrollpanel.hidden=YES ;
    
    scrollpanel.scrolldelegate=self ;
    
}

#pragma mark - Reset Indicators/Hide(Unhide) implementation
-(void)hideIndicators
{
    self.imageView.hidden=YES ;
    self.leftImageview.hidden=YES;
    self.rightImageview.hidden=YES;
    
    self.leftcropImageview.hidden=YES;
    self.rightcropImageview.hidden=YES ;
    self.cascadeImageview.hidden=YES;
    self.cascadeImageviewRight.hidden=YES;
    
    self.controller.collinator.hidden=YES;
    self.controller.collinator.userInteractionEnabled=NO;
    self.noImage.hidden=YES;

}

-(void)hideClearGuideIndicators
{
    
    self.number12.hidden=YES;
    self.number3.hidden=YES ;
    self.number6.hidden=YES ;
    self.number9.hidden=YES ;
}

-(void)unhideClearGuideIndicators
{
    self.number12.hidden=NO;
    self.number3.hidden=NO ;
    self.number6.hidden=NO ;
    self.number9.hidden=NO ;
}

-(void)unhideIndicators
{
    self.leftImageview.hidden=NO;
    self.rightImageview.hidden=NO;
    self.controller.collinator.hidden=NO;
    self.controller.collinator.userInteractionEnabled=YES;
    self.leftcropImageview.hidden=NO;
    self.rightcropImageview.hidden=NO ;
    self.imageView.hidden=NO;
    self.cascadeImageview.hidden=NO;
    self.cascadeImageviewRight.hidden=NO;
    self.noImage.hidden=NO;
}

-(void)HideOrUnhideIndicators:(BOOL)val
{
    self.leftImageview.hidden=val;
    self.rightImageview.hidden=val;
    self.controller.collinator.hidden=val;
    self.controller.collinator.userInteractionEnabled=!val;
    self.leftcropImageview.hidden=val;
    self.rightcropImageview.hidden=val;
    self.rotate_circle_view.hidden=val;
}

-(void)resetIndicators
{
    self.imageView.hidden=YES ;
    [self.leftImageview removeFromSuperview]  ;
    self.leftImageview=nil ;
    [self.rightImageview removeFromSuperview] ;
    self.rightImageview=nil ;
    
    [self.leftcropImageview removeFromSuperview] ;
    self.leftcropImageview=nil ;
    
    [self.rightcropImageview removeFromSuperview];
    self.rightcropImageview=nil ;
    
    self.controller.collinator.hidden=YES;
    self.controller.collinator.userInteractionEnabled=NO;
    
    [self.cascadeImageview removeFromSuperview];
    self.cascadeImageview = nil ;
    [self.cascadeImageviewRight removeFromSuperview];
    self.cascadeImageviewRight =nil ;
    
    [self.rotate_circle_view removeFromSuperview];
    self.rotate_circle_view=nil;
    cumulatedAngle=0.0;
    
    self.noImage.hidden=YES;
    self.controller.collinator.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(-30), 0.0, 0.0, 1.0);
    self.controller.count1=-30 ;
}


-(void)allignshutters
{
    cumulatedAngle=0 ;
    leftcroplineAngle=0;
    rightcroplineAngle =0;
    
    self.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.number12.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.number3.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.number6.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.number9.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.leftImageview.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    self.rightImageview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.cascadeImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.cascadeImageviewRight.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
}


-(void)resettheShutters
{
    rightcroplineAngle=-cumulatedAngle;
    leftcroplineAngle=-cumulatedAngle;
    
    self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.leftImageview.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle), 0.0, 0.0, 1.0);
    
    self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle), 0.0, 0.0, 1.0);
    self.rightImageview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle), 0.0, 0.0, 1.0);
    if (!_xrayOff)
    {
          self.cascadeImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle), 0.0, 0.0, 1.0);
        
          self.cascadeImageviewRight.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(-cumulatedAngle), 0.0, 0.0, 1.0);
    }
  
    self.controller.collinator.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(-30), 0.0, 0.0, 1.0);
    self.controller.count1=-30;
    
}


- (IBAction)positionMemoryButtonCLicked:(id)sender
{
    positionbuttonclicked=!positionbuttonclicked;
    
    if (positionbuttonclicked== NO)
    {
        if ((currentSystemMode == NOIMAGE) || (currentSystemMode == LIVE) || (currentSystemMode == LIHMODE))
        {
             self.circleLayer.strokeColor=[[UIColor grayColor]CGColor];
        }
        else
        {
             self.circleLayer.strokeColor=[[UIColor clearColor]CGColor];
        }
       
       if((XRayImageExists == YES) &&  (self.imageNavigationtoolbar.imageReviewMode == NO))
       {
            [self HideOrUnhideIndicators:NO];
       }

        if (!hidden && _imageNavigationtoolbar.imageReviewMode == NO )
        {
            self.leftcropImageview.hidden=NO;
            self.leftImageview.hidden=NO;
            self.rightcropImageview.hidden=NO;
            self.rightImageview.hidden=NO;
            self.rotate_circle_view.hidden=NO;
            self.controller.collinator.hidden=NO ;
            self.controller.collinator.userInteractionEnabled=YES;
            self.statusImage.hidden=NO ;
            self.cascadeImageview.hidden=NO;
            self.cascadeImageviewRight.hidden=NO;

        }
        else
        {
            if(self.imageNavigationtoolbar.imageReviewMode == NO)
            {
                self.rotate_circle_view.hidden=NO;
            }
        }
    }
    else
    {
        self.circleLayer.strokeColor=[[UIColor clearColor]CGColor];
        if (!self.leftcropImageview.hidden)
        {
            hidden=NO ;
            self.leftcropImageview.hidden=YES;
            self.leftImageview.hidden=YES;
            self.rightcropImageview.hidden=YES;
            self.rightImageview.hidden=YES;
            self.rotate_circle_view.hidden=YES;
            self.controller.collinator.hidden=YES ;
            self.controller.collinator.userInteractionEnabled=NO;
            self.statusImage.hidden=YES ;
        }
        else
        {
            hidden=YES ;
            self.rotate_circle_view.hidden=YES;
        }
   
        
    }
    
   
    
}


#pragma mark - BottomPanel implementation

-(IBAction)clearGuidePressed:(id)sender
{
    self.clearGuideButtonSelected=!self.clearGuideButtonSelected ;
    
    if (self.clearGuideButtonSelected)
    {
        [self unhideClearGuideIndicators];
        self.clearGuide.layer.borderColor=[UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.clearGuide.layer.borderWidth=1.0;
        [self.clearGuide setBackgroundImage:[UIImage imageNamed:@"ClearGuide_Yellow.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self hideClearGuideIndicators];
        self.clearGuide.layer.borderColor=[[UIColor clearColor]CGColor];
        [self.clearGuide setBackgroundImage:[UIImage imageNamed:@"ClearGuide_1.png"] forState:UIControlStateNormal];
    }
}

-(id) copyWithZone:(NSZone *) zone
{
    StandUI *copy = [[[self class] allocWithZone: zone] init];
    
    copy->cumulatedAngle = cumulatedAngle;
  
    copy.circleRadius= self.circleRadius;
    copy.circleCenter = self.circleCenter;
    copy->flip = flip;
    copy->mirror = mirror;
    
    copy.clearGuideButtonSelected = self.clearGuideButtonSelected;
    copy->positionbuttonclicked =  positionbuttonclicked;

    return copy;
}
-(void)StoreCurentSystemState
{
    self.PrevStandUIObjStatus = self;
    
}

-(void)ReStoreSystemState
{
    cumulatedAngle = self.PrevStandUIObjStatus->cumulatedAngle;
    self.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
  
    self.circleRadius =  self.PrevStandUIObjStatus.circleRadius;
    self.circleCenter =  self.PrevStandUIObjStatus.circleCenter;

    flip = self.PrevStandUIObjStatus->flip;
    mirror = self.PrevStandUIObjStatus->mirror;;
    [self updateCirclePathAtLocation:self.circleCenter radius:self.circleRadius];
    
    if (flip)
    {
        flip = NO;
        [self imageFlip];
    }
    if (mirror)
    {
        mirror = NO;
        [self imageMirror];
    }
    
    self.clearGuideButtonSelected = self.PrevStandUIObjStatus.clearGuideButtonSelected;

    if(self.clearGuideButtonSelected)
    {
        self.clearGuideButtonSelected=!self.clearGuideButtonSelected ;
        [self clearGuidePressed:nil];
    }
}

-(void)gestureREMOVE
{
    [self removeGestureRecognizer:swipeDown];
    [self removeGestureRecognizer:swipeUp];
    
    
}

-(IBAction)newExamPressed:(id)sender
{
    [self.FluroxraySwitch setOn:NO animated:YES];
    [self.ExpoxraySwitch setOn:NO animated:YES];
    _OverviewSelected=NO ;
    _shutterPos.textColor=[UIColor grayColor];
    _Automatic.textColor=[UIColor grayColor];
    _AutomaticShutterBtn.userInteractionEnabled=NO ;
    auto_shutter=NO ;
    self.xrayOff=YES ;
    onlyonce=NO ;
    self.imageView.alpha=1.0 ;
    scrollbar.hidden=YES ;
    scrollpanel.hidden=YES ;
    overviewButtonClicked=NO ;
    _imageNavigationtoolbar.overviewButtonClicked=NO ;
    _RunLabel.text=@"12";
    _imageNolabel.text=@"4";
    
    [self gestureREMOVE];
    
    self.clearGuide.layer.borderColor=[[UIColor clearColor]CGColor];
    self.clearGuide.userInteractionEnabled=YES ;
    self.clearGuideButtonSelected =NO ;
    
    _coupleshutter_button.layer.borderWidth=1.0;
    _coupleshutter_button.layer.borderColor= [[UIColor clearColor]CGColor];
    _coupleshutters.textColor=[UIColor whiteColor] ;
    couplingshuttersON=NO ;
    
    
    self.circleLayer.strokeColor=[[UIColor grayColor]CGColor];
    self.controller.collinator.userInteractionEnabled=NO;
    _showcollimator=NO;
    
    self.clearGuideButtonSelected=YES ;
    [self clearGuidePressed:nil];
    
    [self resetIndicators];
    [self updateCirclePathAtLocation:self.circleCenter radius:226.0];
    self.controller.collinator.center=colimatorPOint ;
    [self createCropLines];
    [self allignshutters];
    
    self.controller.positionMemoryButtonCLicked=YES;
    positionbuttonclicked=NO;
    self.position_memory.layer.borderColor=[[UIColor clearColor]CGColor];
   
    [self.imageNavigationtoolbar  ReInitialise];
    [self.imageNavigationtoolbar Hide_UnhideAllNavigationToolBarViews:YES];
    [self.imageNavigationtoolbar.pageNavigationtoolbar setHidden:YES];
    [self hide_UnHide_RightPanelButtons:NO];
    
    
    [self removeGestureRecognizer:self.pinch];
    
    self.statusImage.hidden=YES;
    XRayImageExists = NO;
    
    if (flip)
    {
        [self imageFlip];
        flip=NO ;
    }
    
    if (mirror)
    {
        [self imageMirror];
        mirror=NO;
    }
    
    self.leftImageview.center=self.leftcropImageview.center ;
    self.cascadeImageview.center=self.leftImageview.center;
    
    self.rightImageview.center = self.rightcropImageview.center ;
    self.cascadeImageviewRight.center = self.rightImageview.center ;
    
    [self hideIndicators];
    [self hideClearGuideIndicators];
    
    
    [self createRotatingSymbol];
    self.FluroxraySwitch.userInteractionEnabled=YES;
    self.ExpoxraySwitch.userInteractionEnabled=YES;
    self.reinitByIBAction = YES;
   
    currentSystemMode = NOIMAGE;
    if(self.controller.posMemView)
    {
        [self.controller.posMemView setValue:[NSNumber numberWithInteger:currentSystemMode]  forKey:@"pmCurrSystemMode"];
    }
    navigationshadowViewsExists = NO;
    rotating_Symbol_layered_onBtn   = -1;
    right_shutter_layered_onBtn     = -1;
    left_shutter_layered_onBtn      = -1;
    [self EnableAllnavigationButtons ];

   }

-(void)imageFlip
{
    [self flipImage:self.flipButton];

}

-(void)imageMirror
{
    [self mirrorImage:self.mirrorButton];
}

-(IBAction)fluroSwitch:(id)sender
{
    self.circleLayer.strokeColor=[[UIColor grayColor]CGColor];
    self.statusImage.hidden=NO;
    _OverviewSelected=NO;
    XRayImageExists = YES;
    scrollbar.hidden=YES ;
    self.imageView.alpha=1.0 ;
    [self gestureREMOVE];
    if (applaunch)
    {
        applaunch=NO ;
    }
    
    if ([self.FluroxraySwitch isOn])
    {
        // Hide the Examination dialog if xRay is On
        self.xrayOff = NO ;
        scrollpanel.hidden=YES ;
        overviewButtonClicked=NO ;
        _imageNavigationtoolbar.overviewButtonClicked=NO ;
        _RunLabel.text=@"12";
        _imageNolabel.text=@"4";
        self.SingleImageBtnTapped=NO ;
        self.AllImageBtnTapped=NO ;
        _imageNavigationtoolbar.singleimagepressed=NO ;
        [self.imageNavigationtoolbar Hide_UnhideAllNavigationToolBarViews:YES];
        [self HideOrUnhideIndicators:NO];
        [self.imageNavigationtoolbar.RunLabel setHidden:YES];
        [self.imageNavigationtoolbar.imageNolabel setHidden:YES];
        [self.imageNavigationtoolbar.pageNavigationtoolbar setHidden:YES];
        [self hide_UnHide_RightPanelButtons:NO];
        [self hide_UnHide_PageNavigationButtons:YES];
        _showcollimator=YES ;
        
       
        
        _shutterPos.textColor=[UIColor grayColor];
        _Automatic.textColor=[UIColor grayColor];
        _AutomaticShutterBtn.userInteractionEnabled=NO ;
        
        self.controller.collimatorclicked=NO;
        self.controller.examinationTypeSelView.hidden=YES;
        self.controller.collinator.userInteractionEnabled=YES;
        [self.controller SetUserInteraction:NO];
        [self ChangeClinicalImage:FLUOROSCOPYSETTINGS];
      
        [self.ExpoxraySwitch setOn:NO animated:YES];
        [self unhideIndicators];
        if(positionbuttonclicked)
        {
            [self HideOrUnhideIndicators:YES];
        }
        if(self.imageNavigationtoolbar.imageReviewMode == YES)
        {
            [self ReStoreSystemState];
            [self DisableAllnavigationButtons];
            [self EnableNonOverLapViews];
        }

  
        self.bottompanelStatusImage.image=[UIImage imageNamed:@"fan_ok.png"];
        self.otherExambutton.userInteractionEnabled=NO;
        
        self.statusImage.image=[UIImage imageNamed:@"fluro_image.png"];
        
        
        self.cascadeImageview.alpha=1.0;
        self.cascadeImageviewRight.alpha=1.0;
        self.maskLayer.path = [path CGPath];
        
        if (self.rightcropImageview.center.x<self.circleCenter.x)
        {
            self.cascadeImageviewRight.center=CGPointMake(self.rightcropImageview.center.x, self.rightcropImageview.center.y);
            self.cascadeImageviewRight.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
        }
        else
        {
            self.cascadeImageviewRight.center=CGPointMake(self.rightcropImageview.center.x, self.rightcropImageview.center.y);
            
            self.cascadeImageviewRight.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
        }
        
        if (self.leftcropImageview.center.x<self.circleCenter.x) {
            
            self.cascadeImageview.center=CGPointMake(self.leftcropImageview.center.x, self.leftcropImageview.center.y);
            self.cascadeImageview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
        }
        
        else
        {
            self.cascadeImageview.center=CGPointMake(self.leftcropImageview.center.x, self.leftcropImageview.center.y);
            self.cascadeImageview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
        }

    }
    
    else
    {
        self.xrayOff =YES ;
        self.controller.collimatorclicked=YES;
         [self.controller SetUserInteraction:YES];
        
        if(distanceBetweenPoints(self.leftcropImageview.center, self.circleCenter)>240 && distanceBetweenPoints(self.rightcropImageview.center, self.circleCenter)>240 && self.circleRadius==226 && examinationType==SKELETONVIEW)
        {
            _shutterPos.textColor=[UIColor whiteColor];
            _Automatic.textColor=[UIColor whiteColor];
            _AutomaticShutterBtn.userInteractionEnabled=YES ;
        }
        
       
       
        
        
        if (![self.ExpoxraySwitch isOn])
        {
            self.statusImage.image=[UIImage imageNamed:@"LIH_modeImage.png"];
            [self.imageNavigationtoolbar  ReInitialise];
            [self.imageNavigationtoolbar Hide_UnhideAllNavigationToolBarViews:NO];
            NSInteger imageMode= self.imageNavigationtoolbar.CurrentImageReviewSize;
            [self.imageNavigationtoolbar UpdateToolBarIcons:imageMode];
            self.bottompanelStatusImage.image=[UIImage imageNamed:@"fan.png"];
            self.otherExambutton.userInteractionEnabled=YES ;
        }
    }
    [self UpdateCurrentSystemMode];
}

-(IBAction)expoSwitch:(id)sender
{
    self.circleLayer.strokeColor=[[UIColor grayColor]CGColor];
    self.statusImage.hidden=NO;
    XRayImageExists = YES;
    _OverviewSelected=NO ;
    scrollbar.hidden=YES ;
    self.imageView.alpha=1.0 ;
    [self gestureREMOVE];
    if (applaunch)
    {
        applaunch=NO ;

    }
    
    if ([self.ExpoxraySwitch isOn])
    {
        // Hide the Examination dialog if xRay is On
        self.xrayOff =NO ;
        scrollpanel.hidden=YES ;
        overviewButtonClicked=NO ;
        _RunLabel.text=@"12";
        _imageNolabel.text=@"4";
        _imageNavigationtoolbar.overviewButtonClicked=NO ;
        _imageNavigationtoolbar.singleimagepressed=NO ;
        self.SingleImageBtnTapped=NO ;
        self.AllImageBtnTapped=NO ;
        
        [self.imageNavigationtoolbar  Hide_UnhideAllNavigationToolBarViews:YES];
        [self hide_UnHide_RightPanelButtons:NO];
        [self.imageNavigationtoolbar.RunLabel setHidden:YES];
        [self.imageNavigationtoolbar.imageNolabel setHidden:YES];
        [self hide_UnHide_PageNavigationButtons:YES];
        [self HideOrUnhideIndicators:NO];
        
        _shutterPos.textColor=[UIColor grayColor];
        _Automatic.textColor=[UIColor grayColor];
        _AutomaticShutterBtn.userInteractionEnabled=NO ;

        [self.imageNavigationtoolbar.pageNavigationtoolbar setHidden:YES];
        _showcollimator=YES;
        self.controller.examinationTypeSelView.hidden=YES;
        self.controller.collimatorclicked = NO ;
        [self.controller SetUserInteraction:NO];
        self.controller.collinator.userInteractionEnabled=YES;
        [self ChangeClinicalImage:EXPOSURESETTINGS];
        
        [self.FluroxraySwitch setOn:NO animated:YES];
        [self unhideIndicators];
        if(positionbuttonclicked)
        {
             [self HideOrUnhideIndicators:YES];
        }
        if(self.imageNavigationtoolbar.imageReviewMode == YES)
        {
            [self ReStoreSystemState];
            [self DisableAllnavigationButtons];
            [self EnableNonOverLapViews];
        }
        self.bottompanelStatusImage.image=[UIImage imageNamed:@"fan_ok.png"];
         self.statusImage.image=[UIImage imageNamed:@"expo_image.png"];
        self.cascadeImageview.alpha=1.0;
        self.cascadeImageviewRight.alpha=1.0;
         self.maskLayer.path = [path CGPath];
        
         self.otherExambutton.userInteractionEnabled=NO;

        if (self.rightcropImageview.center.x<self.circleCenter.x)
        {
            self.cascadeImageviewRight.center=CGPointMake(self.rightcropImageview.center.x, self.rightcropImageview.center.y);
            self.cascadeImageviewRight.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
        }
        
        else
        {
            self.cascadeImageviewRight.center=CGPointMake(self.rightcropImageview.center.x, self.rightcropImageview.center.y);
            
            self.cascadeImageviewRight.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
        }
        
        if (self.leftcropImageview.center.x<self.circleCenter.x) {
            
            self.cascadeImageview.center=CGPointMake(self.leftcropImageview.center.x, self.leftcropImageview.center.y);
            self.cascadeImageview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
        }
        
        else
        {
            self.cascadeImageview.center=CGPointMake(self.leftcropImageview.center.x, self.leftcropImageview.center.y);
            self.cascadeImageview.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
        }
        if( [currExposureMode isEqual:SINGLEEXPOSURE])
        {
         [self StartTimer];
        }
    }
    
    else
    {
        self.xrayOff =YES ;
        self.controller.collimatorclicked = YES ;
         [self.controller SetUserInteraction:YES];
        if(distanceBetweenPoints(self.leftcropImageview.center, self.circleCenter)>240 && distanceBetweenPoints(self.rightcropImageview.center, self.circleCenter)>240 && self.circleRadius==226 && examinationType==SKELETONVIEW)
        {
            _shutterPos.textColor=[UIColor whiteColor];
            _Automatic.textColor=[UIColor whiteColor];
            _AutomaticShutterBtn.userInteractionEnabled=YES ;
        }
        
        if (![self.FluroxraySwitch isOn])
        {
            self.statusImage.image=[UIImage imageNamed:@"LIH_modeImage.png"];
           [self.imageNavigationtoolbar  ReInitialise];
            [self.imageNavigationtoolbar Hide_UnhideAllNavigationToolBarViews:NO];
            NSInteger imageMode= self.imageNavigationtoolbar.CurrentImageReviewSize;
            [self.imageNavigationtoolbar UpdateToolBarIcons:imageMode];
            self.bottompanelStatusImage.image=[UIImage imageNamed:@"fan.png"];
            self.otherExambutton.userInteractionEnabled=YES;
        }
    }
    [self UpdateCurrentSystemMode];
}

-(IBAction)examination_cancel_pressed:(id)sender
{
    
    if (!self.leftcropImageview.hidden)
    {
        self.controller.collinator.hidden=NO;
        self.controller.collinator.userInteractionEnabled=YES;
    }
    else
    {
        self.controller.collinator.hidden=YES ;
        self.controller.collinator.userInteractionEnabled=NO;
    }
    
    [self Hide_UnhideNavigationToolbar:NO];
}

-(void)ChangeFluoroMode:(NSString *)str
{
    currFluoroMode = str;
}
-(void)ChangeExposureMode:(NSString *)str
{
   currExposureMode = str;
}

-(void)ChangeClinicalImage:(int)xRayType
{
    NSString *imagename;
    if(examinationType == VASCULARVIEW)
    {
        if( xRayType == FLUOROSCOPYSETTINGS )
        {
            if([currFluoroMode isEqual:FLUORO] )
            {
                imagename = VASC_ABDOMINAL_1_CLINICAL;
            }
            else if([currFluoroMode isEqual:ROADMAP])
            {
                imagename = VASC_ABDOMINAL_2_CLINICAL;
            }
            else // this should never come here
            {
                imagename = [self ChangeSkeletonImage];
            }
        }
        else if( xRayType == EXPOSURESETTINGS )
        {
            if([currExposureMode isEqual:SINGLEEXPOSURE] ||
               [currExposureMode isEqual:EXPOSURERUN]
               )
            {
                imagename = VASC_ABDOMINAL_1_CLINICAL;
            }
           else if([currExposureMode isEqual:SUBTRACT] ||
                   [currExposureMode isEqual:TRACE])
                   {
                       imagename = VASC_ABDOMINAL_2_CLINICAL;
                   }
           else // this should never come here
           {
               imagename = [self ChangeSkeletonImage];
           }
        }
    }
    else if (examinationType == SKELETONVIEW)
    {
        imagename = [self ChangeSkeletonImage];
    }
    else
    {
        imagename = [self OtherExamTypeImageSelect];
    }
    [self changeXRayImage:imagename];
}

-(NSString*)ChangeSkeletonImage
{
    NSString *imagename;
    imagename = [self getCurrentClinicalImage];
    if ( !([ imagename isEqual:SKELETON_LEG_1_CLINICAL] || [ imagename isEqual:SKELETON_LEG_2_CLINICAL] ))
    {
        imagename = SKELETON_LEG_1_CLINICAL;
    }
   else if([ imagename isEqual:SKELETON_LEG_1_CLINICAL])
    {
        imagename = SKELETON_LEG_2_CLINICAL;
        if(auto_shutter && _xrayOff)
        {
            [self shutterPosition2];
        }
    }
    else if ([ imagename isEqual:SKELETON_LEG_2_CLINICAL]  )
    {
        imagename = SKELETON_LEG_1_CLINICAL;
        if(auto_shutter && _xrayOff)
        {
            [self shutterPosition1];
        }
    }
    return imagename;
}

-(NSString*)OtherExamTypeImageSelect
{
    NSString *imagename;
    imagename = [self getCurrentClinicalImage];
    imagename =  [ imagename isEqual:VASC_ABDOMINAL_1_CLINICAL] ? CARDIO_PACEMAKER_1_CLINICAL:VASC_ABDOMINAL_1_CLINICAL;
    return imagename;
}

-(void)changeXRayImage:(NSString *) imageName
{
    
    self.imageView.image=[UIImage imageNamed:imageName];
    [self.imageView setAccessibilityIdentifier:imageName] ;
}

-(NSString*)getCurrentClinicalImage
{
    NSString *file_name = [self.imageView accessibilityIdentifier];
    return file_name;
}



#pragma mark - mirror/flip implementation

-(IBAction)mirrorImage:(UIButton *)sender
{
  
    if (!mirror)
    {
        angle_mirror=M_PI ;
       CATransform3D rotation=CATransform3DRotate(self.controller.standviewParent.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.controller.standviewParent.layer.transform=rotation ;
        
        self.number12.layer.transform =CATransform3DRotate(self.number12.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.number9.layer.transform =CATransform3DRotate(self.number9.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.number3.layer.transform =CATransform3DRotate(self.number3.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.number6.layer.transform =CATransform3DRotate(self.number6.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        
        sender.layer.borderColor=[[UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0]CGColor];

        sender.layer.borderWidth=1.0;
        
        _mirrorLabel.textColor=[UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0];
        
        self.number12.center=CGPointMake(self.number12.center.x+8, self.number12.center.y);
        self.number6.center=CGPointMake(self.number6.center.x-14, self.number6.center.y);
    }
    
    else
    {
        angle_mirror=-M_PI ;
        CATransform3D rotation=CATransform3DRotate(self.controller.standviewParent.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.controller.standviewParent.layer.transform=rotation ;
        
        self.number12.layer.transform =CATransform3DRotate(self.number12.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.number9.layer.transform =CATransform3DRotate(self.number9.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.number3.layer.transform =CATransform3DRotate(self.number3.layer.transform, angle_mirror, 0.0, 1.0, 0.0);
        self.number6.layer.transform =CATransform3DRotate(self.number6.layer.transform, angle_mirror, 0.0, 1.0, 0.0);

        
        sender.layer.borderColor=[[UIColor clearColor]CGColor];
        sender.layer.borderWidth=1.0;
        
        _mirrorLabel.textColor=[UIColor whiteColor];
        
        self.number12.center=CGPointMake(self.number12.center.x-8, self.number12.center.y);
        self.number6.center=CGPointMake(self.number6.center.x+14, self.number6.center.y);
        
        
    }
    
    mirror=!mirror ;
    _mirrorisON=mirror ;

}

-(IBAction)flipImage:(UIButton *)sender
{
    if (!flip)
    {
        
        angle_flip=M_PI ;
        self.controller.standviewParent.layer.transform=CATransform3DRotate(self.controller.standviewParent.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        
        self.number12.layer.transform =CATransform3DRotate(self.number12.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        self.number9.layer.transform =CATransform3DRotate(self.number9.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        self.number3.layer.transform =CATransform3DRotate(self.number3.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        self.number6.layer.transform =CATransform3DRotate(self.number6.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        
        sender.layer.borderColor=[[UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0]CGColor];

        sender.layer.borderWidth=1.0;
        
        _flipLabel.textColor=[UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0];
        
        self.number9.center=CGPointMake(self.number9.center.x, self.number9.center.y+20);
        self.number3.center=CGPointMake(self.number3.center.x, self.number3.center.y+20);

        
    }
    
    else
    {
        angle_flip=-M_PI;
       self.controller.standviewParent.layer.transform=CATransform3DRotate(self.controller.standviewParent.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        
        self.number12.layer.transform =CATransform3DRotate(self.number12.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        self.number9.layer.transform =CATransform3DRotate(self.number9.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        self.number3.layer.transform =CATransform3DRotate(self.number3.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        self.number6.layer.transform =CATransform3DRotate(self.number6.layer.transform, angle_flip, 1.0, 0.0, 0.0);
        
        sender.layer.borderColor=[[UIColor clearColor]CGColor];
        sender.layer.borderWidth=1.0;
        
        _flipLabel.textColor=[UIColor whiteColor];
        self.number9.center=CGPointMake(self.number9.center.x, self.number9.center.y-20);
        self.number3.center=CGPointMake(self.number3.center.x, self.number3.center.y-20);
        
    }
    
    flip=!flip ;
    _flipisON=flip ;
    
  }

-(void)actualPointofRotatingViewin_MainView
{
    CGPoint circleCenterPoint = CGPointMake(543.500000, 347.000000) ;
    
    CGFloat distance = distanceBetweenPoints(pointon_MainView, circleCenterPoint) ;
    
    CGPoint correctPoint ;
    
    correctPoint.x = circleCenterPoint.x +distance*sin(DEGREES_TO_RADIANS(M_PI)) ;
    correctPoint.y = circleCenterPoint.y + distance*cos(DEGREES_TO_RADIANS(M_PI));
    
    UIView *tempview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    tempview.backgroundColor=[UIColor redColor];
    [self.controller.mainView addSubview:tempview];
    
    tempview.center = correctPoint ;

    
}


#pragma mark - rightPanel Implementation

-(IBAction)coupleShutters:(id)sender
{
    couplingshuttersON=!couplingshuttersON ;
    
    if (couplingshuttersON)
    {
        _coupleshutter_button.layer.borderWidth=1.0;
       _coupleshutter_button.layer.borderColor= [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        _coupleshutters.textColor=[UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0] ;

    }
    
    else
    {
        _coupleshutter_button.layer.borderWidth=1.0;
        _coupleshutter_button.layer.borderColor= [[UIColor clearColor]CGColor];
        _coupleshutters.textColor=[UIColor whiteColor] ;
        
    }
    
    
}

-(IBAction)reset_Shutters:(id)sender
{
    reset_shutters_collinators.backgroundColor = [UIColor blackColor];//[UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1.0];

    CGPoint leftshutterposition;
    [self updateCirclePathAtLocation:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:226.0];
     self.controller.collinator.center=colimatorPOint;
    leftshutterposition.x = self.circleCenter.x -(self.circleRadius+30)*cos(DEGREES_TO_RADIANS(-cumulatedAngle));
    leftshutterposition.y = self.circleCenter.y - (self.circleRadius+30)*sin(DEGREES_TO_RADIANS(-cumulatedAngle));
    self.leftImageview.center=leftshutterposition;
    self.leftcropImageview.center=leftshutterposition ;
    
    if (!_xrayOff)
    {
            self.cascadeImageview.center=leftshutterposition ;
    }

    
    CGPoint rightshutterposition;
    
    rightshutterposition.x = self.circleCenter.x + (self.circleRadius+30)*cos(DEGREES_TO_RADIANS(-cumulatedAngle));
    rightshutterposition.y = self.circleCenter.y + (self.circleRadius+30)*sin(DEGREES_TO_RADIANS(-cumulatedAngle));
    
      self.rightImageview.center=rightshutterposition ;
    
    self.rightcropImageview.center = self.rightImageview.center ;
    if (!_xrayOff)
    {
        self.cascadeImageviewRight.center=self.rightImageview.center ;
    }
  
        [self resettheShutters];

   reset_shutters_collinators.backgroundColor = [UIColor colorWithRed:43.0/255.0 green:42.0/255.0 blue:39.0/255.0 alpha:1.0];
    
    rightcroplineAngle=-cumulatedAngle ;
    leftcroplineAngle=-cumulatedAngle ;
    
      right_shutter_layered_onBtn  = -1;
    left_shutter_layered_onBtn = -1;
    [self EnableNonOverLapViews];
    

}


#pragma mark - LineGraph implementation

-(CGFloat)slopeOFline:(CGPoint)p1 and:(CGPoint)p2
{
     CGFloat slope = (p2.y-p1.y)/(p2.x-p1.x);
    
     return slope ;
  
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    
    CGFloat lhs = (point.x-self.circleCenter.x)*(point.x-self.circleCenter.x)+(point.y-self.circleCenter.y)*(point.y-self.circleCenter.y);
    CGFloat rhs = (self.bounds.size.width*0.3+10)*(self.bounds.size.width*0.3+10) ;
    
    if (lhs>rhs)
    {
        return YES;
    }
    
    else
    {
        return YES;
    }
}

-(void)Hide_UnhideNavigationToolbar:(BOOL)val
{
    if( val ==  YES)
    {
        [self.imageNavigationtoolbar Hide_UnhideAllNavigationToolBarViews:YES];
        [self.imageNavigationtoolbar.RunLabel setHidden:YES];
        [self.imageNavigationtoolbar.imageNolabel setHidden:YES];
    }
    else if(self.imageNavigationtoolbar.imageReviewMode == YES )
    {
        [self.imageNavigationtoolbar Hide_UnhideAllNavigationToolBarViews:NO];
        [self.imageNavigationtoolbar.RunLabel setHidden:val];
        [self.imageNavigationtoolbar.imageNolabel setHidden:val];
    }
    else if(currentSystemMode == LIHMODE || currentSystemMode == IMAGEREVIEW)
    {
         [self.imageNavigationtoolbar Hide_UnhideAllNavigationToolBarViews:NO];
    }
    if(self.imageNavigationtoolbar.CurrentImageReviewMode == SIDD)
    {
        [self.RunLabel setHidden:NO];
        [self.imageNolabel setHidden:YES];
    }
    if (examinationType!=SKELETONVIEW)
    {
        _AutomaticShutterBtn.userInteractionEnabled=NO ;
        _Automatic.textColor=[UIColor grayColor];
        _shutterPos.textColor=[UIColor grayColor];
    }
    
    else
    {
        _AutomaticShutterBtn.userInteractionEnabled=YES ;
        _Automatic.textColor=[UIColor whiteColor];
        _shutterPos.textColor=[UIColor whiteColor];
    }
    
}

// Input is yes then Hide all the Controls
-(void)hide_UnHide_RightPanelButtons:(BOOL)val
{
    if(val == YES) {
        [self SwipeGestureEnable_Disable:YES];
        
    }
    else {
        [self SwipeGestureEnable_Disable:NO];
    }
    
    [self.clearGuide setEnabled:!val];
    [self.statusImage setHidden:val];
    [self.flipLabel setHidden:val];
    [self.flipButton setHidden:val];
    [self.mirrorButton setHidden:val];
    [self.mirrorLabel setHidden:val];
    [self.coupleshutter_button setHidden:val];
    [self.reset_shutters_collinators setHidden:val];
    [self.flipImage setHidden:val];
    [self.mirrorImage setHidden:val];
    
    [self.resetShutters setHidden:val];
    [self.resetCollincators setHidden:val];
    [self.resetShuttersCollinators setHidden:val];
    [self.coupleshutters setHidden:val];
    [self.coupleshuttersImage setHidden:val];
    
    [self.Automatic setHidden:val];
    [self.shutterPos setHidden:val];
    [self.AutomaticShutterBtn setHidden:val];
    [self.AutomaticShutterBtn1 setHidden:val];
}

-(void)hide_UnHide_PageNavigationButtons:(BOOL)val
{
    [self.AllImageButton setHidden:val];
    [self.AllImage_RightPanel setHidden:val];
    [self.AllImage_Lbl setHidden:val];
    [self.OneImageButton setHidden:val];
    [self.OneImage_RightPanel setHidden:val];
    [self.OneImage_Lbl setHidden:val];
}

-(IBAction)automatic_shutter_position:(id)sender
{
    if (self.xrayOff && examinationType==SKELETONVIEW && _AutomaticShutterBtn.userInteractionEnabled)
    {
        auto_shutter=!auto_shutter ;
        _Automatic.textColor=[UIColor whiteColor];//[UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0];
        _shutterPos.textColor=[UIColor whiteColor];//[UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0] ;
        
        NSString *imagename;
        imagename = [self getCurrentClinicalImage];
        
        if ([imagename isEqual:SKELETON_LEG_1_CLINICAL])
        {
            [self shutterPosition1];
        }
        else if([imagename isEqual:SKELETON_LEG_2_CLINICAL])
        {
            [self shutterPosition2];
        }
        
    }
    
}


- (IBAction)AllImagesBtnClicked:(id)sender
{
    self.SingleImageBtnTapped=FALSE ;
    self.AllImageBtnTapped=TRUE ;
     _imageNavigationtoolbar.allimagepressed=!_imageNavigationtoolbar.allimagepressed;
    _imageNavigationtoolbar.pageNavigationtoolbar.hidden=NO ;
    
    
    scrollbar.hidden=NO ;
    {
         self.AllImageButton.layer.cornerRadius = 2;
        self.AllImageButton.layer.borderWidth = 1.0;
        self.AllImageButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.AllImage_Lbl.textColor = [UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:0.8];
        
        self.OneImage_Lbl.textColor = [UIColor whiteColor];
        self.OneImageButton.layer.borderColor  =[UIColor clearColor].CGColor;
        
        for (UIView *view in [scrollpanel subviews])
        {
            [view removeFromSuperview];
        }
        scrollpanel.hidden=NO ;
        scrollpanel.runvalue =[_RunLabel.text integerValue] ;
        scrollpanel.imageNovalue=[_imageNolabel.text integerValue];
        
        if (scrollpanel.runvalue==0)
        {
            scrollpanel.runvalue = 12 ;
            scrollpanel.imageNovalue =4 ;
            
            _RunLabel.text  = [NSString stringWithFormat:@"%d",scrollpanel.runvalue] ;
            _imageNolabel.text=[NSString stringWithFormat:@"%d",scrollpanel.imageNovalue] ;
            
        }
        
        if (scrollpanel.runvalue <=10)
        {
            for (int i=0; i<16; i++)
            {
                if ([[runarray1 objectAtIndex:i]integerValue]==scrollpanel.runvalue && [[imageArray1 objectAtIndex:i]integerValue]==scrollpanel.imageNovalue)
                {
                    
                    scrollpanel.tagvalue = i ;
                    [scrollpanel Addoverview3];
                    break ;
                    
                }
            }
            
            bar.frame=CGRectMake(bar.frame.origin.x,0, bar.bounds.size.width, bar.bounds.size.height);
            
            pageupbutonpressed=YES ;
            pagedownbutonpressed=NO ;
            swipeUp.enabled=YES ;
            swipeDown.enabled=NO ;
            
            _pageupimage.alpha=0.4;
            _toppageupView.alpha=0.4;
            
            
            _pagedownimage.alpha=1.0;
            _bottompageupView.alpha=1.0 ;
            
            _pageUpButton.userInteractionEnabled=NO;
            _pageDownButton.userInteractionEnabled=YES;


            overviewNumber=2 ;
            
        }
        
        else
        {
            for (int i=0; i<14; i++)
            {
                if ([[runarray objectAtIndex:i]integerValue]==scrollpanel.runvalue && [[imageArray objectAtIndex:i]integerValue]==scrollpanel.imageNovalue)
                {
                    scrollpanel.tagvalue = i ;
                        [scrollpanel Addoverview2];
                    break ;
                    
                }
            }
            pageupbutonpressed=NO ;
            pagedownbutonpressed=YES ;
            
             bar.frame=CGRectMake(bar.frame.origin.x,scrollbar.bounds.size.height/2, bar.bounds.size.width, bar.bounds.size.height);
            
            swipeUp.enabled=NO ;
            swipeDown.enabled=YES ;
            
            _pageupimage.alpha=1.0;
            _toppageupView.alpha=1.0;
            
            
            _pagedownimage.alpha=0.4 ;
            _bottompageupView.alpha=0.4 ;
            
            _pageUpButton.userInteractionEnabled=YES;
            _pageDownButton.userInteractionEnabled=NO;
            
            overviewNumber=3 ;
        }
        
        scrollpanel.hidden=NO;
        _statusImage.hidden=YES;
        _topview.hidden=YES ;
       
    }
    
}

-(void)createScrollBar
{
    scrollbar=[[UIView alloc]initWithFrame:CGRectMake(680, 250, 20, 500)];
    
    scrollbar.layer.borderColor=[[UIColor grayColor]CGColor];
    
    scrollbar.layer.borderWidth = 1.0 ;
    
    [self addSubview:scrollbar];
    
    
    bar =[[UIView alloc]initWithFrame:CGRectMake(0, 0, scrollbar.bounds.size.width, scrollbar.bounds.size.height/2)];
    
    bar.backgroundColor=[UIColor darkGrayColor];
    
    bar.layer.cornerRadius=20.0 ;
    
    [scrollbar addSubview:bar];
    
    
}


- (IBAction)OnePage_RunBtnClicked:(id)sender
{
    self.SingleImageBtnTapped =TRUE ;
    self.AllImageBtnTapped=FALSE ;
    scrollbar.hidden=YES ;
_imageNavigationtoolbar.pageNavigationtoolbar.hidden=YES ;

        self.OneImageButton.layer.cornerRadius = 2;
        self.OneImageButton.layer.borderWidth = 1.0;
        self.OneImageButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
        self.OneImage_Lbl.textColor = [UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:0.8];
        
        self.AllImage_Lbl.textColor = [UIColor whiteColor];
        self.AllImageButton.layer.borderColor  =[UIColor clearColor].CGColor;
        self.AllImageBtnTapped = FALSE;
         scrollpanel.hidden=NO ;
        for (UIView *view in [scrollpanel subviews])
        {
            [view removeFromSuperview];
        }
        scrollpanel.tagvalue =[_RunLabel.text integerValue]-1 ;
        if (scrollpanel.tagvalue==-1)
        {
            scrollpanel.tagvalue=11 ;
        }
        
        NSLog(@"tag value is %d",scrollpanel.tagvalue);
        
        [scrollpanel Addoverview1];
        for (UIButton *buttonview in [scrollpanel subviews])
        {
            if (buttonview.tag==scrollpanel.tagvalue)
            {
                if (buttonview.frame.size.width==126)
                {
                    
                buttonview.layer.borderWidth = 1.0 ;
                buttonview.layer.borderColor = [[UIColor whiteColor]CGColor];
                }
            }
        }
        
        
        
        scrollpanel.hidden=NO;
        _statusImage.hidden=YES;
        _topview.hidden=YES ;
        
        _RunLabel.text=[NSString stringWithFormat:@"%d",scrollpanel.tagvalue+1];
        _imageNolabel.text=[singleimageNumbers objectAtIndex:scrollpanel.tagvalue];
        
        
   
}

-(void)CreateScrollView
{
    scrollpanel =[[ScrollPanelView alloc]initWithFrame:CGRectMake(120, 230, 500, 500)];
    
    [self addSubview:scrollpanel];
    
    scrollpanel.backgroundColor=[UIColor clearColor];
    
  
}


-(void)gestureADD
{
    
    swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    swipeDown.delegate = self;
    [self addGestureRecognizer:swipeDown];
    
    swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    swipeUp.delegate = self;
    [self addGestureRecognizer:swipeUp];

    
}

- (IBAction)PageUpBtnClicked:(id)sender
{
    if (self.AllImageBtnTapped)
    {
        pageupbutonpressed=YES ;
        pagedownbutonpressed=NO ;
        _pageUpButton.userInteractionEnabled=NO;
        _pageDownButton.userInteractionEnabled=YES;
        
        _pageupimage.alpha=0.4;
        _toppageupView.alpha=0.4;
        
        swipeDown.enabled=NO;
        swipeUp.enabled=YES ;
        
        
        _pagedownimage.alpha=1.0 ;
        _bottompageupView.alpha=1.0 ;
        
        for (UIButton *buttonview in [scrollpanel subviews])
        {
            buttonview.layer.borderWidth = 1.0 ;
            buttonview.layer.borderColor = [[UIColor clearColor]CGColor];
        }
        

        self.imageView.alpha=0.0 ;
  
        
        
        BOOL val1,val2 ;
        
        val1=swipeUp.isEnabled ;
        val2=swipeDown.isEnabled ;

        
        [UIView animateWithDuration:0.33f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             scrollpanel.frame=CGRectMake(scrollpanel.frame.origin.x, scrollpanel.frame.origin.y+scrollpanel.frame.size.height, scrollpanel.frame.size.width, scrollpanel.frame.size.height);
                             
                            

                         
                         }
                         completion:^(BOOL finished){
                             
                             
                             scrollpanel.tagvalue=15 ;
                             [scrollpanel Addoverview3];
                             
                             scrollpanel.frame=CGRectMake(scrollpanel.frame.origin.x, scrollpanel.frame.origin.y-2*scrollpanel.frame.size.height, scrollpanel.frame.size.width, scrollpanel.frame.size.height);
                             

                             
                             
                             [UIView beginAnimations:nil context:nil];
                             [UIView setAnimationDuration:0.2];
                             
                             
                                   scrollpanel.frame=CGRectMake(scrollpanel.frame.origin.x, scrollpanel.frame.origin.y+scrollpanel.frame.size.height, scrollpanel.frame.size.width, scrollpanel.frame.size.height) ;
                             
                          
                             swipeDown.enabled=NO;
                             swipeUp.enabled=NO ;
                             
                             [UIView commitAnimations];
                             
                             
                             for (UIButton *buttonview in [scrollpanel subviews])
                             {
                                 if (buttonview.tag==scrollpanel.tagvalue)
                                 {
                                     buttonview.layer.borderWidth = 1.0 ;
                                     buttonview.layer.borderColor = [[UIColor whiteColor]CGColor];
                                 }
                             }
                             
                             overviewNumber=2 ;
                             
                             _RunLabel.text =@"10";
                             _imageNolabel.text=@"4" ;
                             
                             swipeUp.enabled=val1 ;
                             swipeDown.enabled=val2 ;
                             
                             [_imageNavigationtoolbar NextImageBtnClicked:nil];

                             
                             
                         }];
        

    }
    
    
}

- (IBAction)PageDownBtnClicked:(id)sender
{
    if (self.AllImageBtnTapped)
    {
    pagedownbutonpressed=YES ;
    pageupbutonpressed=NO ;
        _pageupimage.alpha=1.0;
        _toppageupView.alpha=1.0;
        
        swipeDown.enabled=YES;
        swipeUp.enabled=NO ;
        
       
        _pagedownimage.alpha=0.4 ;
        _bottompageupView.alpha=0.4 ;
        
        _pageUpButton.userInteractionEnabled=YES;
        _pageDownButton.userInteractionEnabled=NO;
    
        
        for (UIButton *buttonview in [scrollpanel subviews])
        {
            buttonview.layer.borderWidth = 1.0 ;
            buttonview.layer.borderColor = [[UIColor clearColor]CGColor];
        }
        
        self.imageView.alpha=0.0 ;
        BOOL val1,val2 ;
        
        val1=swipeUp.isEnabled ;
        val2=swipeDown.isEnabled ;
        
        [UIView animateWithDuration:0.33f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                              scrollpanel.frame=CGRectMake(scrollpanel.frame.origin.x, scrollpanel.frame.origin.y-scrollpanel.frame.size.height, scrollpanel.frame.size.width, scrollpanel.frame.size.height);
                             
                             swipeDown.enabled=NO;
                             swipeUp.enabled=NO ;
                             
                             
                         }
                         completion:^(BOOL finished){
                             
                             scrollpanel.tagvalue=0 ;
                             [scrollpanel Addoverview2];
                             
                             scrollpanel.frame=CGRectMake(scrollpanel.frame.origin.x, scrollpanel.frame.origin.y+2*scrollpanel.frame.size.height, scrollpanel.frame.size.width, scrollpanel.frame.size.height);
                             
                             [UIView beginAnimations:nil context:nil];
                             [UIView setAnimationDuration:0.2];
                             
                          scrollpanel.frame=CGRectMake(scrollpanel.frame.origin.x, scrollpanel.frame.origin.y-scrollpanel.frame.size.height, scrollpanel.frame.size.width, scrollpanel.frame.size.height) ;
                             
                             [UIView commitAnimations];
                             
                             
                             for (UIButton *buttonview in [scrollpanel subviews])
                             {
                                 if (buttonview.tag==scrollpanel.tagvalue)
                                 {
                                     if (buttonview.frame.size.width==126)
                                     {
                                         buttonview.layer.borderWidth = 1.0 ;
                                         buttonview.layer.borderColor = [[UIColor whiteColor]CGColor];
                                     }
                                 }
                             }
                             
                             
                             overviewNumber=3;
                             
                             _RunLabel.text=@"11";
                             _imageNolabel.text=@"1";
                             
                             swipeUp.enabled=val1 ;
                             swipeDown.enabled=val2 ;
                             
                             
                             [_imageNavigationtoolbar NextImageBtnClicked:nil];

                             
                         }];
    }
}

- (IBAction)Single_OverviewBtnClicked:(id)sender
{
    overviewButtonClicked=!overviewButtonClicked ;
    _OverviewSelected=YES ;
    scrollbar.hidden=YES ;
    if (overviewButtonClicked)
    {
        [self OnePage_RunBtnClicked:Nil];
        _imageNavigationtoolbar.singleimagepressed=YES ;
        scrollpanel.hidden=NO ;
        [_RunLabel setHidden:YES];
        [_imageNolabel setHidden:YES];
        
         [self gestureADD];
        
        _imageNavigationtoolbar.pageNavigationtoolbar.hidden=YES ;
        
    }
    
    else
    {
        scrollpanel.hidden=YES ;
        [_imageNavigationtoolbar NextImageBtnClicked:nil];
        _imageNavigationtoolbar.singleimagepressed=NO ;
        self.SingleImageBtnTapped=FALSE ;
        self.AllImageBtnTapped=FALSE ;
        _RunLabel.hidden=NO;
        _imageNolabel.hidden=NO ;
        self.imageView.alpha=1.0 ;
        self.imageNavigationtoolbar.pageNavigationtoolbar.hidden=YES ;

    }
    

}

-(void)UpdateRightSidebar
{
    _imageNavigationtoolbar.overviewButtonClicked=NO ;
    overviewButtonClicked=!overviewButtonClicked ;
    _imageNavigationtoolbar.singleimagepressed=NO ;
    [_imageNavigationtoolbar UpdateToolBarIcons:01];
    _imageNavigationtoolbar.imageReviewMode=YES ;
    _RunLabel.hidden=NO ;
    _imageNolabel.hidden=NO ;
    
    self.SingleImageBtnTapped=FALSE ;
    self.AllImageBtnTapped=FALSE ;
    self.imageNavigationtoolbar.pageNavigationtoolbar.hidden=YES ;
    
    
}

- (IBAction)NextImageBtnClicked:(id)sender
{

    
    if(self.SingleImageBtnTapped && scrollpanel.tagvalue<11)
    {
                 [scrollpanel nextbuttonOvetview1];
        
        _RunLabel.text=[NSString stringWithFormat:@"%d",scrollpanel.tagvalue+1] ;
        _imageNolabel.text=[singleimageNumbers objectAtIndex:scrollpanel.tagvalue];
      
    }
    
    if(self.AllImageBtnTapped)
    {
        if (overviewNumber==2 && scrollpanel.tagvalue<15)
        {
            [scrollpanel nextbuttonOvetview2];
            
            _RunLabel.text =[runarray1 objectAtIndex:scrollpanel.tagvalue];
            _imageNolabel.text=[imageArray1 objectAtIndex:scrollpanel.tagvalue];
            
            
        }
        
        else if(overviewNumber==3 && scrollpanel.tagvalue<13)
        {
            [scrollpanel nextbuttonOvetview3];
            
            _RunLabel.text =[runarray objectAtIndex:scrollpanel.tagvalue];
            _imageNolabel.text=[imageArray objectAtIndex:scrollpanel.tagvalue];
            
                        
        }
        
        else if(overviewNumber==2 && scrollpanel.tagvalue>=15)
        {
            
            for (UIView *view in [scrollpanel subviews])
            {
                [view removeFromSuperview];
            }

            scrollpanel.tagvalue=0;
            _RunLabel.text=@"11";
            _imageNolabel.text=@"1";
            overviewNumber=3 ;
            [scrollpanel Addoverview2];
            
            pagedownbutonpressed=YES ;
            pageupbutonpressed=NO ;
            _pageupimage.alpha=1.0;
            _toppageupView.alpha=1.0;
            
            
            _pagedownimage.alpha=0.4 ;
            _bottompageupView.alpha=0.4 ;
            
            _pageUpButton.userInteractionEnabled=YES;
            _pageDownButton.userInteractionEnabled=NO;
            
            swipeDown.enabled=YES ;
            swipeUp.enabled=NO ;
            
            
            bar.frame=CGRectMake(bar.frame.origin.x,scrollbar.bounds.size.height/2, bar.bounds.size.width, bar.bounds.size.height);

            
            
        }
        
    }
    
}

- (IBAction)PreviousImageBtnClicked:(id)sender
{
    if (self.SingleImageBtnTapped)
    {
    
    if(scrollpanel.tagvalue>0)
    {
        NSLog(@"tagvalue is %d",scrollpanel.tagvalue);
        [scrollpanel prevbuttonOverview1];
        
        _RunLabel.text=[NSString stringWithFormat:@"%d",scrollpanel.tagvalue+1] ;
        _imageNolabel.text=[singleimageNumbers objectAtIndex:scrollpanel.tagvalue];
       
    }
    
    }
    
    if(self.AllImageBtnTapped)
    {
        if (overviewNumber==2 && scrollpanel.tagvalue>0)
        {
            
              [scrollpanel prevbuttonOverview2];
            
            _RunLabel.text =[runarray1 objectAtIndex:scrollpanel.tagvalue];
            _imageNolabel.text=[imageArray1 objectAtIndex:scrollpanel.tagvalue];
            
            
        }
        
        else if (overviewNumber==3 && scrollpanel.tagvalue>0)
        {
            
              [scrollpanel prevbuttonOverview3];
            
            _RunLabel.text =[runarray objectAtIndex:scrollpanel.tagvalue];
            _imageNolabel.text=[imageArray objectAtIndex:scrollpanel.tagvalue];

        }
        
        else if(overviewNumber==3 && scrollpanel.tagvalue<=0)
        {
            
            for (UIView *view in [scrollpanel subviews])
            {
                [view removeFromSuperview];
            }
            
            scrollpanel.tagvalue=15;
            _RunLabel.text=@"10";
            _imageNolabel.text=@"4";
            overviewNumber=2 ;
            [scrollpanel Addoverview3];
            
            pageupbutonpressed=YES ;
            pagedownbutonpressed=NO ;
            
            _pageupimage.alpha=0.4;
            _toppageupView.alpha=0.4;
            
            
            _pagedownimage.alpha=1.0 ;
            _bottompageupView.alpha=1.0 ;
            
            _pageUpButton.userInteractionEnabled=NO;
            _pageDownButton.userInteractionEnabled=YES;
            
            swipeDown.enabled=NO ;
            swipeUp.enabled=YES ;
            
            bar.frame=CGRectMake(bar.frame.origin.x,0, bar.bounds.size.width, bar.bounds.size.height);

            
        }
        
 
     }
 }

-(void)updateRUN
{
    
    //to do
    
    if (self.SingleImageBtnTapped)
    {
        _RunLabel.text=[NSString stringWithFormat:@"%d",scrollpanel.tagvalue+1] ;
        _imageNolabel.text=[singleimageNumbers objectAtIndex:scrollpanel.tagvalue];
        
       
        
    }
    
    if (self.AllImageBtnTapped)
    {
        if (overviewNumber==2)
        {
            _RunLabel.text =[runarray1 objectAtIndex:scrollpanel.tagvalue];
             _imageNolabel.text=[imageArray1 objectAtIndex:scrollpanel.tagvalue];
        }
        
        else if (overviewNumber==3)
        {
             _RunLabel.text =[runarray objectAtIndex:scrollpanel.tagvalue];
             _imageNolabel.text=[imageArray objectAtIndex:scrollpanel.tagvalue];
            
        }
        
        
    }
    
    self.imageView.alpha=1.0 ;

     [_imageNavigationtoolbar NextImageBtnClicked:nil];
       
}




-(void)switchtoImageReviewMode
{
    [self StoreCurentSystemState];
    self.circleLayer.strokeColor = [[UIColor clearColor] CGColor];
    self.reinitByIBAction = NO;
    cumulatedAngle = 0.0;
    NSLog(@" cumulative angle %f\n",cumulatedAngle);
    self.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(cumulatedAngle), 0.0, 0.0, 1.0);
    self.cascadeImageview.hidden=YES;
    self.cascadeImageviewRight.hidden=YES;
    [self updateCirclePathAtLocation:self.circleCenter radius:226];
    if (flip)
    {
        [self imageFlip];
        flip=NO ;
    }
    
    if (mirror)
    {
        [self imageMirror];
        mirror=NO;
    }
    if(self.clearGuideButtonSelected)
    {
        [self clearGuidePressed:nil];
    }
    [self.imageView setHidden:NO];
    [self HideOrUnhideIndicators:YES];
    [self hide_UnHide_RightPanelButtons:YES];
    self.reinitByIBAction = YES;
 //   [self UpdateCurrentSystemMode];
     currentSystemMode = IMAGEREVIEW;
    if(self.controller.posMemView)
    {
        [self.controller.posMemView ResetSystemPositions];
        [self.controller.posMemView setValue:[NSNumber numberWithInteger:currentSystemMode]  forKey:@"pmCurrSystemMode"];
    }
    [self EnableAllnavigationButtons];
}

-(void)shutterPosition1
{
    CGPoint positionRight ;
    
    positionRight.x = 405.813904 ;
    positionRight.y = 401.172668 ;
    
    rightcroplineAngle = -77.792297 ;
    
    self.rightcropImageview.center=positionRight ;
    self.rightImageview.center=positionRight ;
    self.cascadeImageviewRight.center=positionRight ;
    
    if (self.xrayOn)
    {
        self.cascadeImageviewRight.hidden=NO ;
        self.cascadeImageviewRight.alpha=0.6 ;
    }
    else
    {
        self.cascadeImageviewRight.hidden=YES ;
    }
    
    
    self.rightImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
    self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
    self.cascadeImageviewRight.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
    
    
    
    
    
    CGPoint positionLeft ;
    
    positionLeft.x = 382.939362 ;
    positionLeft.y = 695.497742 ;
    
    leftcroplineAngle = -91.167595 ;
    
    self.leftcropImageview.center=positionLeft ;
    self.leftImageview.center=positionLeft ;
    self.cascadeImageview.center=positionLeft ;
    
    if (self.xrayOn)
    {
        self.cascadeImageview.hidden=NO ;
        self.cascadeImageview.alpha=0.6 ;
    }
    else
    {
        self.cascadeImageview.hidden=YES ;
    }
    
    
    self.leftImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
    self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
    self.cascadeImageview.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
    

}

-(void)shutterPosition2
{
    CGPoint positionRight ;
    
    positionRight.x = 405.813904 ;
    positionRight.y = 401.172668 ;
    
    rightcroplineAngle = -77.792297 ;
    
    self.rightcropImageview.center=positionRight ;
    self.rightImageview.center=positionRight ;
    self.cascadeImageviewRight.center=positionRight ;
    
    if (self.xrayOn)
    {
        self.cascadeImageviewRight.hidden=NO ;
         self.cascadeImageviewRight.alpha=0.6 ;
    }
    else
    {
        self.cascadeImageviewRight.hidden=YES ;
    }
   
    
    self.rightImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
    self.rightcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
    self.cascadeImageviewRight.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(rightcroplineAngle), 0.0, 0.0, 1.0);
    




    CGPoint positionLeft ;
    
    positionLeft.x = 382.939362 ;
    positionLeft.y = 695.497742 ;
    
    leftcroplineAngle = -91.167595 ;
    
    self.leftcropImageview.center=positionLeft ;
    self.leftImageview.center=positionLeft ;
    self.cascadeImageview.center=positionLeft ;
    
    if (self.xrayOn)
    {
        self.cascadeImageview.hidden=NO ;
        self.cascadeImageview.alpha=0.6 ;
    }
    else
    {
        self.cascadeImageview.hidden=YES ;
    }
    
    
    self.leftImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
    self.leftcropImageview.layer.transform=CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);
    self.cascadeImageview.layer.transform =CATransform3DMakeRotation(DEGREES_TO_RADIANS(leftcroplineAngle), 0.0, 0.0, 1.0);

}

-(IBAction)RunCycleButtonClicked:(id)sender
{
    _runcycleButtonclicked=!_runcycleButtonclicked;
    if (self.imageNavigationtoolbar.singleimagepressed)
    {
        [_imageNavigationtoolbar NextImageBtnClicked:nil];
    }
    
    scrollpanel.hidden=YES ;
    overviewButtonClicked=NO ;
    scrollbar.hidden=YES ;
    _imageNavigationtoolbar.singleimagepressed=NO ;
    _imageNavigationtoolbar.overviewButtonClicked=NO ;
    self.SingleImageBtnTapped=FALSE;
    self.AllImageBtnTapped=FALSE ;
    self.imageView.alpha=1.0 ;
    
     self.imageNavigationtoolbar.pageNavigationtoolbar.hidden=YES ;
    
}


-(IBAction)questionmarkPressed:(id)sender
{
    _questionmarkPressed=!_questionmarkPressed ;
    
    _tagValueLeftPanel=100 ;
    _tagValueRightPanel=200 ;
    _tagValuestanduiPanel=400 ;
    _tagValuesimagenavigationtollbar=600 ;
    _tagValuetopPanel =700 ;
    _tagValuepagecontrol=800 ;
    
    if (_questionmarkPressed)
    {
        [self loadQuestionmarks];
        [self.controller loadQuestionmarks];
        [_questionmark setTitle:@"Close Tooltips" forState:UIControlStateNormal];
        _questionImage.hidden=YES ;
    }
    
    else
    {
        [self hideQuestionmark];
        [self.controller hideQuestionMarks];
        [_questionmark setTitle:@"" forState:UIControlStateNormal];
        _questionImage.hidden=NO ;
        
    }
 }

-(void)loadQuestionmarks
{
    
    _maskViewforbottompanel.hidden=NO ;
    _maskViewforbottompanel.alpha=0.5 ;
    swipeUp.enabled=NO ;
    swipeDown.enabled=NO ;
    self.imageView.alpha=0.3;
    self.noImage.hidden=YES ;
    scrollpanel.userInteractionEnabled=NO;
    scrollpanel.alpha=0.75;
    _AutomaticShutterBtn.userInteractionEnabled=NO ;
    
    self.imageNavigationtoolbar.nextButtonView.userInteractionEnabled=NO ;
    self.imageNavigationtoolbar.prevButtonView.userInteractionEnabled=NO ;
    self.imageNavigationtoolbar.overviewButtonView.userInteractionEnabled=NO;
    self.imageNavigationtoolbar.RunButtonView.userInteractionEnabled=NO;

    
    for(UIView *subview in [self subviews])
    {
        
        if ([subview isKindOfClass:[UIImageView class]])
        {
            
        
        UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
            
           // if (!subview.hidden)
            {
                [self addSubview:questionmarkVIEW];
                questionmarkVIEW.tag=_tagValuestanduiPanel++ ;
                
                questionmarkVIEW.center=subview.center ;
                
                questionmarkVIEW.layer.transform = CATransform3DRotate(questionmarkVIEW.layer.transform,DEGREES_TO_RADIANS(-cumulatedAngle) , 0.0, 0.0, 1.0) ;
                
                if (flip)
                {
                    questionmarkVIEW.layer.transform = CATransform3DRotate(questionmarkVIEW.layer.transform, angle_flip, 1.0, 0.0, 0.0) ;
                     _flipAngle=angle_flip ;
                    _flipisON=flip ;
                }
                
                if (mirror)
                {
                     questionmarkVIEW.layer.transform = CATransform3DRotate(questionmarkVIEW.layer.transform, angle_mirror, 0.0, 1.0, 0.0) ;
                    _mirrorAngle=angle_mirror ;
                    _mirrorisON=mirror ;
                }
                
                 
                self.standuiCumulativeAngle=-cumulatedAngle ;
                subview.alpha=0.2 ;

            }
            
            if(subview.hidden || !_questionmarkPressed)
            {
                questionmarkVIEW.hidden=YES ;
                
            }
            
             subview.userInteractionEnabled=NO ;
        }
    }
    
    
    
    for(UIView *subview in [self.rightPanel subviews])
    {
        
        if ([subview isKindOfClass:[UIButton class]])
        {
            
            UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
            
            
            if (!subview.hidden && subview.tag==101)
            {
                [self.rightPanel addSubview:questionmarkVIEW];
                questionmarkVIEW.tag = _tagValueRightPanel++ ;
                
                questionmarkVIEW.center=subview.center ;
                subview.userInteractionEnabled=NO ;
            }
            
            else if(subview.hidden || !_questionmarkPressed)
            {
                questionmarkVIEW.hidden=YES ;
                
            }

           }//button type only
        
        
        if ([subview isKindOfClass:[UILabel class]])
        {
            
            subview.alpha=0.4 ;
            
        }

        
    }
    
    
    for (UIView *subview in [self.imageNavigationtoolbar subviews])
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
             UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
            
            
            if (!subview.hidden)
            {
                [self.imageNavigationtoolbar addSubview:questionmarkVIEW];
                questionmarkVIEW.tag=_tagValuesimagenavigationtollbar++;
                questionmarkVIEW.center=subview.center ;
                subview.userInteractionEnabled=NO ;
                
                
            }
            
            else if(subview.hidden || !_questionmarkPressed)
            {
                questionmarkVIEW.hidden=YES ;
                
            }
            
            
        }
        
        
        
    }
    
    for (UIView *subview in [self.topviewpanel subviews]) {
        if (subview.tag==10 || subview.tag==11)
        {
            UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
            if (!subview.hidden)
            {
                [self.topviewpanel addSubview:questionmarkVIEW];
                questionmarkVIEW.tag=_tagValuetopPanel++ ;
                questionmarkVIEW.center=subview.center ;
                subview.userInteractionEnabled=NO ;
                
            }
            
            else if(subview.hidden || !_questionmarkPressed)
            {
                questionmarkVIEW.hidden=YES ;
                
            }

            
        }
    }
    
   for(UIView *subview in [self.imageNavigationtoolbar.pageNavigationtoolbar subviews])
   {
       
       UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
       
       if ([subview isKindOfClass:[UIButton class]] && !subview.hidden)
       {
        
            [self.imageNavigationtoolbar.pageNavigationtoolbar addSubview:questionmarkVIEW];
           questionmarkVIEW.tag=_tagValuepagecontrol++;
           questionmarkVIEW.center=subview.center ;
           
           
       }
       
       else if(subview.hidden || !_questionmarkPressed)
       {
           questionmarkVIEW.hidden=YES ;
           
       }
       
       self.imageNavigationtoolbar.pageNavigationtoolbar.userInteractionEnabled=NO ;
       
   }

     
 }

-(void)hideQuestionmark
{
    
    _maskViewforbottompanel.hidden=YES ;
    _maskViewforbottompanel.alpha=0.0 ;
    swipeUp.enabled=YES ;
    swipeDown.enabled=YES ;
     self.imageView.alpha=1.0;
    scrollpanel.userInteractionEnabled=YES ;
    scrollpanel.alpha=1.0 ;
    
    
    for(UIView *subview in [self subviews])
    {
        
        if ([subview isKindOfClass:[UIImageView class]])
        {
        
            if (subview.tag>=400)
            {
                [subview removeFromSuperview];
            }
            
        
            subview.alpha=1.0 ;
            self.leftImageview.alpha=0.7;
            self.rightImageview.alpha=0.7;
            self.rotate_circle_view.alpha=0.6 ;
            subview.userInteractionEnabled=YES ;
            
        }
    }
    
    for (UIView *subview in [self.topviewpanel subviews])
    {
        if (subview.tag==100)
        {
            [subview removeFromSuperview];
        }
        subview.userInteractionEnabled=YES ;
    }
    
    for(UIView *subview in [self.rightPanel subviews])
    {
        
        if ([subview isKindOfClass:[UIImageView class]])
        {
           
            if (subview.tag>=200 && subview.tag<=208)
            {
                NSLog(@"subview tag value is %ld",(long)subview.tag);
               
                [subview removeFromSuperview];
            }
        
                  
        }
        
        if ([subview isKindOfClass:[UILabel class]])
        {
            
            subview.alpha=1.0 ;
            
        }
        
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
        if ([subview isKindOfClass:[UIButton class]] && !subview.hidden)
        {
              subview.userInteractionEnabled=YES ;
        }
      
    }
    
    
    for (UIView *subview in [self subviews])
    {
        if (subview.tag==300)
        {
            [subview removeFromSuperview];
        }
    }
    
    for (UIView *subview in [self.imageNavigationtoolbar subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            
            if (subview.tag>=600)
            {
                [subview removeFromSuperview];
            }
        }
        
        if([subview isKindOfClass:[UIButton class]])
        {
            if (!subview.hidden) {
                subview.userInteractionEnabled=YES ;
            }
            
        }
        
        
        
        
        
    }
    
    for (UIView *subview in [self.imageNavigationtoolbar.pageNavigationtoolbar subviews])
    {
        if (subview.tag==800 || subview.tag==801)
        {
            [subview removeFromSuperview];
        }
        
        self.imageNavigationtoolbar.pageNavigationtoolbar.userInteractionEnabled=YES ;
    }
    
    self.imageNavigationtoolbar.nextButtonView.userInteractionEnabled=YES ;
    self.imageNavigationtoolbar.prevButtonView.userInteractionEnabled=YES ;
    self.imageNavigationtoolbar.overviewButtonView.userInteractionEnabled=YES;
    self.imageNavigationtoolbar.RunButtonView.userInteractionEnabled=YES;
    
    
}


-(BOOL)checkOutsideCircle_Bounds:(CGPoint)pointoutside
{
    
    CGFloat lhs = (pointoutside.x-self.circleCenter.x)*(pointoutside.x-self.circleCenter.x)+(pointoutside.y-self.circleCenter.y)*(pointoutside.y-self.circleCenter.y);
    CGFloat rhs =self.circleRadius*self.circleRadius ;

    
    if (lhs>rhs)
    {
        return NO ;
    }
    
    else
    {
        return YES ;
        
    }
    
    
    
}

#pragma mark - park button and recall button implementation

-(IBAction)parkButton_pressed:(id)sender
{
    parkview= [[UIView alloc]initWithFrame:CGRectMake(300, 200, 600, 300)];
    
    [self.controller.view addSubview:parkview];
    parkview.backgroundColor=[UIColor clearColor];
    
    parkpanel1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"park_1.png"]];
    parkpanel2 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"park_2.png"]];
    
    [parkview addSubview:parkpanel1];
    [parkview addSubview:parkpanel2];
    
    CGPoint panel2Center =CGPointMake(parkpanel1.center.x+parkpanel1.bounds.size.width+offsetValue,parkpanel1.center.y);
    
    parkpanel2.center = panel2Center ;
    
    [self performSelector:@selector(park_animation) withObject:nil afterDelay:0.5];
    [self performSelector:@selector(fade_panel) withObject:nil afterDelay:2.0];
    
    _parkButton.userInteractionEnabled=NO;
      _recallButton.userInteractionEnabled=NO;
    
}

-(void)park_animation
{
    
     UIImageView *parkCircle =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"park_3.png"]];
    
    [parkview addSubview:parkCircle];
    
    parkCircle.center =parkpanel1.center ;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    parkCircle.center =parkpanel2.center ;
    [UIView commitAnimations];
    
}

-(void)park_animation2
{
    
    UIImageView *parkCircle =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"park_3.png"]];
    
    [parkview addSubview:parkCircle];
    
    parkCircle.center =parkpanel2.center ;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    parkCircle.center =parkpanel1.center ;
    [UIView commitAnimations];
    
}



-(void)fade_panel
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    parkview.alpha=0.0;
    [parkview removeFromSuperview];
    _parkButton.userInteractionEnabled=YES ;
    _recallButton.userInteractionEnabled=YES ;
    [UIView commitAnimations];
    
    
}

-(IBAction)recallbutton_pressed:(id)sender
{
    parkview= [[UIView alloc]initWithFrame:CGRectMake(300, 200, 600, 300)];
    
    [self.controller.view addSubview:parkview];
    parkview.backgroundColor=[UIColor clearColor];
    
    parkpanel1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"park_1.png"]];
    parkpanel2 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"park_1.png"]];
    
    [parkview addSubview:parkpanel1];
    [parkview addSubview:parkpanel2];
    
    CGPoint panel2Center =CGPointMake(parkpanel1.center.x+parkpanel1.bounds.size.width+offsetValue,parkpanel1.center.y);
    
    parkpanel2.center = panel2Center ;
    
    [self performSelector:@selector(park_animation2) withObject:nil afterDelay:0.5];
    [self performSelector:@selector(fade_panel) withObject:nil afterDelay:2.0];
    
    _recallButton.userInteractionEnabled=NO;
    _parkButton.userInteractionEnabled=NO ;

    
    
}


@end
