//
//  PositionMemory.m
//  StandUI
//
//  Created by PhilipsIT5 on 8/21/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "PositionMemory.h"
#import "PositionMemoryConstants.h"
#import "SimulationConstants.h"
#import "../Constants.h"

@implementation PositionMemory

// UI Buttons
@synthesize aStoreClearBtn;
@synthesize bStoreClearBtn;
@synthesize cStoreClearBtn;
@synthesize finalStoreBtn;

// UI Views
@synthesize cARMControlsView;
@synthesize aStoreView;
@synthesize bStoreView;
@synthesize cStoreView;
@synthesize selectedRunView;
@synthesize currentStoreIdx;

// CURRENT POSTION labels
@synthesize cpRotationLabel;
@synthesize cpAngulationLabel;
@synthesize cpLongitudinalLabel;
@synthesize cpHeightLabel;


// Store A postion labels
@synthesize aRotationLabel;
@synthesize aAngulationLabel;
@synthesize aLongitudinalLabel;
@synthesize aHeightLabel;

// Store B position labels
@synthesize bRotationLabel;
@synthesize bAngulationLabel;
@synthesize bLongitudinalLabel;
@synthesize bHeightLabel;

// Store C CARM position labels

@synthesize cRotationLabel;
@synthesize cAngulationLabel;
@synthesize cLongitudinalLabel;
@synthesize cHeightLabel;

// Selected Run C-ARM Position labels
@synthesize srRotationLabel;
@synthesize srAngulationLabel;
@synthesize srLongitudinalLabel;
@synthesize srHeightLabel;

// Expandable buttons
@synthesize aStoreExpandableView;
@synthesize bStoreExpandableView;
@synthesize cStoreExpandableView;
@synthesize selectedRunExpandableView;

// Business logic
@synthesize  cArmPostionDict;
@synthesize cArmPostionStatus;
@synthesize pmCurrSystemMode;

@synthesize currentRotationValue;
@synthesize currentAngulationValue;
@synthesize currentLongitudinalValue;
@synthesize currentHeightValue;


// Time labels
@synthesize aStoreLabel;
@synthesize bStoreLabel;
@synthesize cStoreLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [ self initPositionMemoryView];
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

