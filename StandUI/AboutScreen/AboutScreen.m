//
//  AboutScreen.m
//  StandUI
//
//  Created by PhilipsIT5 on 12/29/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "AboutScreen.h"


@interface AboutScreen ()

@end

@implementation AboutScreen
@synthesize copyrightLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    copyrightLbl.text = [NSString stringWithFormat:@"Copyright \u00A9 2014 Philips"];
    CGSize size = CGSizeMake(400, 500); // size of view in popover
    self.preferredContentSize = size;
    [super viewWillAppear:animated];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (IBAction)TandC_ButtonTapped:(id)sender {
    
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.philips.co.uk/terms"]];
    
}

- (IBAction)PrivacyPolicy_ButtonTapped:(id)sender {
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.philips.co.uk/privacypolicy"]];
}

@end
