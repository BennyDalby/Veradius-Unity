//
//  StandUISystem.h
//  StandUI
//
//  Created by PhilipsIT5 on 11/4/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandUISystem : UIView


@property(nonatomic) IBOutlet UIButton *testBuzzerButton;
@property(nonatomic) IBOutlet UIButton *autoRunCycleButton;
@property(nonatomic) IBOutlet UIButton *CloseButton;
@property (strong, nonatomic) IBOutlet UIView  *systemMainView;


-(void)initSystemView;
@end
