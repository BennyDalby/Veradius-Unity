//
//  ExaminationTypeSelView.m
//  StandUI
//
//  Created by ganapathy.ln on 12/08/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "ExaminationTypeSelView.h"
#import "VascularView.h"
#import "SkeletonView.h"
#import "Constants.h"
#import "UrologyView.h"
#import "ExaminationTypeConstants.h"


@interface ExaminationTypeSelView ()

@property (nonatomic,assign) NSString *procedureType;
@property (nonatomic,assign) NSString *anatomyType;
@property (nonatomic,assign) NSString *detailedProcedureSelected;

@property (nonatomic,assign) int currentActiveView;
@property (nonatomic,assign) int previousSelectedView;


@end

@implementation ExaminationTypeSelView
// Syntehsize Views
@synthesize vascularview;
@synthesize skeletonView;
@synthesize urologyView;
@synthesize endoscopyView;
@synthesize cardioView;
@synthesize painView;

// Synthesise variables
@synthesize procedureType;
@synthesize anatomyType;
@synthesize currentActiveView;
@synthesize previousSelectedView;

@synthesize     skeletonButton;
@synthesize     urologyButton;
@synthesize     endoscopyButton;
@synthesize     vascularButton;
@synthesize     cardioButton;
@synthesize     painButton;
@synthesize     okButton;
@synthesize     cancelButton;
@synthesize     detailedProcedureSelected;
@synthesize     step2ContentLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect
{
    
}*/
-(void)initExamTypeSelectionView
{
    previousSelectedView = SKELETONVIEW;
    currentActiveView = SKELETONVIEW;
    // default values
    procedureType = SKELETON;

    // Skeleton button
    skeletonButton.layer.cornerRadius = 2;
    skeletonButton.layer.borderWidth = 2.0;
    skeletonButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    skeletonButton.backgroundColor =  [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];
    [skeletonButton setTitleColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0] forState:UIControlStateNormal];

    
    // Urology Button customisation
    //urologyButton.enabled = NO;
    urologyButton.layer.cornerRadius = 2;
    urologyButton.layer.borderWidth = 0.5;
    urologyButton.layer.borderColor = [UIColor blackColor].CGColor;
    urologyButton.backgroundColor =  [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];

    [ urologyButton setTintColor:[UIColor whiteColor]];
    
      // Endoscopy Button customisation
   //  endoscopyButton.enabled = NO;
    endoscopyButton.layer.cornerRadius = 2;
    endoscopyButton.layer.borderWidth = 0.5;
    endoscopyButton.layer.borderColor = [UIColor blackColor].CGColor;
    endoscopyButton.backgroundColor =  [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];

     [ endoscopyButton setTintColor:[UIColor whiteColor]];
    
    // vascularButton Button customisation
    vascularButton.layer.cornerRadius = 2;
    vascularButton.layer.borderWidth = 0.5;
    vascularButton.layer.borderColor = [UIColor blackColor].CGColor;
    vascularButton.backgroundColor =  [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];

    [vascularButton setTintColor:[UIColor whiteColor]];
   
    
    // cardioButton Button customisation
   //  cardioButton.enabled = NO;
    cardioButton.layer.cornerRadius = 2;
    cardioButton.layer.borderWidth = 0.5;
    cardioButton.layer.borderColor = [UIColor blackColor].CGColor;
    cardioButton.backgroundColor =  [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];

    [cardioButton setTintColor:[UIColor whiteColor]];

    
    // painButton Button customisation
   //  painButton.enabled = NO;
    painButton.layer.cornerRadius = 2;
    painButton.layer.borderWidth = 0.5;
    painButton.layer.borderColor = [UIColor blackColor].CGColor;
    painButton.backgroundColor =  [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];
    [painButton setTintColor:[UIColor whiteColor]];
    
    
    okButton.layer.cornerRadius = 2;
    okButton.layer.borderWidth = 0.5;
    okButton.layer.borderColor = [UIColor blackColor].CGColor;
    okButton.backgroundColor =[UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];
    [okButton setTintColor:[UIColor whiteColor]];
    
    cancelButton.layer.cornerRadius = 2;
    cancelButton.layer.borderWidth = 0.5;
    cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
    cancelButton.backgroundColor =
    [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:60.0/255.0 alpha:1.0];

    [cancelButton setTintColor:[UIColor whiteColor]];
    
    currentActiveView = SKELETONVIEW;
    procedureType =SKELETON;
    
    [urologyView InitialiseView];
    [endoscopyView InitialiseView];
    [cardioView InitialiseView ];
    [painView initialisePainView];
    [vascularview InitialiseVascularView];
    [skeletonView InitialiseSkeletonView];
}


