//
//  StandUICARMPosition.m
//  StandUI
//
//  Created by PhilipsIT5 on 12/15/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "StandUICARMPosition.h"

@implementation StandUICARMPosition


@synthesize  RotationPos;
@synthesize AngulationPos;
@synthesize LongitudinalPos;
@synthesize HeightPos;

+(id)shareCARMManager
{
    static StandUICARMPosition *sharedCARmPos = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCARmPos = [[self alloc] init];
    });
    return sharedCARmPos;
}

- (id)init {
    if (self = [super init]) {
        
       NSString *degSymbol = @"\u00B0";
     
        RotationPos =[[NSString alloc] initWithFormat: @"%d%@", 0,degSymbol];
        AngulationPos =  [[NSString alloc] initWithFormat: @"%d%@", 0,degSymbol];
        LongitudinalPos= [[NSString alloc] initWithFormat: @"%.01f", 10.0];
        HeightPos= [[NSString alloc] initWithFormat: @"%.01f", 10.0];
    }
    return self;
}
@end
