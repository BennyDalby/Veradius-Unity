//
//  SkeletonView.h
//  StandUI
//
//  Created by ganapathy.ln on 13/08/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkeletonView : UIView


@property(nonatomic) IBOutlet UIImageView *mainSkeletonImageView;
@property(nonatomic) IBOutlet UIImageView *skeletonSkullImageView;
@property(nonatomic) IBOutlet UIImageView *skeletonThoraxImageView;
@property(nonatomic) IBOutlet UIImageView *skeletonSpineImageView;
@property(nonatomic) IBOutlet UIImageView *skeletonPelvisImageView;
@property(nonatomic) IBOutlet UIImageView *skeletonArmsImageView;
@property(nonatomic) IBOutlet UIImageView *skeletonLegsImageView;

// label Outlets
@property(strong,nonatomic) IBOutlet UILabel *skullLbl;
@property(strong,nonatomic) IBOutlet UILabel *thoraxLbl;
@property(strong,nonatomic) IBOutlet UILabel *pelvisLbl;
@property(strong,nonatomic) IBOutlet UILabel *spineLbl;
@property(strong,nonatomic) IBOutlet UILabel *leftArmLbl;
@property(strong,nonatomic) IBOutlet UILabel *rightArmLbl;
@property(strong,nonatomic) IBOutlet UILabel *leftLegLbl;
@property(strong,nonatomic) IBOutlet UILabel *rightLegLbl;


// Line View Outlets
@property(nonatomic) IBOutlet UIView *skullLineview;
@property(nonatomic) IBOutlet UIView *thoraxLineview;
@property(nonatomic) IBOutlet UIView *pelvisLineview;
@property(nonatomic) IBOutlet UIView *spineLineview;
@property(nonatomic) IBOutlet UIView *leftArmlLineview;
@property(nonatomic) IBOutlet UIView *rightArmlLineview;
@property(nonatomic) IBOutlet UIView *leftLegLineview;
@property(nonatomic) IBOutlet UIView *rightLegLineview;

@property (nonatomic,retain)NSString* anatomyTypeSelected;
@property (nonatomic,retain)NSString* anatomyProcedureSelected;

@property(nonatomic) IBOutlet UIButton *okBtnSkeleton;
@property(nonatomic) IBOutlet UIButton *cancelBtnSkeleton;

-(NSString*)anatomyTypeSelected;
-(NSString*)anatomyPorcedureSelected;
-(void)InitialiseSkeletonView;

@end