- (IBAction)skeletonButtonCLicked:(id)sender {
    
    currentActiveView = SKELETONVIEW;
    procedureType =SKELETON;
    [step2ContentLabel setText:ANATOMY];
   // [self hideAllViews];
    [skeletonView setHidden:NO];
    
    [self changeButtonssBorderWidth];
    [self changeButtonssBorderColor:[UIColor blackColor]];

    skeletonButton.layer.borderWidth = 2.0;
    skeletonButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    [skeletonButton setTitleColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
   // [self enableOkButtons];
}


- (IBAction)urologyButtonCLicked:(id)sender
{
    procedureType =UROLOGY;
    currentActiveView = UROLOGYVIEW;
    [step2ContentLabel setText:PROCEDURE];
    [self hideAllViews];
    [urologyView setHidden:NO];
    
    [self changeButtonssBorderWidth];
    [self changeButtonssBorderColor:[UIColor blackColor]];
    
    urologyButton.layer.borderWidth = 2.0;
    urologyButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    [urologyButton setTitleColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0] forState:UIControlStateNormal];
}

- (IBAction)endoscopyButtonCLicked:(id)sender
{
    procedureType =ENDOSCOPY;
    currentActiveView = ENDOSCOPYVIEW;
    [step2ContentLabel setText:PROCEDURE];
    [self hideAllViews];
    [endoscopyView setHidden:NO];
    
    [self changeButtonssBorderWidth];
    [self changeButtonssBorderColor:[UIColor blackColor]];
    
    endoscopyButton.layer.borderWidth = 2.0;
    endoscopyButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    [endoscopyButton setTitleColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0] forState:UIControlStateNormal];
}


- (IBAction)painButtonCLicked:(id)sender
{
    procedureType =PAIN;
    currentActiveView = PAINVIEW;
    [step2ContentLabel setText:ANATOMY];
    [self hideAllViews];
    [painView setHidden:NO];
    
    [self changeButtonssBorderWidth];
    [self changeButtonssBorderColor:[UIColor blackColor]];
    
    painButton.layer.borderWidth = 2.0;
    painButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    
    [painButton setTitleColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0] forState:UIControlStateNormal];
}

- (IBAction)vascularButtonCLicked:(id)sender
{
    currentActiveView = VASCULARVIEW;
    procedureType =VASCULAR;
    [step2ContentLabel setText:ANATOMY];
    [self hideAllViews];
    [vascularview setHidden:NO];
    
    [self changeButtonssBorderWidth];
    [self changeButtonssBorderColor:[UIColor blackColor]];
    
    vascularButton.layer.borderWidth = 2.0;
    vascularButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;
    [vascularButton setTitleColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0] forState:UIControlStateNormal];
   // [self enableOkButtons];
}

- (IBAction)cardioButtonCLicked:(id)sender
{
    procedureType =CARDIO;
    currentActiveView = CARDIOVIEW;
    [step2ContentLabel setText:PROCEDURE];
    [self hideAllViews];
    [cardioView setHidden:NO];
    
    [self changeButtonssBorderWidth];
    [self changeButtonssBorderColor:[UIColor blackColor]];
    
    cardioButton.layer.borderWidth = 2.0;
    cardioButton.layer.borderColor = [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:97.0/255.0 alpha:1.0].CGColor;

    [cardioButton setTitleColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0] forState:UIControlStateNormal];
}


