//
//  StandUICARMPosition.h
//  StandUI
//
//  Created by PhilipsIT5 on 12/15/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StandUICARMPosition : NSObject
{
// Position Memory CARM Position
    
    NSString *RotationPos;
    NSString *AngulationPos;
    NSString *LongitudinalPos;
    NSString *HeightPos;
}
@property (nonatomic, copy) NSString *RotationPos;
@property (nonatomic, copy) NSString *AngulationPos;
@property (nonatomic, copy) NSString *LongitudinalPos;
@property (nonatomic, copy) NSString *HeightPos;

+(id)shareCARMManager;

//-(void)updateRotationValue;
//-(void)updateAngulationValue;
//-(void)updateLongitudinalValue;
//-(void)updateHeightValue;



@end
