//
//  ExaminationTypeSelView.h
//  StandUI
//
//  Created by ganapathy.ln on 12/08/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VascularView.h"
#import "SkeletonView.h"
#import "UrologyView.h"
#import "Endoscopy.h"
#import "CardioView.h"
#import "PainView.h"

//@protocol Examinationdelegate <NSObject>
//
//-(void)hideView;
//
//@end

@protocol ExaminationTypeSeldelegate <NSObject>

@required
-(void)ExaminationTypeSelComplete:(NSString*)procedureType :(NSString*)detailedProcedureType :(NSString*)anatomyType;
@optional
@end

@interface ExaminationTypeSelView : UIView

// IBOutlets of all the buttons
@property(nonatomic) IBOutlet VascularView *vascularview ;
@property(nonatomic) IBOutlet SkeletonView *skeletonView ;
@property(nonatomic) IBOutlet UrologyView *urologyView ;
@property(nonatomic) IBOutlet Endoscopy *endoscopyView ;
@property(nonatomic) IBOutlet CardioView *cardioView ;
@property(nonatomic) IBOutlet PainView *painView ;

@property(nonatomic) IBOutlet UIButton *skeletonButton;
@property(nonatomic) IBOutlet UIButton *urologyButton;
@property(nonatomic) IBOutlet UIButton *endoscopyButton;
@property(nonatomic) IBOutlet UIButton *vascularButton;
@property(nonatomic) IBOutlet UIButton *cardioButton;
@property(nonatomic) IBOutlet UIButton *painButton;
@property(nonatomic) IBOutlet UIButton *okButton;
@property(nonatomic) IBOutlet UILabel *step2ContentLabel;

@property(nonatomic) IBOutlet UIButton *cancelButton;

@property(nonatomic, retain) id<ExaminationTypeSeldelegate> examinationTypeSelectiondelegate;

//IBAction of all the buttons
- (void)initExamTypeSelectionView;
- (IBAction)skeletonButtonCLicked:(id)sender;
- (IBAction)urologyButtonCLicked:(id)sender;
- (IBAction)endoscopyButtonCLicked:(id)sender;
- (IBAction)vascularButtonCLicked:(id)sender;
- (IBAction)painButtonCLicked:(id)sender;
- (IBAction)cardioButtonCLicked:(id)sender;

- (IBAction)OKButtonCLicked:(id)sender;
- (IBAction)CancelButtonCLicked:(id)sender;

-(int)getCurrentActiveView;
@end
