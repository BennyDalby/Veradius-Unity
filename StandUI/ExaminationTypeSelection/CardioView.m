//
//  CardioView.m
//  StandUI
//
//  Created by PhilipsIT5 on 9/14/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "CardioView.h"
#import "ExaminationTypeConstants.h"

@implementation CardioView

@synthesize     CoronariesImageView;
@synthesize     VentriclesImageView;
@synthesize     PacemakerImageViev;
@synthesize     EPImageView;

@synthesize CoronariesLabel;
@synthesize VentriclesLabel;
@synthesize PacemakerLabel;
@synthesize EPLabel;

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
    [self ReduceAlphaofAllImages];
    CoronariesImageView.alpha = 1.0;
    [CoronariesLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
    anatomyTypeSelected = PROCEDURECORONARIES;
    anatomyProcedureSelected = CORONARIES;
}

-(void)ReduceAlphaofAllImages
{
    CoronariesImageView.alpha = 0.2;
    VentriclesImageView.alpha = 0.2;
    PacemakerImageViev.alpha = 0.2;
    EPImageView.alpha = 0.2;
}

-(void)ChangeTextColor
{
    [CoronariesLabel setTextColor:[UIColor whiteColor]];
    [VentriclesLabel setTextColor:[UIColor whiteColor]];
    [PacemakerLabel setTextColor:[UIColor whiteColor]];
    [EPLabel setTextColor:[UIColor whiteColor]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint nowPoint  = [[touches anyObject] locationInView: self];
    
    for(UIView *subview in [self subviews])
    {
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint))
        {
            if((subview == CoronariesImageView ) ||
               (subview == VentriclesImageView ) ||
               (subview == PacemakerImageViev ) ||
               (subview == EPImageView ) )
            {
                [self ReduceAlphaofAllImages];
                [self ChangeTextColor];
                subview.alpha = 1.0;
                if (subview == CoronariesImageView)
                {
                    [CoronariesLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDURECORONARIES;
                    anatomyProcedureSelected = CORONARIES;
                }
                else if (subview == VentriclesImageView )
                {
                    [VentriclesLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDUREVENTRICLES;
                    anatomyProcedureSelected = VENTRICLES;
                }
                else if (subview == PacemakerImageViev )
                {
                    [PacemakerLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDUREPACEMAKER;
                    anatomyProcedureSelected = PACEMAKER;
                }
                else
                {
                    [EPLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDUREELECTROPHYSIOLOGY;
                    anatomyProcedureSelected = ELECTROPHYSIOLOGY;
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
