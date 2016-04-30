//
//  imageReview.m
//  StandUI
//
//  Created by PhilipsIT5 on 10/15/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "imageReview.h"
#import "StandUI.h"



// Image review Mode
#define FORWARD     TRUE
#define BACKWARD    FALSE

// Dictionary Keys
#define MAXRUNS             (12+1)
#define IMAGENAME           @"IMAGENAME"
#define RUNNUMBER           @"RUNNUMBER"
#define CAPTUREDIMAGECOUNT  @"IMAGECOUNT"

// Image Names
#define SKELETON_LEG_1  @"Skel_Leg_1_1K.png"
#define SKELETON_LEG_2  @"Skel_Leg_2_1K.png"
#define VASCULAR_ABD_1  @"Vasc_Abd_1_1K.png"
#define VASCULAR_ABD_2  @"Vasc_Abd_2_1K.png"

@interface imageReview ()

@property(nonatomic)StandUI *standUIView;

@end


@implementation imageReview
@synthesize     CurrentImageReviewSize;
@synthesize     CurrentImageReviewMode;
@synthesize     currentRun;
@synthesize     currentImageNo;
@synthesize     currentImageName;

@synthesize     StoredImagesDict;
@synthesize     standUIView;

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


-(void)InitialiseView
{
     [self InitialiseStoredImageDict];
     CurrentImageReviewSize = FULLSIZE ;
     CurrentImageReviewMode = SISD;
     [self UpdateToolBarIcons:CurrentImageReviewSize];
     [self UpdateToolBarIcons:CurrentImageReviewMode];
   
    _singleimagepressed= NO ;
    _allimagepressed=NO ;
    _overviewButtonClicked=NO ;
    
    // Image Navigation toolbar

    [self MaskButtonlayer:self.nextButtonView:( UIRectCornerTopRight| UIRectCornerBottomRight)];
    [self MaskButtonlayer:self.prevButtonView:( UIRectCornerTopLeft| UIRectCornerBottomLeft)];
    
    [self MaskButtonlayer:self.pageNavigationtoolbar :( UIRectCornerTopLeft | UIRectCornerBottomRight | UIRectCornerBottomLeft | UIRectCornerTopRight)];
  
    [self Hide_UnhideAllNavigationToolBarViews:YES];
    
    [self.pageNavigationtoolbar setHidden:YES];
    self.imageReviewMode= NO;
    UIColor *grayishColor =[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0];
    
    self.prevButtonView.backgroundColor=[grayishColor colorWithAlphaComponent:0.5];
    self.nextButtonView.backgroundColor=[grayishColor colorWithAlphaComponent:0.5];
    self.RunButtonView.backgroundColor=[grayishColor colorWithAlphaComponent:0.5];
    self.overviewButtonView.backgroundColor=[grayishColor colorWithAlphaComponent:0.5];
}

-(void)Hide_UnhideAllNavigationToolBarViews:(BOOL)val
{
    self.nextButtonView.hidden = val;
    self.prevButtonView.hidden = val;
    self.RunButtonView.hidden = val;
    self.overviewButtonView.hidden = val;
}

-(void)ShareInstance:(void*)parentview
{
    standUIView = (__bridge StandUI*)parentview;
}

-(void)InitialiseStoredImageDict
{
    currentRun =0;
    currentImageNo=1;
    currentImageName = SKELETON_LEG_1;
    
    StoredImagesDict = [[NSMutableArray alloc] init];
    [self AddImageObjecttoDict :1 :SKELETON_LEG_1 :1];
    [self AddImageObjecttoDict :2 :SKELETON_LEG_2 :1];
    [self AddImageObjecttoDict :3 :SKELETON_LEG_1 :1];
    [self AddImageObjecttoDict :4 :SKELETON_LEG_2 :1];
    [self AddImageObjecttoDict :5 :SKELETON_LEG_1 :1];
    [self AddImageObjecttoDict :6 :SKELETON_LEG_2 :1];
    [self AddImageObjecttoDict :7 :SKELETON_LEG_1 :1];
    [self AddImageObjecttoDict :8 :SKELETON_LEG_2 :1];
    [self AddImageObjecttoDict :9 :SKELETON_LEG_1 :4];
    [self AddImageObjecttoDict :10 :SKELETON_LEG_2 :4];
    [self AddImageObjecttoDict :11 :VASCULAR_ABD_1 :6];
    [self AddImageObjecttoDict :12 :VASCULAR_ABD_2 :8];
}

