//
//  Endoscopy.h
//  StandUI
//
//  Created by PhilipsIT5 on 9/14/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Endoscopy : UIView

@property(nonatomic) IBOutlet UIImageView *OesophagusImageView;
@property(nonatomic) IBOutlet UIImageView *ERCPImageView;
@property(nonatomic) IBOutlet UIImageView *BronchusImageViev;


@property(strong, nonatomic) IBOutlet UILabel *OesophagusLabel;
@property(strong, nonatomic) IBOutlet UILabel *ERCPLabel;
@property(strong, nonatomic) IBOutlet UILabel *BronchusLabel;

@property (nonatomic,retain)NSString* anatomyTypeSelected;
@property (nonatomic,retain)NSString* anatomyProcedureSelected;

-(void)ReduceAlphaofAllImages;
-(void)InitialiseView;

-(NSString*)anatomyTypeSelected;
-(NSString*)anatomyPorcedureSelected;

@end
