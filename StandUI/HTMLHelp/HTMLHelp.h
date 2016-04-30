//
//  HTMLHelp.h
//  StandUI
//
//  Created by PhilipsIT5 on 12/16/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HelpDialogdelegate <NSObject>

@required
-(void)HelpViewClosed;
@optional
@end

@interface HTMLHelp : UIView

@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UIView  *HelpMainView;
@property(nonatomic, retain) id<HelpDialogdelegate> helpDlgDelegate;
-(void)initHekpView;
@end