-(void)AddImageObjecttoDict:(int)runNumber :(NSString*)imageName  :(int)totalImageCount
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:imageName forKey:IMAGENAME];
    [dict setValue:[NSNumber numberWithInt:runNumber] forKey:RUNNUMBER];
    [dict setValue:[NSNumber numberWithInt:totalImageCount] forKey:CAPTUREDIMAGECOUNT];
    [StoredImagesDict  addObject:dict];
}

-(void)createDictionary
{
    
    
    
}

-(NSDictionary*)GetImageObjectFromDict:(int)runnumber
{
    runnumber = runnumber -1;// since index starts from 0
    NSDictionary *dict = [StoredImagesDict objectAtIndex:runnumber];
    return dict;
}

-(void)MaskButtonlayer:(UIView*)btn :(UIRectCorner)val
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



- (IBAction)NextImageBtnClicked:(id)sender
{
    if (_singleimagepressed)
    {
        currentRun=[_RunLabel.text intValue];
        currentImageNo=[_imageNolabel.text intValue];
         NSDictionary *dict =  [self GetImageObjectFromDict:currentRun];
        dict =  [self GetImageObjectFromDict:currentRun];
         currentImageName =[dict valueForKey:IMAGENAME];
    }
    else
    {
        int imageno;
        [self initImageReviewMode:FORWARD];
        NSDictionary *dict =  [self GetImageObjectFromDict:currentRun];
        imageno = [[dict valueForKey:CAPTUREDIMAGECOUNT] intValue];
        if( (currentImageNo >= imageno ) || (CurrentImageReviewMode == SIDD))
        {
            currentRun = (((currentRun+1) % MAXRUNS) == 0) ? 1:((currentRun+1) % MAXRUNS);
            dict =  [self GetImageObjectFromDict:currentRun];
            currentImageNo = 1;
            currentImageName =[dict valueForKey:IMAGENAME];
        }
        else
        {
            currentImageNo = currentImageNo +1;
        }
    }//else
    
    [standUIView changeXRayImage:currentImageName];
    self.RunLabel.text =  [NSString stringWithFormat: @"%d", currentRun];
    self.imageNolabel.text =  [NSString stringWithFormat: @"%d", currentImageNo];
    NSLog(@" Run Number %d \n Image No %d\n Image Name %@",currentRun,currentImageNo,currentImageName);
    
}

- (IBAction)PreviousImageBtnClicked:(id)sender
{
    if (_singleimagepressed)
    {
        currentRun=[_RunLabel.text intValue];
        currentImageNo=[_imageNolabel.text intValue];
        NSDictionary *dict =  [self GetImageObjectFromDict:currentRun];
        dict =  [self GetImageObjectFromDict:currentRun];
        currentImageName =[dict valueForKey:IMAGENAME];
    }
   else
   {
       int imageno;
    [self initImageReviewMode:BACKWARD];
    NSDictionary *dict =  [self GetImageObjectFromDict:currentRun];
    imageno = [[dict valueForKey:CAPTUREDIMAGECOUNT] intValue];
       NSLog(@"current run is %d",currentRun);
  
    if( (currentImageNo <= 1 ) || (CurrentImageReviewMode == SIDD))
    {
        currentRun = (((currentRun-1) % MAXRUNS) == 0) ? 12:((currentRun-1) % MAXRUNS);

        dict =  [self GetImageObjectFromDict:currentRun];
        currentImageNo = [[dict valueForKey:CAPTUREDIMAGECOUNT] intValue];
        currentImageName =[dict valueForKey:IMAGENAME];
    }
    else
    {
        currentImageNo = currentImageNo - 1;
    }
    
   }
    [standUIView changeXRayImage:currentImageName];
    self.RunLabel.text =  [NSString stringWithFormat: @"%d", currentRun];
    self.imageNolabel.text =  [NSString stringWithFormat: @"%d", currentImageNo];
    NSLog(@" Run Number %d \n Image No %d\n Image Name %@",currentRun,currentImageNo,currentImageName);
    
}

