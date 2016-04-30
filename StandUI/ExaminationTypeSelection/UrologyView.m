//
//  UrologyView.m
//  StandUI
//
//  Created by PhilipsIT5 on 9/14/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "UrologyView.h"
#import "ExaminationTypeConstants.h"

@implementation UrologyView

// Image Views
@synthesize KidneyimageView;
@synthesize LithotripsyimageView;
@synthesize BladderImageViev;
@synthesize UrethrographyimageView;

// Label
@synthesize kidneyLabel;
@synthesize LithotripsyLabel;
@synthesize BladderLabel;
@synthesize UrethrographyLabel;

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
    KidneyimageView.alpha = 1.0;
    [kidneyLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
    anatomyTypeSelected = PROCEDUREKIDNEY;
    anatomyProcedureSelected = KIDNEY;
}

-(void)ReduceAlphaofAllImages
{
    KidneyimageView.alpha = 0.2;
    LithotripsyimageView.alpha = 0.2;
    BladderImageViev.alpha = 0.2;
    UrethrographyimageView.alpha = 0.2;
}

-(void)ChangeTextColor
{
    [kidneyLabel setTextColor:[UIColor whiteColor]];
    [LithotripsyLabel setTextColor:[UIColor whiteColor]];
    [BladderLabel setTextColor:[UIColor whiteColor]];
    [UrethrographyLabel setTextColor:[UIColor whiteColor]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint nowPoint  = [[touches anyObject] locationInView: self];
    
    for(UIView *subview in [self subviews])
    {
        if([subview isKindOfClass:[UIImageView class]] && CGRectContainsPoint(subview.frame, nowPoint))
        {
            if((subview == KidneyimageView ) ||
               (subview == LithotripsyimageView ) ||
               (subview == BladderImageViev ) ||
               (subview == UrethrographyimageView ) )
            {
                [self ReduceAlphaofAllImages];
                [self ChangeTextColor];
                subview.alpha = 1.0;
                if (subview == KidneyimageView)
                {
                   [kidneyLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDUREKIDNEY;
                    anatomyProcedureSelected = KIDNEY;
                }
                else if (subview == LithotripsyimageView )
                {
                    [LithotripsyLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDURELITHOTRIPSY;
                    anatomyProcedureSelected = LITHOTRIPSY;
                }
                else if (subview == BladderImageViev )
                {
                    [BladderLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDUREBLADDER;
                    anatomyProcedureSelected = BLADDER;
                }
                else
                {
                    [UrethrographyLabel setTextColor:[UIColor colorWithRed:252.0/256.0 green:209.0/256.0 blue:97.0/256.0 alpha:1.0]];
                    anatomyTypeSelected = PROCEDUREURETHROGRAPHY;
                    anatomyProcedureSelected = URETHROGRAPHY;
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
