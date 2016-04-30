//
//  UrologyView.h
//  StandUI
//
//  Created by PhilipsIT5 on 9/14/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UrologyView : UIView


@property(nonatomic) IBOutlet UIImageView *KidneyimageView;
@property(nonatomic) IBOutlet UIImageView *LithotripsyimageView;
@property(nonatomic) IBOutlet UIImageView *BladderImageViev;
@property(nonatomic) IBOutlet UIImageView *UrethrographyimageView;

@property(strong, nonatomic) IBOutlet UILabel *kidneyLabel;
@property(strong, nonatomic) IBOutlet UILabel *LithotripsyLabel;
@property(strong, nonatomic) IBOutlet UILabel *BladderLabel;
@property(strong, nonatomic) IBOutlet UILabel *UrethrographyLabel;


@property (nonatomic,retain)NSString* anatomyTypeSelected;
@property (nonatomic,retain)NSString* anatomyProcedureSelected;

-(void)ReduceAlphaofAllImages;
-(void)InitialiseView;

-(NSString*)anatomyTypeSelected;
-(NSString*)anatomyPorcedureSelected;

@end