-(void)changeButtonssBorderColor:(UIColor *)color
{
    vascularButton.layer.borderColor = color.CGColor;
    skeletonButton.layer.borderColor = color.CGColor;
    urologyButton.layer.borderColor = color.CGColor;
    endoscopyButton.layer.borderColor = color.CGColor;
    cardioButton.layer.borderColor = color.CGColor;
    painButton.layer.borderColor = color.CGColor;
    
    [vascularButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [skeletonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [urologyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [endoscopyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cardioButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [painButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)changeButtonssBorderWidth
{
    vascularButton.layer.borderWidth = .50;
    skeletonButton.layer.borderWidth = .50;
    urologyButton.layer.borderWidth = .50;
    endoscopyButton.layer.borderWidth = .50;
    cardioButton.layer.borderWidth = .50;
    painButton.layer.borderWidth = .50;
}

-(void)enableOkButtons
{
    NSString *bodypartselected;
    switch (currentActiveView) {
        case SKELETONVIEW:
            bodypartselected = [skeletonView  anatomyPorcedureSelected];
             if([bodypartselected isEqual:ANATOMYSKELETONLEGS] )
             {
                  okButton.enabled=YES;
             }
            else
            {
                 okButton.enabled=NO;
            }
            break;
        case VASCULARVIEW:
            bodypartselected = [vascularview  anatomyPorcedureSelected];
            if( [bodypartselected isEqual:ANATOMYABDOMINAL])
            {
                okButton.enabled=YES;
            }
            else
            {
                 okButton.enabled=NO;
            }
            break;
        default:
            break;
    }
  
}

-(void)hideAllViews
{
    [vascularview setHidden:YES];
    [skeletonView setHidden:YES];
    [endoscopyView setHidden:YES];
    [urologyView setHidden:YES];
    [cardioView setHidden:YES];
    [painView setHidden:YES];
}


- (IBAction)OKButtonCLicked:(id)sender
{
    previousSelectedView =currentActiveView;
    switch (currentActiveView) {
        case UROLOGYVIEW:
            anatomyType = [urologyView anatomyTypeSelected];
            detailedProcedureSelected = [urologyView  anatomyPorcedureSelected];
            break;
        case ENDOSCOPYVIEW:
            anatomyType = [endoscopyView anatomyTypeSelected];
            detailedProcedureSelected = [endoscopyView  anatomyPorcedureSelected];
            break;
        case CARDIOVIEW:
            anatomyType = [cardioView anatomyTypeSelected];
            detailedProcedureSelected = [cardioView  anatomyPorcedureSelected];
            break;
        case SKELETONVIEW:
            anatomyType = [skeletonView anatomyTypeSelected];
            detailedProcedureSelected = [skeletonView  anatomyPorcedureSelected];
            break;
        case VASCULARVIEW:
            anatomyType = [vascularview anatomyTypeSelected];
            detailedProcedureSelected = [vascularview  anatomyPorcedureSelected];
            break;
        case PAINVIEW:
            anatomyType = [painView anatomyTypeSelected];
            detailedProcedureSelected = [painView  anatomyPorcedureSelected];
            break;
        default:
            break;
    }
    [self.examinationTypeSelectiondelegate ExaminationTypeSelComplete :procedureType :detailedProcedureSelected :anatomyType];
}

- (IBAction)CancelButtonCLicked:(id)sender
{
    self.hidden=YES;
    switch (previousSelectedView) {
        case UROLOGYVIEW:
            [self urologyButtonCLicked:nil];
            break;
        case ENDOSCOPYVIEW:
            [self endoscopyButtonCLicked:nil];
            break;
        case CARDIOVIEW:
            [self cardioButtonCLicked:nil];
            break;
        case SKELETONVIEW:
            [self skeletonButtonCLicked:nil];
            break;
        case VASCULARVIEW:
            [self vascularButtonCLicked:nil];
            break;
        case PAINVIEW:
            [self painButtonCLicked:nil];
            break;
        default:
            break;
    }
   
}

-(int)getCurrentActiveView
{
    return currentActiveView;
}

@end
