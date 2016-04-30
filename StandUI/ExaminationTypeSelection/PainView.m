//
//  PainView.m
//  StandUI
//
//  Created by PhilipsIT5 on 9/15/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "PainView.h"
#import "ExaminationTypeConstants.h"

@implementation PainView


@synthesize     nerveArmImageView;
@synthesize     nerveHeadImageView;
@synthesize     nerveLegsImageView;
@synthesize     nerveNeckImageView;
@synthesize     nervePelvisImageView;
@synthesize     nerveSpineImageView;
@synthesize     painOutlineImageView;

// Labels
@synthesize headLbl;
@synthesize neckLbl;
@synthesize spineLbl;
@synthesize leftArmLbl;
@synthesize rightArmLbl;
@synthesize pelvisLbl;
@synthesize leftLegLbl;
@synthesize rightLegLbl;

// Line View Outlets
@synthesize headLineview;
@synthesize neckLineview;
@synthesize spineLineview;
@synthesize leftArmlLineview;
@synthesize rightArmlLineview;
@synthesize pelvislLineview;
@synthesize leftLegLineview;
@synthesize rightLegLineview;


@synthesize  anatomyTypeSelected;
@synthesize  anatomyProcedureSelected;


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


-(void)initialisePainView
{
    [self hideAllImages];
    [self reduceAlpha];
    
    [self hideAllLineViews];
    [self hideAllLabels];
    [self setDefaults];
    painOutlineImageView.alpha = 0.6;
}

-(void)hideAllImages
{
    [nerveArmImageView setHidden:YES];
    [nerveHeadImageView setHidden:YES];
    [nerveLegsImageView setHidden:YES];
    [nerveNeckImageView setHidden:YES];
    [nervePelvisImageView setHidden:YES];
    [nerveSpineImageView setHidden:YES];
}

-(void)reduceAlpha
{
    nerveArmImageView.alpha     = 0.2;
    nerveHeadImageView.alpha    = 0.2;
    nerveLegsImageView.alpha     = 0.2;
    nerveNeckImageView.alpha    = 0.2;
    nervePelvisImageView.alpha     = 0.2;
    nerveSpineImageView.alpha      = 0.2;
}

-(void)hideAllLineViews
{
    [headLineview setHidden:YES];
    [neckLineview setHidden:YES];
    [spineLineview setHidden:YES];
    [leftArmlLineview setHidden:YES];
    [rightArmlLineview setHidden:YES];
    [pelvislLineview setHidden:YES];
    [leftLegLineview setHidden:YES];
    [rightLegLineview setHidden:YES];
}

-(void)hideAllLabels
{
    [headLbl setHidden:YES];
    [neckLbl setHidden:YES];
    [spineLbl setHidden:YES];
    [leftArmLbl setHidden:YES];
    [rightArmLbl setHidden:YES];
    [pelvisLbl setHidden:YES];
    [leftLegLbl setHidden:YES];
    [rightLegLbl setHidden:YES];
}

-(void)setDefaults
{
    
    [headLineview setHidden:NO];
    [headLbl setHidden:NO];
    [nerveHeadImageView setHidden:NO];
    nerveHeadImageView.alpha = 1.0;
    anatomyTypeSelected = PROCEDUREHEAD;
    anatomyProcedureSelected = HEAD;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint nowPoint  = [[touches anyObject] locationInView: self];
    
    for(UIView *subview in [self subviews])
    {
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint))
        {
            if((subview == nerveArmImageView ) ||
               (subview == nerveHeadImageView ) ||
               (subview == nerveLegsImageView ) ||
               (subview == nerveNeckImageView ) ||
               (subview == nervePelvisImageView ) ||
               (subview == nerveSpineImageView ))
            {
                [self hideAllImages];
                [self reduceAlpha];
                [self hideAllLineViews];
                [self hideAllLabels];
                [subview setHidden:NO];
                subview.alpha = 1.0;
                
                if( subview == nerveArmImageView )
                {
                    [leftArmlLineview setHidden:NO];
                    [rightArmlLineview setHidden:NO];
                    [leftArmLbl setHidden:NO];
                    [rightArmLbl setHidden:NO];
                    
                    anatomyTypeSelected = PROCEDUREARMS;
                    anatomyProcedureSelected = ARMS;
                }
                else if (subview == nerveHeadImageView)
                {
                    [headLbl setHidden:NO];
                    [headLineview setHidden:NO];
                    
                    anatomyTypeSelected = PROCEDUREHEAD;
                    anatomyProcedureSelected = HEAD;
                }
                else if (subview == nerveLegsImageView )
                {
                    [leftLegLineview setHidden:NO];
                    [rightLegLineview setHidden:NO];
                    [leftLegLbl setHidden:NO];
                    [rightLegLbl setHidden:NO];
                    
                    anatomyTypeSelected = PROCEDURELEGS;
                    anatomyProcedureSelected = LEGS;

                }
                else if( subview == nerveNeckImageView)
                {
                    [neckLbl setHidden:NO];
                    [neckLineview setHidden:NO];
                    anatomyTypeSelected = PROCEDURENECK;
                    anatomyProcedureSelected = NECK;
                   
                }
                else if (subview == nervePelvisImageView)
                {
                    [pelvisLbl setHidden:NO];
                    [pelvislLineview setHidden:NO];
                    anatomyTypeSelected = PROCEDURENERVEPELVIS;
                    anatomyProcedureSelected = NERVEPELVIS;
                }
                else{ // nerveSpineImageView
                    
                    [spineLbl setHidden:NO];
                    [spineLineview setHidden:NO];
                    anatomyTypeSelected = PROCEDURENERVESPINE;
                    anatomyProcedureSelected = NERVESPINE;
                }
            }
        }
    }
}

    

-(NSString*)anatomyTypeSelected
{
    return anatomyTypeSelected;
}

-(NSString*)anatomyPorcedureSelected
{
    return anatomyProcedureSelected;
}

@end
