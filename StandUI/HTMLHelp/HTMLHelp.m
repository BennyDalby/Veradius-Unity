//
//  HTMLHelp.m
//  StandUI
//
//  Created by PhilipsIT5 on 12/16/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "HTMLHelp.h"

@implementation HTMLHelp
@synthesize webview;
@synthesize HelpMainView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)initHekpView
{
    self.backgroundColor=[[UIColor clearColor]colorWithAlphaComponent:0.0];
    UIColor *darkcolor =[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
    HelpMainView.backgroundColor=[darkcolor colorWithAlphaComponent:1.0];
    
    NSError *error = nil;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    NSString *html = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    
    [webview loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}

- (IBAction)helpCloseBtnTapped:(id)sender
{
    self.hidden=YES;
    [self.helpDlgDelegate HelpViewClosed];
}
@end
