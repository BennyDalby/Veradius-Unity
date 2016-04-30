//
//  Endoscopy.m
//  StandUI
//
//  Created by PhilipsIT5 on 9/14/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "Endoscopy.h"
#import "ExaminationTypeConstants.h"

@implementation Endoscopy

@synthesize     OesophagusImageView;
@synthesize     ERCPImageView;
@synthesize     BronchusImageViev;

@synthesize     OesophagusLabel;
@synthesize     ERCPLabel;
@synthesize     BronchusLabel;


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

-(void)ReduceAlphaofAllImages
{
    OesophagusImageView.alpha = 0.2;
    ERCPImageView.alpha = 0.2;
    BronchusImageViev.alpha = 0.2;
}

-(void)InitialiseView
{
    [self ReduceAlphaofAllImages];
    ERCPImageView.alpha = 1.0;
    [ERCPLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
    anatomyTypeSelected = PROCEDUREERCP;
    anatomyProcedureSelected = ERCP;
}

-(void)ChangeTextColor
{
    [OesophagusLabel setTextColor:[UIColor whiteColor]];
    [ERCPLabel setTextColor:[UIColor whiteColor]];
    [BronchusLabel setTextColor:[UIColor whiteColor]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint nowPoint  = [[touches anyObject] locationInView: self];
    
    for(UIView *subview in [self subviews])
    {
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint))
        {
            if((subview == OesophagusImageView ) ||
               (subview == ERCPImageView ) ||
               (subview == BronchusImageViev ))
            {
                [self ReduceAlphaofAllImages];
                [self ChangeTextColor];
                subview.alpha = 1.0;
                if (subview == OesophagusImageView)
                {
                    [OesophagusLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDUREOESOPHAGUS;
                    anatomyProcedureSelected = OESOPHAGUS;
                }
                else if (subview == ERCPImageView )
                {
                    [ERCPLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDUREERCP;
                    anatomyProcedureSelected = ERCP;
                }
                else
                {
                    [BronchusLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDUREBRONCHUS;
                    anatomyProcedureSelected = BRONCHUS;
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
