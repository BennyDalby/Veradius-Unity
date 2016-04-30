//
//  VascularView.h
//  StandUI
//
//  Created by ganapathy.ln on 13/08/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VascularView : UIView

// Image IBOutlets
@property(nonatomic) IBOutlet UIImageView *mainBodyImageView ;
@property (strong, nonatomic) IBOutlet UIImageView *cerebralImageView;
@property (strong, nonatomic) IBOutlet UIImageView *armsImageView;
@property (strong, nonatomic) IBOutlet UIImageView *abdominalImageview;
@property (strong, nonatomic) IBOutlet UIImageView *arotaImageVIew;
@property (strong, nonatomic) IBOutlet UIImageView *legsImageView;

// label Outlets

@property(strong,nonatomic) IBOutlet UILabel *cerebralLbl;
@property(strong,nonatomic) IBOutlet UILabel *aortaLbl;
@property(strong,nonatomic) IBOutlet UILabel *leftArmLbl;
@property(strong,nonatomic) IBOutlet UILabel *rightArmLbl;
@property(strong,nonatomic) IBOutlet UILabel *abdominalLbl;
@property(strong,nonatomic) IBOutlet UILabel *leftLegLbl;
@property(strong,nonatomic) IBOutlet UILabel *rightLegLbl;

// Line View Outlets
@property(nonatomic) IBOutlet UIView *cerebralLineview ;
@property(nonatomic) IBOutlet UIView *aortalLineview ;
@property(nonatomic) IBOutlet UIView *leftArmlLineview ;
@property(nonatomic) IBOutlet UIView *rightArmlLineview ;
@property(nonatomic) IBOutlet UIView *abdominallLineview ;
@property(nonatomic) IBOutlet UIView *leftLegLineview ;
@property(nonatomic) IBOutlet UIView *rightLegLineview ;

@property (nonatomic,retain)NSString* anatomyTypeSelected;
@property (nonatomic,retain)NSString* anatomyProcedureSelected;


@property(nonatomic) IBOutlet UIButton *okBtnVascular;
@property(nonatomic) IBOutlet UIButton *cancelBtnVascular;

-(NSString*)anatomyTypeSelected;
-(NSString*)anatomyPorcedureSelected;
-(void)InitialiseVascularView;

@end
