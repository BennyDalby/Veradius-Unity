//
//  ScrollPanelView.h
//  StandUI
//
//  Created by CLPricingTeam on 10/15/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol scrollviewprotocol <NSObject>

-(void)updateRUN ;
-(void)UpdateRightSidebar ;

@end

@interface ScrollPanelView : UIView
{
    int tag ;
   
}

@property(nonatomic) UIScrollView *scrollview ;
@property(nonatomic) int runvalue ;
@property(nonatomic) int imageNovalue ;
@property(nonatomic) int tagvalue ;
@property(nonatomic) BOOL clicked ;
@property(nonatomic)  id<scrollviewprotocol> scrolldelegate ;


-(void)Addoverview1 ;
-(void)Addoverview2 ;
-(void)Addoverview3 ;

-(void)nextbuttonOvetview1;

-(void)prevbuttonOverview1 ;

-(void)prevbuttonOverview2 ;

-(void)prevbuttonOverview3 ;

-(void)nextbuttonOvetview3 ;

-(void)nextbuttonOvetview2 ;

@end
