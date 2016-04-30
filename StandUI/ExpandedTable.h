//
//  ExpandedTable.h
//  CustomTable
//
//  Created by b.dalby.thoomkuzhy on 9/30/13.
//  Copyright (c) 2013 b.dalby.thoomkuzhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CommentTableCell.h"

@protocol BOExpandableTableViewDelegate <NSObject>

@required
- (NSInteger)   customizeNumberOfRowsInSection:(NSInteger)section;

@optional

- (void)    customizeCell: (CommentTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)    customizeCollapsedCell: (CommentTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat) customizeHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)    customizeDidSelectCollapsedRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)    customizeDidSelectExpandedRowAtIndexPath:(NSIndexPath *)indexPath ;
- (void)    customizeDidSelectExpandedRowAtIndexPath:(CommentTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath ;
//- (void)        extractCellTitles;

@end




@interface ExpandedTable : UITableView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSInteger                           selectedIndex;
    id<BOExpandableTableViewDelegate>   delegate;
    UIButton   *btn1 ;
    UITableView  *tabview ;


}

@property(nonatomic, retain) NSMutableArray        *tableCellViewLabels;
@property(nonatomic,retain) UIView *view ;

@property(nonatomic, retain) id<BOExpandableTableViewDelegate> exDelegate;



- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
-(void) inittableSelect ;

@end