- (IBAction)Pause_RunCycleBtnClicked:(id)sender
{
    if(self.imageReviewMode == NO)
    {
       // _singleimagepressed=YES ;
        currentRun=[_RunLabel.text intValue];
        currentImageNo=[_imageNolabel.text intValue];
        [self PreviousImageBtnClicked:nil];
    }
    CurrentImageReviewMode = (CurrentImageReviewMode == SISD)?SIDD:SISD;
    if(CurrentImageReviewMode == SIDD)
    {   [self.RunLabel setHidden:NO];
        [self.imageNolabel setHidden:YES];
        CurrentImageReviewSize = FULLSIZE;
        
        [self UpdateToolBarIcons:CurrentImageReviewSize];
    }
    else
    {
        NSLog(@"run value is %d",currentRun);
        
        NSDictionary *dict =  [self GetImageObjectFromDict:currentRun];
        currentImageNo = [[dict valueForKey:CAPTUREDIMAGECOUNT] intValue];
        self.imageNolabel.text = [NSString stringWithFormat: @"%d", currentImageNo];
        [self.imageNolabel setHidden:NO];
        [self.RunLabel setHidden:NO];
    }
    [self UpdateToolBarIcons:CurrentImageReviewMode];
   
}

- (IBAction)Single_OverviewBtnClicked:(id)sender
{
    if(self.imageReviewMode == NO)
     {
         [standUIView switchtoImageReviewMode];
         self.imageReviewMode = YES;
     }
    _overviewButtonClicked=!_overviewButtonClicked ;
    
    CurrentImageReviewSize = (CurrentImageReviewSize == FULLSIZE) ?OVERVIEW: FULLSIZE ;

    if( CurrentImageReviewSize == OVERVIEW)
    {
        CurrentImageReviewMode =SISD;
       // [self.imageNolabel setHidden:NO];
        [self UpdateToolBarIcons:CurrentImageReviewMode];
    }
    [self UpdateToolBarIcons:CurrentImageReviewSize];
}

-(void)initImageReviewMode:(BOOL)val
{
    if(self.imageReviewMode == NO)
    {
        if(val == FORWARD) // Next or RunCycle is tapped
        {
            currentRun = MAXRUNS-1;
            currentImageNo = 12;
        }
        else // Backward
        {
            currentRun = 1;
            currentImageNo = 1;
        }
        self.imageReviewMode= YES;
        [standUIView switchtoImageReviewMode];
        [self.imageNolabel setHidden:NO];
        [self.RunLabel setHidden:NO];
    }
}

-(void)ReInitialise
{
    self.imageReviewMode= NO;
    [self.imageNolabel setHidden:YES];
    [self.RunLabel setHidden:YES];
    CurrentImageReviewSize = FULLSIZE ;
    CurrentImageReviewMode = SISD;
    [self UpdateToolBarIcons:CurrentImageReviewSize];
    [self UpdateToolBarIcons:CurrentImageReviewMode];
}

-(void)UpdateToolBarIcons:(NSInteger)val
{
    if( val == OVERVIEW || val == FULLSIZE) // Update only the Overview or Isnglel image icon
    {
        if (!_overviewButtonClicked)
        {
            CurrentImageReviewSize=FULLSIZE ;
           // _singleimagepressed=NO ;
        }
        if( CurrentImageReviewSize == FULLSIZE)
        {
            [self.Single_OverviewBtnImage setImage:[UIImage imageNamed:@"MovieOverview.png"]];
            //[self.pageNavigationtoolbar setHidden:YES];
            [standUIView  hide_UnHide_PageNavigationButtons:YES];
        }
        else
        {
            [self.Single_OverviewBtnImage setImage:[UIImage imageNamed:@"SingleImageAlt.png"]];
           // [self.pageNavigationtoolbar setHidden:NO];
            [standUIView  hide_UnHide_PageNavigationButtons:NO];
        }
    }
    else // Update navigation (Next and Previous) icons
    {
        if( CurrentImageReviewMode == SISD)
        {
            [self.previousBtnImage setImage:[UIImage imageNamed:@"PreviousImageAlt.png"]];
            [self.nextBtnImage setImage:[UIImage imageNamed:@"NextImageAlt.png"]];
            [self.Pause_RunCycleBtnImage setImage:[UIImage imageNamed:@"MovieSeriesCycle.png"]];
        }
        else
        {
            [self.previousBtnImage setImage:[UIImage imageNamed:@"MovieSeriesPrevious.png"]];
            [self.nextBtnImage setImage:[UIImage imageNamed:@"MovieSeriesNext.png"]];
         //   self.Pause_RunCycleBtnImage.frame = CGRectMake(100, 12, 20, 18);
            [self.Pause_RunCycleBtnImage setImage:[UIImage imageNamed:@"MoviePause.png"]];
        }
    }
}

- (IBAction)PageUpBtnClicked:(id)sender
{
    
}

- (IBAction)PageDownBtnClicked:(id)sender
{
    
}

@end