-(void)initPositionMemoryView
{
    self.backgroundColor=[[UIColor clearColor]colorWithAlphaComponent:0.0];
    pmCurrSystemMode = NOIMAGE;
    [self changealphaValues];
    [self initialiseButtonStyle:aStoreClearBtn];
    [self initialiseButtonStyle:bStoreClearBtn];
    [self initialiseButtonStyle:cStoreClearBtn];
    [self initialiseButtonStyle:finalStoreBtn];
    [self initialiseDict];
    [self initialiseCArmPositios];
    [self HideViews];
    CArmPos = [StandUICARMPosition shareCARMManager];
    
    [CArmPos addObserver:self forKeyPath:@"RotationPos" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [CArmPos addObserver:self forKeyPath:@"AngulationPos" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [CArmPos addObserver:self forKeyPath:@"LongitudinalPos" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [CArmPos addObserver:self forKeyPath:@"HeightPos" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"pmCurrSystemMode" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    cpRotationLabel.text = CArmPos.RotationPos;
    cpAngulationLabel.text = CArmPos.AngulationPos;
    cpLongitudinalLabel.text = CArmPos.LongitudinalPos;
    cpHeightLabel.text = CArmPos.HeightPos;
   
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"RotationPos"]) {
        cpRotationLabel.text =[change objectForKey:NSKeyValueChangeNewKey];
        if( pmCurrSystemMode == LIVE)
        {
            srRotationLabel.text = [change objectForKey:NSKeyValueChangeNewKey];
        }
    }
    else if ([keyPath isEqualToString:@"AngulationPos"]) {
        cpAngulationLabel.text =[change objectForKey:NSKeyValueChangeNewKey];
        if( pmCurrSystemMode == LIVE)
        {
            srAngulationLabel.text = [change objectForKey:NSKeyValueChangeNewKey];
        }
    }
    else if ([keyPath isEqualToString:@"LongitudinalPos"]) {
        cpLongitudinalLabel.text =[change objectForKey:NSKeyValueChangeNewKey];
        if( pmCurrSystemMode == LIVE)
        {
            srLongitudinalLabel.text = [change objectForKey:NSKeyValueChangeNewKey];
        }
    }
    else if ([keyPath isEqualToString:@"HeightPos"]) {
       cpHeightLabel.text =[change objectForKey:NSKeyValueChangeNewKey];
        if( pmCurrSystemMode == LIVE)
        {
            srHeightLabel.text = [change objectForKey:NSKeyValueChangeNewKey];
        }
    }
    else if ([keyPath isEqualToString:@"pmCurrSystemMode"]) {
        pmCurrSystemMode = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if( pmCurrSystemMode == LIVE)
        {
            srRotationLabel.text =CArmPos.RotationPos;
            srAngulationLabel.text =CArmPos.AngulationPos;
            srLongitudinalLabel.text =CArmPos.LongitudinalPos;
            srHeightLabel.text =CArmPos.HeightPos;
        }
        else if( pmCurrSystemMode == NOIMAGE)
        {
            [self newExamBtnClicked];
        }
    }
}

-(void)changealphaValues
{
    UIColor *darkcolor =[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
    
    aStoreExpandableView.backgroundColor=[darkcolor colorWithAlphaComponent:0.5];
    bStoreExpandableView.backgroundColor=[darkcolor colorWithAlphaComponent:0.5];
    cStoreExpandableView.backgroundColor=[darkcolor colorWithAlphaComponent:0.5];
    selectedRunExpandableView.backgroundColor=[darkcolor colorWithAlphaComponent:0.5];
    
    aStoreView.backgroundColor=[darkcolor colorWithAlphaComponent:0.5];
    bStoreView.backgroundColor=[darkcolor colorWithAlphaComponent:0.5];
    cStoreView.backgroundColor=[darkcolor colorWithAlphaComponent:0.5];
    
    cARMControlsView.backgroundColor=[darkcolor colorWithAlphaComponent:0.5];
    selectedRunView.backgroundColor=[darkcolor colorWithAlphaComponent:0.5];
    _currentPositionView.backgroundColor=[darkcolor colorWithAlphaComponent:0.5];
    
    aStoreClearBtn.layer.cornerRadius=5.0;
    [aStoreClearBtn.layer setMasksToBounds:YES];
}

-(void)initialiseCArmPositios
{
    NSString *degreeSymbol = @"\u00B0";
    currentRotationValue =  0;
    currentAngulationValue =  0;
    currentLongitudinalValue = 10.0;
    currentHeightValue = 10.0;
   
    cpRotationLabel.text = [NSString stringWithFormat: @"%d%@", currentRotationValue,degreeSymbol];
    cpAngulationLabel.text = [NSString stringWithFormat: @"%d%@", currentAngulationValue,degreeSymbol];
    cpLongitudinalLabel.text = [NSString stringWithFormat: @"%.01f", currentLongitudinalValue];
    cpHeightLabel.text = [NSString stringWithFormat: @"%.01f", currentHeightValue];
}

-(void)initialiseButtonStyle:(UIButton*)button
{
    button.layer.cornerRadius = 2;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.backgroundColor = [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];
    [button setTintColor:[UIColor whiteColor]];
}

-(void)HideViews
{
    // Hide all Buttons
    aStoreClearBtn.hidden = YES;
    bStoreClearBtn.hidden = YES;
    cStoreClearBtn.hidden = YES;
    selectedRunExpandableView.hidden = YES;
    self.selectedRunImageView.image = [UIImage imageNamed:@"rightArrow.png"];
    [self HideorUnHideAStoreObjects:YES];
    [self HideorUnHideBStoreObjects:YES];
    [self HideorUnHideCStoreObjects:YES];
}

// Hide or UnHide """A Store""" CARM Objects
-(void)HideorUnHideAStoreObjects:(BOOL)val
{
    aStoreExpandableView.hidden = val;
    aRotationLabel.hidden = val;
    aAngulationLabel.hidden = val;
    aLongitudinalLabel.hidden = val;
    aHeightLabel.hidden = val;
}

// Hide or UnHide """B Store""" CARM Objects
-(void)HideorUnHideBStoreObjects:(BOOL)val
{
    bStoreExpandableView.hidden = val;
    bRotationLabel.hidden = val;
    bAngulationLabel.hidden = val;
    bLongitudinalLabel.hidden = val;
    bHeightLabel.hidden = val;
}

// Hide or UnHide """C Store""" CARM Objects
-(void)HideorUnHideCStoreObjects:(BOOL)val
{
    cStoreExpandableView.hidden = val;
    cRotationLabel.hidden = val;
    cAngulationLabel.hidden = val;
    cLongitudinalLabel.hidden = val;
    cHeightLabel.hidden = val;
}


- (IBAction)aStoreCleaerBtnClicked:(id)sender
{
    [self ResetCArmPostionsAtIndex:STOREPOSITIONA];
    if( currentStoreIdx > STOREPOSITIONA )
    {
        currentStoreIdx = STOREPOSITIONA;
    }
    self.aStoreImageView.image = [UIImage imageNamed:@"rightArrow.png"];
    finalStoreBtn.enabled=YES;
    finalStoreBtn.alpha = 1.0;
    aStoreClearBtn.hidden = YES;
    aStoreClearBtn.alpha = 0.3;
    aStoreClearBtn.enabled = NO;
    aStoreLabel.text = @"A";
    [self HideorUnHideAStoreObjects:YES];
}

- (IBAction)bStoreCleaerBtnClicked:(id)sender
{
    [self ResetCArmPostionsAtIndex:STOREPOSITIONB];
    if( currentStoreIdx > STOREPOSITIONB )
    {
        currentStoreIdx = STOREPOSITIONB;
    }
    self.bStoreImageView.image = [UIImage imageNamed:@"rightArrow.png"];
    finalStoreBtn.enabled=YES;
    finalStoreBtn.alpha = 1.0;
    bStoreClearBtn.alpha = 0.3;
    bStoreClearBtn.hidden = YES;
    bStoreClearBtn.enabled = NO;
    bStoreLabel.text = @"B";
    [self HideorUnHideBStoreObjects:YES];
}

- (IBAction)cStoreCleaerBtnClicked:(id)sender
{
    [self ResetCArmPostionsAtIndex:STOREPOSITIONC];
    if( currentStoreIdx > STOREPOSITIONC )
    {
        currentStoreIdx = STOREPOSITIONC;
    }
    self.cStoreImageView.image = [UIImage imageNamed:@"rightArrow.png"];
    finalStoreBtn.enabled=YES;
    finalStoreBtn.alpha = 1.0;
    cStoreClearBtn.alpha = 0.3;
    cStoreClearBtn.hidden = YES;
    cStoreClearBtn.enabled = NO;
    cStoreLabel.text = @"C";
    [self HideorUnHideCStoreObjects:YES];
}

- (IBAction)finalStoreBtnClicked:(id)sender
{
    if( currentStoreIdx<3)
    {
        NSMutableDictionary *dict = [cArmPostionDict objectAtIndex:currentStoreIdx];
        [dict setValue:cpRotationLabel.text forKey:CARMROTATION];
        [dict setValue:cpAngulationLabel.text forKey:CARMANGULATION];
        [dict setValue:cpLongitudinalLabel.text forKey:CARMLONGITUDINAL];
        [dict setValue:cpHeightLabel.text forKey:CARMHEIGHT];
        [cArmPostionDict replaceObjectAtIndex:currentStoreIdx withObject:dict];
        [cArmPostionStatus replaceObjectAtIndex:currentStoreIdx withObject:[NSNumber numberWithBool:YES]];
        [self UpdateAtStorePosition:currentStoreIdx];
        int indx = currentStoreIdx;
        BOOL val;
        while (indx < MAXSTORES) {
             val = [[cArmPostionStatus objectAtIndex:indx] boolValue];
            if( val == YES) {
                indx+=1;
            }
            else
            {
                break;
            }
        }
        currentStoreIdx = indx;
    }
    if( currentStoreIdx >= 3)
    {
        // disable the Store postion button or view
        finalStoreBtn.alpha = 0.5;
        finalStoreBtn.enabled=NO;
    }
}

-(void)UpdateAtStorePosition:(int)currIdx
{
    NSMutableDictionary *dict = [cArmPostionDict objectAtIndex:currIdx];
    switch (currIdx) {
        case STOREPOSITIONA:
            aStoreClearBtn.hidden = NO;
            aStoreClearBtn.enabled = YES;
            aStoreLabel.text = [self getCurrentTime:@"A"];
            aStoreClearBtn.alpha = 0.8;
            [self HideorUnHideAStoreObjects:NO];
            aRotationLabel.text =  [dict valueForKey:CARMROTATION];
            aAngulationLabel.text = [dict valueForKey:CARMANGULATION];
            aLongitudinalLabel.text = [dict valueForKey:CARMLONGITUDINAL];
            aHeightLabel.text = [dict valueForKey:CARMHEIGHT];
            self.aStoreImageView.image = [UIImage imageNamed:@"leftArrow.png"];
            break;
        case  STOREPOSITIONB:
            bStoreClearBtn.hidden = NO;
            bStoreClearBtn.enabled = YES;
            bStoreLabel.text = [self getCurrentTime:@"B"];
            bStoreClearBtn.alpha = 0.8;
            [self HideorUnHideBStoreObjects:NO];
            bRotationLabel.text =[ dict valueForKey:CARMROTATION];
            bAngulationLabel.text = [dict valueForKey:CARMANGULATION];
            bLongitudinalLabel.text = [dict valueForKey:CARMLONGITUDINAL];
            bHeightLabel.text = [dict valueForKey:CARMHEIGHT];
            self.bStoreImageView.image = [UIImage imageNamed:@"leftArrow.png"];
            break;
        case STOREPOSITIONC:
            cStoreClearBtn.hidden = NO;
            cStoreClearBtn.enabled = YES;
            cStoreLabel.text = [self getCurrentTime:@"C"];
            cStoreClearBtn.alpha = 0.8;
            [self HideorUnHideCStoreObjects:NO];
            cRotationLabel.text =[dict valueForKey:CARMROTATION];
            cAngulationLabel.text = [dict valueForKey:CARMANGULATION];
            cLongitudinalLabel.text = [dict valueForKey:CARMLONGITUDINAL];
            cHeightLabel.text = [dict valueForKey:CARMHEIGHT];
            self.cStoreImageView.image = [UIImage imageNamed:@"leftArrow.png"];
            break;
        default:
            break;
    }
}


-(NSString*)getCurrentTime:(NSString*)txt
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    return [NSString stringWithFormat:@"%@ (%d:%d)",txt,hour,minute];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint nowPoint  = [[touches anyObject] locationInView: self];
    
    for(UIView *subview in [self subviews])
    {
        if([subview isKindOfClass:[UIView class]] && CGRectContainsPoint(subview.frame, nowPoint))
        {
            if((subview == aStoreView ))
            {
              if (aStoreExpandableView.hidden == YES)
              {
                  aStoreExpandableView.hidden = NO;
                  aStoreClearBtn.hidden = NO;
                  self.aStoreImageView.image = [UIImage imageNamed:@"leftArrow.png"];
              }
            else
                {
                    aStoreExpandableView.hidden = YES;
                    aStoreClearBtn.hidden = YES;
                    self.aStoreImageView.image = [UIImage imageNamed:@"rightArrow.png"];
                }
            }
            else if (subview == bStoreView)
            {
                if( bStoreExpandableView.hidden  == YES)
                {
                    bStoreExpandableView.hidden = NO;
                    bStoreClearBtn.hidden = NO;
                    self.bStoreImageView.image = [UIImage imageNamed:@"leftArrow.png"];
                }
                else
                {
                    bStoreExpandableView.hidden = YES;
                    bStoreClearBtn.hidden = YES;
                    self.bStoreImageView.image = [UIImage imageNamed:@"rightArrow.png"];
                }
            }
            else if (subview == cStoreView )
            {
                if(cStoreExpandableView.hidden == YES )
                {
                    cStoreExpandableView.hidden = NO;
                    cStoreClearBtn.hidden = NO;
                    self.cStoreImageView.image = [UIImage imageNamed:@"leftArrow.png"];
                }
                else
                {
                    cStoreExpandableView.hidden = YES;
                    cStoreClearBtn.hidden = YES;
                    self.cStoreImageView.image = [UIImage imageNamed:@"rightArrow.png"];
                }
            }
            else if (subview == selectedRunView )
            {
                if(selectedRunExpandableView.hidden == YES )
                {
                  if(pmCurrSystemMode != NOIMAGE)
                  {
                    selectedRunExpandableView.hidden = NO;
                    self.selectedRunImageView.image = [UIImage imageNamed:@"leftArrow.png"];
                  }
                }
                else
                {
                    selectedRunExpandableView.hidden = YES;
                    self.selectedRunImageView.image = [UIImage imageNamed:@"rightArrow.png"];
                }
            }
            
        }
    }
}

-(void)initialiseDict
{
    cArmPostionDict = [[NSMutableArray alloc] init];
    cArmPostionStatus  = [[NSMutableArray alloc] init];
    currentStoreIdx = 0;
    for(int i=0;i<MAXSTORES;i++)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:@"0.0" forKey:CARMROTATION];
        [dict setValue:@"0.0" forKey:CARMANGULATION];
        [dict setValue:@"0.0" forKey:CARMLONGITUDINAL];
        [dict setValue:@"0.0" forKey:CARMHEIGHT];
        [cArmPostionDict  addObject:dict];
        [cArmPostionStatus insertObject:[NSNumber numberWithBool:NO] atIndex:i];
    }
}

