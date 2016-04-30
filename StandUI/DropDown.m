//
//  DropDown.m
//  StandUI
//
//  Created by CLPricingTeam on 8/7/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "DropDown.h"

@implementation DropDown


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        list=[[NSMutableArray alloc]init];
        self.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
        self.layer.cornerRadius=5.0;
        self.layer.borderColor=[[UIColor darkGrayColor]CGColor];
        self.layer.borderWidth=1.0;
        
        
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
-(void)initialiseDataSource:(NSArray*)listItems with:(NSString *)selectedMode
{
    for (NSString *item in listItems) {
        [list addObject:item];
    }
    self.smode = selectedMode;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[list objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont fontWithName:@"Gill Sans" size:14.0f];
    if([cell.textLabel.text isEqualToString:self.smode])
    {
    cell.backgroundColor=[UIColor colorWithRed:255/255.0 green:183/255.0 blue:48/255.0 alpha:.50];
    }else{
          cell.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dropdowndelegate collapseTable:tableView.frame rowNumber:indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 32;
}


@end
