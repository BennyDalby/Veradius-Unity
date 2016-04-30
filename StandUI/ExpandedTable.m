//
//  ExpandedTable.m
//  CustomTable
//
//  Created by b.dalby.thoomkuzhy on 9/30/13.
//  Copyright (c) 2013 b.dalby.thoomkuzhy. All rights reserved.
//

#import "ExpandedTable.h"

@implementation ExpandedTable

@synthesize exDelegate, tableCellViewLabels,view;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        // Initialization code
        //Praseeda  selectedIndex = -1;
       
        //[self load_btton];
//        tableCellViewLabels=[[NSMutableArray alloc]init];
//        NSLog(@"\n\ninit with frame si called here\n\n");
//        
//        self.layer.borderWidth=1.0 ;
//        self.layer.borderColor=[[UIColor greenColor]CGColor];
        
        
    }
    return self;
}

-(void)inittableSelect
{
    selectedIndex = -1; 
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (tableView == dashboardTable) {
    //        return 6;
    //    }
    NSLog(@"No fo rows in section is %d",[exDelegate customizeNumberOfRowsInSection:section]);
    return [exDelegate customizeNumberOfRowsInSection:section];
}

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
}

// Automatically called
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"The title at %d is %@",indexPath.row,[self.tableCellViewLabels objectAtIndex:indexPath.row]);
  //  tableView.layer.borderWidth=1.0 ;
    
  //  tableView.layer.borderColor=[[UIColor clearColor]CGColor];
    NSLog(@"selected index %d",selectedIndex);
   // tableView.frame=CGRectMake(0, 0, 218, 600);
 //   [tableView setSeparatorColor:[UIColor clearColor]];  // To hide the seperator
    
    static NSString *CellIdentifier = @"CommentTableCell";
    
    CommentTableCell *cell = (CommentTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CommentTableCell" owner:self options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (CommentTableCell *)currentObject;
                break;
            }
        }
    }

    cell.layer.cornerRadius = 3;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   // CGFloat questionLabelHeight = 20.0;
    
    //If this is the selected index then calculate the height of the cell based on the amount of text we have
   
    
    if(selectedIndex == indexPath.row)
    {
        if(indexPath.row == 0)
        {
            cell.commentTextLabel.frame = CGRectMake(7,
                                                     cell.commentTextLabel.frame.origin.y+5,
                                                     cell.commentTextLabel.frame.size.width,
                                                     40);
            
        }
        
        if (indexPath.row!=0) {
            cell.toggleImage.image = [UIImage imageNamed:@"uparrow-act.png"];
        }
        
        
        if(indexPath.row == 1)
        {
            cell.leftImage.image =[UIImage imageNamed:@"floroscopy.png"];
        }
        else if(indexPath.row == 2)
        {
            cell.leftImage.image =[UIImage imageNamed:@"exposure.png"];
        }
        
        
        [exDelegate customizeCell:cell forRowAtIndexPath:indexPath]; // Add scroll View or set any view to bottom section

        
        cell.viewForBottomSection.backgroundColor = [UIColor clearColor];
        cell.viewForBottomSection.layer.borderWidth=0.6;
        cell.viewForBottomSection.layer.borderColor=[UIColor blackColor].CGColor;
        
       // ansViewFrame = cell.viewForBottomSection.frame;

      //  cell.viewForBottomSection.layer.borderColor=[[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1.0]CGColor];

        if (indexPath.row==0)
        {
            CGRect frame=cell.viewForTopSection.frame ;
           // frame.size.height+=30;
            cell.viewForTopSection.frame=frame ;
            
            cell.viewForTopSection.layer.backgroundColor=[[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcell0.png"]]CGColor];
            
        }
        
    }
    else
    {
        cell.userInteractionEnabled=YES ;
        //Otherwise just return the minimum height for the label.
        
        if(indexPath.row == 0)
        {
            cell.commentTextLabel.frame = CGRectMake(7,
                                                     cell.commentTextLabel.frame.origin.y+5,
                                                     cell.commentTextLabel.frame.size.width,
                                                     40);
            
        }
        else
        {
//        cell.commentTextLabel.frame = CGRectMake(cell.commentTextLabel.frame.origin.x,
//                                                 cell.commentTextLabel.frame.origin.y,
//                                                 cell.commentTextLabel.frame.size.width,
//                                                 questionLabelHeight);
            
        }
        
       /* cell.subCommentTextLabel.frame = CGRectMake(cell.commentTextLabel.frame.origin.x,
                                                 cell.commentTextLabel.frame.origin.y+100,
                                                 cell.commentTextLabel.frame.size.width,
                                                 questionLabelHeight);
        */
        
          // cell.viewForTopSection.frame=CGRectMake(cell.viewForTopSection.frame.origin.x, cell.viewForTopSection.frame.origin.y, cell.viewForTopSection.frame.size.width,100);

        
        cell.viewForBottomSection.frame = CGRectMake(0, 35, 80, 0);
        
         if(indexPath.row == 1)
         {
        cell.leftImage.image =[UIImage imageNamed:@"floroscopy.png"];
         }
        else if(indexPath.row == 2)
        {
            cell.leftImage.image =[UIImage imageNamed:@"exposure.png"];
        }
       
//        cell.frame = CGRectMake(cell.frame.origin.x,
//                                cell.frame.origin.y,
//                                cell.frame.size.width,
//                                questionLabelHeight);
        
        if (indexPath.row!=0) {
            cell.toggleImage.image = [UIImage imageNamed:@"downarrow.png"];
        }
        
        cell.userInteractionEnabled=YES ;
        [exDelegate customizeCollapsedCell:cell forRowAtIndexPath:indexPath];
    }
    
    cell.commentTextLabel.font = [UIFont fontWithName:@"Gill Sans" size:13.0f];
    cell.commentTextLabel.text =(NSString *)[self.tableCellViewLabels objectAtIndex:indexPath.row];
  
        cell.commentTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.commentTextLabel.numberOfLines = 2;
    
    
    
    //Praseeda
    if(indexPath.row == 0)
    {
        [exDelegate customizeDidSelectExpandedRowAtIndexPath:cell forRowAtIndexPath:indexPath];
    }

  
   // cell.viewForTopSection.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    cell.viewForTopSection.layer.borderWidth=1.0;
   // cell.viewForTopSection.layer.backgroundColor=[[UIColor colorWithRed:43/255.0 green:42/255.0 blue:39/255.0 alpha:1.0]CGColor];
    
    cell.viewForTopSection.layer.backgroundColor=[[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellbackGround.png"]]CGColor];
    
    cell.viewForTopSection.layer.cornerRadius=5.0;
    
//    if (indexPath.row==0)
//    {
//        CGRect frame=cell.viewForTopSection.frame ;
//        frame.size.height+=30;
//        cell.viewForTopSection.frame=frame ;
//        
//        cell.viewForTopSection.layer.backgroundColor=[[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundcell0.png"]]CGColor];
//        
//    }
    
    
   
            UIImageView *questionmarkVIEW = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"questionmark2.png"]];
            
            [cell.viewForTopSection addSubview:questionmarkVIEW];
            
            questionmarkVIEW.center =cell.viewForTopSection.center;
    
    questionmarkVIEW.tag=100;
    questionmarkVIEW.hidden=YES ;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If this is the selected index we need to return the height of the cell
    //in relation to the label height otherwise we just return the minimum label height with padding
    NSLog(@"selelcted Index is %d",selectedIndex);
    if(selectedIndex == indexPath.row)
    {
        return [exDelegate customizeHeightForRowAtIndexPath:indexPath];  // For Expanded row it needs to be defined.
    }
    else {
        
        if (indexPath.row==0)
        {
            return 20+18;
        }
        else
        {
            return 20.0 + 18;  // Default row hight when its collapsed state
        }
        
        }
        
    
    return 30.0;
}



-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //We only don't want to allow selection on any cells which cannot be expanded
    
    //    if([self getAnswerLabelHeightForIndex:indexPath.row] > [self getQuestionLabelHeightForIndex:indexPath.row])
    //    {
    //        return indexPath;
    //    }
    //    else {
    //        return nil;
    //    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int noOfRows = [tableView numberOfRowsInSection:indexPath.section];
    
    tableView.layer.borderWidth=0.7 ;
    
    
    if (noOfRows < (selectedIndex+1))
    {
        //Praseeda   selectedIndex = -1;  // Fix for crash when there are any rows selected and reload the table
        selectedIndex = 0;
    }
    
    if(selectedIndex == indexPath.row && selectedIndex!=0)
    {
        // At expanded row get collapsed
        selectedIndex = -1;
        [exDelegate customizeDidSelectCollapsedRowAtIndexPath:indexPath];
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
        
        
        return;
    }
    
    //First we check if a cell is already expanded.
    //If it is we want to minimize make sure it is reloaded to minimize it back
    //    if([tableView.accessibilityLabel isEqualToString:@"ChaneView"])
    //    {
    //
    //        tableView.contentSize=CGSizeMake(tableView.frame.size.width, 300+150);
    //    }
    
    [exDelegate customizeDidSelectExpandedRowAtIndexPath:indexPath ];
    
    
   if(selectedIndex >= 0)
    {
        //            [tableView reloadData];
        // Expand any row which is not selected previously
        NSIndexPath *previousPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        
        selectedIndex = indexPath.row;
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:previousPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
        
        selectedIndex = indexPath.row;
        [self performSelector: @selector(reloadAfterCollapse: ) withObject:tableView afterDelay:0.1];
        return;
    }
    
    //Finally set the selected index to the new selection and reload it to expand
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (tableView == dashboardTable)
    //    {
    //        [tableView flashScrollIndicators];
    //    }
    NSLog(@"Test");
}

- (void)reloadData
{
    //Fix for no proper index shown while coming back from BA Config
    // Logic is when going to the BAConfig view we will set the isComingFromBAConfig flag in BOViewController , while coming back from config view to BOViewController in view will appear we will check whether its coming from Config view  also we will check whether the previous selected item exists. If it existing we will take the Business Area id of that index and set the slected index accordingly
    int index = -2;
    index = [[NSUserDefaults standardUserDefaults] integerForKey:@"SelectedIndexAfterBAConf"];
    if(index >-2 && selectedIndex!= -1)
    {
        selectedIndex = index;
        [[NSUserDefaults standardUserDefaults] setInteger:-2 forKey:@"SelectedIndexAfterBAConf"];
    }
    //End
    [super reloadData];
}

- (void)viewDidLoad
{
    //[super viewDidLoad];
    NSLog(@"view did load man!!");
}


- (void)reloadAfterCollapse: (UITableView *) tableView
{
    NSIndexPath *nextPath = [NSIndexPath indexPathForRow: selectedIndex inSection: 0];
    [tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject: nextPath] withRowAnimation: UITableViewRowAnimationFade];
    
    [tableView deselectRowAtIndexPath: nextPath animated:YES];
}

@end