-(void)ResetCArmPostionsAtIndex:(int)indx
{
    if( indx < MAXSTORES)
    {
     NSMutableDictionary *dict = [cArmPostionDict objectAtIndex:indx];
    [dict setValue:@"0.0" forKey:CARMROTATION];
    [dict setValue:@"0.0" forKey:CARMANGULATION];
    [dict setValue:@"0.0" forKey:CARMLONGITUDINAL];
    [dict setValue:@"0.0" forKey:CARMHEIGHT];
    [cArmPostionDict  replaceObjectAtIndex:indx withObject:dict];
    [cArmPostionStatus replaceObjectAtIndex:indx withObject:[NSNumber numberWithBool:NO]];
  //  [self UpdateAtStorePosition:indx];
    }
}



// Reset all the postion memory indicators when new exam button is clicked
- (void)newExamBtnClicked
{
    [self initialiseDict];
 //   [self initialiseCArmPositios];
    [self aStoreCleaerBtnClicked:nil];
    [self bStoreCleaerBtnClicked:nil];
    [self cStoreCleaerBtnClicked:nil];
    [self HideViews];
}

-(void)ResetSystemPositions
{
    NSString *degSymbol = @"\u00B0";
    
    srRotationLabel.text =[NSString stringWithFormat: @"%d%@", 0,degSymbol];
    srAngulationLabel.text = [NSString stringWithFormat: @"%d%@", 0,degSymbol];
    srLongitudinalLabel.text = [NSString stringWithFormat: @"%@", @"10.0"];
    srHeightLabel.text = [NSString stringWithFormat: @"%@", @"15.0"];
}

-(void)updateCArmPositionSelectedRun
{
    NSString *degSymbol = @"\u00B0";
    
      srRotationLabel.text =[NSString stringWithFormat: @"%d%@", currentRotationValue,degSymbol];
     srAngulationLabel.text = [NSString stringWithFormat: @"%d%@", currentAngulationValue,degSymbol];
     srLongitudinalLabel.text = [NSString stringWithFormat: @"%.01f", currentLongitudinalValue];
     srHeightLabel.text = [NSString stringWithFormat: @"%.01f", currentHeightValue];
    
}

@end
