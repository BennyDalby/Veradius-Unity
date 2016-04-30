//
//  PainView.h
//  StandUI
//
//  Created by PhilipsIT5 on 9/15/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PainView : UIView

@property(nonatomic) IBOutlet UIImageView *painOutlineImageView;
@property(nonatomic) IBOutlet UIImageView *nerveArmImageView;
@property(nonatomic) IBOutlet UIImageView *nerveHeadImageView;
@property(nonatomic) IBOutlet UIImageView *nerveLegsImageView;
@property(nonatomic) IBOutlet UIImageView *nerveNeckImageView;
@property(nonatomic) IBOutlet UIImageView *nervePelvisImageView;
@property(nonatomic) IBOutlet UIImageView *nerveSpineImageView;


// label Outlets
@property(strong,nonatomic) IBOutlet UILabel *headLbl;
@property(strong,nonatomic) IBOutlet UILabel *neckLbl;
@property(strong,nonatomic) IBOutlet UILabel *spineLbl;
@property(strong,nonatomic) IBOutlet UILabel *leftArmLbl;
@property(strong,nonatomic) IBOutlet UILabel *rightArmLbl;
@property(strong,nonatomic) IBOutlet UILabel *pelvisLbl;
@property(strong,nonatomic) IBOutlet UILabel *leftLegLbl;
@property(strong,nonatomic) IBOutlet UILabel *rightLegLbl;

// Line View Outlets
@property(nonatomic) IBOutlet UIView *headLineview;
@property(nonatomic) IBOutlet UIView *neckLineview;
@property(nonatomic) IBOutlet UIView *spineLineview;
@property(nonatomic) IBOutlet UIView *leftArmlLineview;
@property(nonatomic) IBOutlet UIView *rightArmlLineview;
@property(nonatomic) IBOutlet UIView *pelvislLineview;
@property(nonatomic) IBOutlet UIView *leftLegLineview;
@property(nonatomic) IBOutlet UIView *rightLegLineview;

@property (nonatomic,retain)NSString* anatomyTypeSelected;
@property (nonatomic,retain)NSString* anatomyProcedureSelected;

-(void)initialisePainView;
-(NSString*)anatomyTypeSelected;
-(NSString*)anatomyPorcedureSelected;

@end
