//
//  SkeletonView.m
//  StandUI
//
//  Created by ganapathy.ln on 13/08/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "SkeletonView.h"
#import "Constants.h"

@implementation SkeletonView

// Syntehsize all images
@synthesize  mainSkeletonImageView;
@synthesize  skeletonSkullImageView;
@synthesize  skeletonThoraxImageView;
@synthesize  skeletonSpineImageView;
@synthesize  skeletonPelvisImageView;
@synthesize  skeletonArmsImageView;
@synthesize  skeletonLegsImageView;

// Synthesize all line views
@synthesize  skullLineview;
@synthesize thoraxLineview;
@synthesize leftArmlLineview;
@synthesize rightArmlLineview;
@synthesize pelvisLineview;
@synthesize leftLegLineview;
@synthesize rightLegLineview;
@synthesize spineLineview;

// Synthesize all labels
@synthesize skullLbl;
@synthesize thoraxLbl;
@synthesize leftArmLbl;
@synthesize rightArmLbl;
@synthesize pelvisLbl;
@synthesize leftLegLbl;
@synthesize rightLegLbl;
@synthesize spineLbl;

@synthesize okBtnSkeleton;
@synthesize cancelBtnSkeleton;


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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}
*/

-(void)InitialiseSkeletonView
{
    mainSkeletonImageView.alpha = .40;
    [self hideAllImages];
    [self reduceAlpha];
    [self hideAllLineViews];
    [self hideAllLabels];
    [self setDefaults];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint nowPoint  = [[touches anyObject] locationInView: self];
    
    for(UIView *subview in [self subviews])
    {
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint))
        {
            if((subview == skeletonSkullImageView ) ||
               (subview == skeletonThoraxImageView ) ||
               (subview == skeletonSpineImageView ) ||
               (subview == skeletonPelvisImageView ) ||
               (subview == skeletonArmsImageView ) ||
               (subview == skeletonLegsImageView )
               )
            {
                [self hideAllImages];
                [self reduceAlpha];
                [self hideAllLineViews];
                [self hideAllLabels];
                [subview setHidden:NO];
                subview.alpha = 1.0;
                
                if(subview == skeletonLegsImageView )
                {
                    [leftLegLineview setHidden:NO];
                    [rightLegLineview setHidden:NO];
        
                    [leftLegLbl setHidden:NO];
                    [rightLegLbl setHidden:NO];
                    anatomyTypeSelected = SKELETONPROCEDURELEGS;
                    anatomyProcedureSelected = ANATOMYSKELETONLEGS;
                  //  okBtnSkeleton.enabled=YES;
                    
                }
                else if (subview == skeletonArmsImageView )
                {
                    [leftArmlLineview setHidden:NO];
                    [rightArmlLineview setHidden:NO];
                    [leftArmLbl setHidden:NO];
                    [rightArmLbl setHidden:NO];
                    anatomyTypeSelected = SKELETONPROCEDUREARMS;
                    anatomyProcedureSelected = ANATOMYSKELETONARMS;
                   // okBtnSkeleton.enabled=NO;
                }
                
                else if (subview == skeletonSkullImageView )
                {
                    [skullLineview setHidden:NO];
                    [skullLbl setHidden:NO];
                    anatomyTypeSelected = SKELETONPROCEDURESKULL;
                    anatomyProcedureSelected = ANATOMYSKULL;
                   // okBtnSkeleton.enabled=NO;
                }
                else if (subview == skeletonPelvisImageView )
                {
                    [pelvisLbl setHidden:NO];
                    [pelvisLineview setHidden:NO];
                    anatomyTypeSelected = SKELETONPROCEDUREPELVIS;
                    anatomyProcedureSelected = ANATOMYPELVIS;
                   // okBtnSkeleton.enabled=NO;
                }
                else if (subview == skeletonSpineImageView )
                {
                    [spineLineview setHidden:NO];
                    [spineLbl setHidden:NO];
                    anatomyTypeSelected = SKELETONPROCEDURESPINE;
                    anatomyProcedureSelected = ANATOMYSPINE;
                  //  okBtnSkeleton.enabled=NO;
                }
                
                 else if (subview == skeletonThoraxImageView )
                 {
                     [thoraxLineview setHidden:NO];
                     [thoraxLbl setHidden:NO];
                     anatomyTypeSelected = SKELETONPROCEDURETHORAX;
                     anatomyProcedureSelected = ANATOMYTHORAX;
                   //  okBtnSkeleton.enabled=NO;
                 }
            }
        }
    }
}

-(void)hideAllImages
{
    [skeletonSkullImageView setHidden:YES];
    [skeletonThoraxImageView setHidden:YES];
    [skeletonSpineImageView setHidden:YES];
    [skeletonPelvisImageView setHidden:YES];
    [skeletonArmsImageView setHidden:YES];
    [skeletonLegsImageView setHidden:YES];
}

-(void)hideAllLabels
{
    [skullLbl setHidden:YES];
    [thoraxLbl setHidden:YES];
    [leftArmLbl setHidden:YES];
    [rightArmLbl setHidden:YES];
    [pelvisLbl setHidden:YES];
    [leftLegLbl setHidden:YES];
    [rightLegLbl setHidden:YES];
    [spineLbl setHidden:YES];
}

-(void)hideAllLineViews
{
    [skullLineview setHidden:YES];
    [thoraxLineview setHidden:YES];
    [leftArmlLineview setHidden:YES];
    [rightArmlLineview setHidden:YES];
    [pelvisLineview setHidden:YES];
    [leftLegLineview setHidden:YES];
    [rightLegLineview setHidden:YES];
    [spineLineview setHidden:YES];
}

-(void)reduceAlpha
{
    mainSkeletonImageView.alpha      = .5;
    skeletonSkullImageView.alpha     = 0.2;
    skeletonThoraxImageView.alpha    = 0.2;
    skeletonSpineImageView.alpha     = 0.2;
    skeletonPelvisImageView.alpha    = 0.2;
    skeletonArmsImageView.alpha      = 0.2;
    skeletonLegsImageView.alpha      = 0.2;
}

-(void)setDefaults
{
  /*  [skullLineview setHidden:NO];
    [skullLbl setHidden:NO];
    [skeletonSkullImageView setHidden:NO];
    skeletonSkullImageView.alpha = 1.0;
    anatomyTypeSelected = SKULL;
    anatomyProcedureSelected = ANATOMYSKULL;
    okBtnSkeleton.enabled=NO;
    */
    
    
    
    [leftLegLineview setHidden:NO];
    [rightLegLineview setHidden:NO];
    [leftLegLbl setHidden:NO];
    [rightLegLbl setHidden:NO];
    [skeletonLegsImageView setHidden:NO];
    skeletonLegsImageView.alpha = 1.0;
    anatomyTypeSelected = SKELETONPROCEDURELEGS;//SKELETONLEGS;
    anatomyProcedureSelected = ANATOMYSKELETONLEGS;
   // okBtnSkeleton.enabled=YES;
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
