//
//  CommentTableCell.m
//  ExpandingTableViewProject
//
//  Created by Ryan Newsome on 4/13/11.
//

#import "CommentTableCell.h"


@implementation CommentTableCell
@synthesize popOverCtrl;
@synthesize commentTextLabel = commentTextLabel, toggleImage, viewForTopSection, viewForBottomSection,leftImage;
@synthesize subCommentTextLabel = subCommentTextLabel;
@synthesize ytdTextField;   //, btnViewDetails, btnSettings, ;

- (void)awakeFromNib 
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
    
    [super setSelected:selected animated:animated];
   
    
  //  self.layer.borderColor=[[UIColor blackColor]CGColor];
    //self.layer.borderWidth=1;
    
    
    // Configure the view for the selected state.
}

@end
