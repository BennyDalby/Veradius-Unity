//
//  imageReview.h
//  StandUI
//
//  Created by PhilipsIT5 on 10/15/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

// Image review size
#define SISD        03
#define SIDD        04
#define FULLSIZE    01
#define OVERVIEW    02
#define TOOLBARBUTTONWIDTH 75

#define PREVIOUSBUTTON  00
#define RUNBUTTON       01
#define OVERVIEWBUTTON  02
#define NEXTBUTTON      03


@interface imageReview : UIView


@property(nonatomic) IBOutlet UIImageView *previousBtnImage;
@property(nonatomic) IBOutlet UIImageView *nextBtnImage;
@property(nonatomic) IBOutlet UIImageView *Pause_RunCycleBtnImage;
@property(nonatomic) IBOutlet UIImageView *Single_OverviewBtnImage;

@property(nonatomic) IBOutlet UIButton *previousButton;
@property(nonatomic) IBOutlet UIButton *nextButton;
@property(nonatomic) IBOutlet UIButton *runCycleButton;
@property(nonatomic) IBOutlet UIButton *overviewButton;

@property(nonatomic) IBOutlet UIView *pageNavigationtoolbar;
@property(nonatomic) IBOutlet UIButton *pageUpButton;
@property(nonatomic) IBOutlet UIButton *pageDownButton;

@property(nonatomic) IBOutlet UIView *prevButtonView;
@property(nonatomic) IBOutlet UIView *RunButtonView;
@property(nonatomic) IBOutlet UIView *overviewButtonView;
@property(nonatomic) IBOutlet UIView *nextButtonView;

@property(nonatomic) BOOL singleimagepressed;
@property(nonatomic) BOOL allimagepressed;
@property(nonatomic) BOOL overviewButtonClicked ;


@property (nonatomic, assign) NSInteger  CurrentImageReviewSize;
@property (nonatomic, assign) NSInteger  CurrentImageReviewMode;

@property (nonatomic, assign) int currentRun;
@property (nonatomic, assign) int currentImageNo;
@property (nonatomic, assign) NSString *currentImageName;

@property(nonatomic) IBOutlet UILabel *RunLabel;
@property(nonatomic) IBOutlet UILabel *imageNolabel;
@property (nonatomic,assign) BOOL imageReviewMode;
// Business Logic
@property(nonatomic,strong) NSMutableArray *StoredImagesDict;

//@property(nonatomic)StandUI *standUIView;

- (IBAction)NextImageBtnClicked:(id)sender;
- (IBAction)PreviousImageBtnClicked:(id)sender;
- (IBAction)Pause_RunCycleBtnClicked:(id)sender;
- (IBAction)Single_OverviewBtnClicked:(id)sender;
- (IBAction)PageUpBtnClicked:(id)sender;
- (IBAction)PageDownBtnClicked:(id)sender;


-(void)UpdateToolBarIcons:(NSInteger)val;
-(void)ShareInstance:(void*)standuiView;
-(void)InitialiseView;
-(void)ReInitialise;
-(void)InitialiseStoredImageDict;
-(void)Hide_UnhideAllNavigationToolBarViews:(BOOL)val;
@end
