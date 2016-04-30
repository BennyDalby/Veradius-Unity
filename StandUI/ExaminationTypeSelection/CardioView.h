//
//  CardioView.h
//  StandUI
//
//  Created by PhilipsIT5 on 9/14/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardioView : UIView


@property(nonatomic) IBOutlet UIImageView *CoronariesImageView;
@property(nonatomic) IBOutlet UIImageView *VentriclesImageView;
@property(nonatomic) IBOutlet UIImageView *PacemakerImageViev;
@property(nonatomic) IBOutlet UIImageView *EPImageView;

@property(strong, nonatomic) IBOutlet UILabel *CoronariesLabel;
@property(strong, nonatomic) IBOutlet UILabel *VentriclesLabel;
@property(strong, nonatomic) IBOutlet UILabel *PacemakerLabel;
@property(strong, nonatomic) IBOutlet UILabel *EPLabel;


@property (nonatomic,retain)NSString* anatomyTypeSelected;
@property (nonatomic,retain)NSString* anatomyProcedureSelected;

-(void)ReduceAlphaofAllImages;
-(void)InitialiseView;

-(NSString*)anatomyTypeSelected;
-(NSString*)anatomyPorcedureSelected;

@end
