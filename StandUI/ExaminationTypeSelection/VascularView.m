//
//  VascularView.m
//  StandUI
//
//  Created by ganapathy.ln on 13/08/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "VascularView.h"
#import "Constants.h"

@implementation VascularView

// Image views
@synthesize     mainBodyImageView;
@synthesize     cerebralImageView;
@synthesize     armsImageView;
@synthesize     abdominalImageview;
@synthesize     arotaImageVIew;
@synthesize     legsImageView;

// Labels
@synthesize     cerebralLbl;
@synthesize     aortaLbl;
@synthesize     leftArmLbl;
@synthesize     rightArmLbl;
@synthesize     abdominalLbl;
@synthesize     leftLegLbl;
@synthesize     rightLegLbl;

// Line views
@synthesize     cerebralLineview;
@synthesize     aortalLineview;
@synthesize     leftArmlLineview;
@synthesize     rightArmlLineview;
@synthesize     abdominallLineview;
@synthesize     leftLegLineview;
@synthesize     rightLegLineview;

@synthesize     okBtnVascular;
@synthesize     cancelBtnVascular;

@synthesize anatomyTypeSelected;
@synthesize anatomyProcedureSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
           }
    return self;
}


/*// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}
*/

-(void)InitialiseVascularView
{
     mainBodyImageView.alpha = 0.6;
    [self hideAllImages];
    [self reduceAlpha];
    [self hideAllLineViews];
    [self hideAllLabels];
    [self setDefaults];

}

-(void)setDefaults
{
    [cerebralLineview setHidden:NO];
    [cerebralLbl setHidden:NO];
    [cerebralImageView setHidden:NO];
    cerebralImageView.alpha = 1.0;
    anatomyTypeSelected = VASCULARPROCEDURECEREBRAL;
    anatomyProcedureSelected = ANATOMYCEREBRAL;
  //  okBtnVascular.enabled=NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint nowPoint  = [[touches anyObject] locationInView: self];
    
    for(UIView *subview in [self subviews])
    {
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint))
        {
            if((subview == legsImageView ) ||
                (subview == armsImageView ) ||
                 (subview == cerebralImageView ) ||
                 (subview == abdominalImageview ) ||
                 (subview == arotaImageVIew ))
            {
                [self hideAllImages];
                [self reduceAlpha];
                [self hideAllLineViews];
                [self hideAllLabels];
                [subview setHidden:NO];
                subview.alpha = 1.0;
                
                if(subview == legsImageView )
                {
                    [leftLegLineview setHidden:NO];
                    [rightLegLineview setHidden:NO];
                    [leftLegLbl setHidden:NO];
                    [rightLegLbl setHidden:NO];
                    anatomyTypeSelected = VASCULARPROCEDURELEGS;
                    anatomyProcedureSelected = ANATOMYVASCULARLEGS;
                  //  okBtnVascular.enabled=NO;
                    
                }
                else if (subview == armsImageView )
                {
                    [leftArmlLineview setHidden:NO];
                    [rightArmlLineview setHidden:NO];
                    [leftArmLbl setHidden:NO];
                    [rightArmLbl setHidden:NO];
                    anatomyTypeSelected = VASCULARPROCEDUREARMS;
                    anatomyProcedureSelected = ANATOMYVASCULARARMS;
                    //okBtnVascular.enabled=NO;
                }
                else if (subview == cerebralImageView )
                {
                    [cerebralLineview setHidden:NO];
                    [cerebralLbl setHidden:NO];
                    anatomyTypeSelected = VASCULARPROCEDURECEREBRAL;
                    anatomyProcedureSelected = ANATOMYCEREBRAL;
                   // okBtnVascular.enabled=NO;
                }
                else if (subview == abdominalImageview )
                {
                    [abdominallLineview setHidden:NO];
                    [abdominalLbl setHidden:NO];
                    anatomyTypeSelected = VASCULARPROCEDUREABDOMINAL;
                    anatomyProcedureSelected = ANATOMYABDOMINAL;
                   // okBtnVascular.enabled=YES;
                }
                else if (subview == arotaImageVIew )
                {
                    [aortalLineview setHidden:NO];
                    [aortaLbl setHidden:NO];
                    anatomyTypeSelected = VASCULARPROCEDUREAORTA;
                    anatomyProcedureSelected = ANATOMYAROTA;
                  //  okBtnVascular.enabled=NO;
                }
            }
            
        }
    }
}

-(void)reduceAlpha
{
    mainBodyImageView.alpha     = 0.6;
    armsImageView.alpha         = 0.2;
    cerebralImageView.alpha     = 0.2;
    abdominalImageview.alpha    = 0.2;
    arotaImageVIew.alpha        = 0.2;
    legsImageView.alpha         = 0.2;
}

-(void)hideAllImages
{
    [armsImageView setHidden:YES];
    [cerebralImageView setHidden:YES];
    [abdominalImageview setHidden:YES];
    [arotaImageVIew setHidden:YES];
    [legsImageView setHidden:YES];
}


-(void)hideAllLineViews
{
    [cerebralLineview setHidden:YES];
    [aortalLineview setHidden:YES];
    [leftArmlLineview setHidden:YES];
    [rightArmlLineview setHidden:YES];
    [abdominallLineview setHidden:YES];
    [leftLegLineview setHidden:YES];
    [rightLegLineview setHidden:YES];
}

-(void)hideAllLabels
{
    [cerebralLbl setHidden:YES];
    [aortaLbl setHidden:YES];
    [leftArmLbl setHidden:YES];
    [rightArmLbl setHidden:YES];
    [abdominalLbl setHidden:YES];
    [leftLegLbl setHidden:YES];
    [rightLegLbl setHidden:YES];
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
