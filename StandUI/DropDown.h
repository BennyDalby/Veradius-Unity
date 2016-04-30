//
//  DropDown.h
//  StandUI
//
//  Created by CLPricingTeam on 8/7/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropDownDelegate <NSObject>

-(void)expandTable:(CGRect) frame ;

-(void)collapseTable:(CGRect)frame rowNumber:(int)row;

@end

@interface DropDown : UITableView<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *list ;
    UITableViewCell *cell;
}

@property(nonatomic, retain) id<DropDownDelegate> dropdowndelegate;
@property(nonatomic,retain)NSString* smode;
-(void)initialiseDataSource:(NSArray*)listItems with:(NSString *)selectedMode;
@end
