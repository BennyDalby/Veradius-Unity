//
//  ScrollPanelView.m
//  StandUI
//
//  Created by CLPricingTeam on 10/15/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#import "ScrollPanelView.h"

@implementation ScrollPanelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        }
    return self;
}

-(void)removerallButtons
{
    for (UIView *subview in [self subviews])
    {
        if ([subview isKindOfClass:[UIButton class]])
        {
            [subview removeFromSuperview];
        }
    }
    
    
    
}


-(void)Addoverview1
{
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Overview1_1K.png"]];
    [self removerallButtons];
    
    imageview.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:imageview];
    
    self.backgroundColor=[UIColor clearColor];
    int count=12 ;
    CGFloat x=62;
    CGFloat y=60;
    CGPoint point ;
     tag=_tagvalue;
    
    for (int i=0; i<count; i++,x+=125)
    {
        
        UIButton *view = [[UIButton alloc]init];
        
          CGRect frame ;
        if (i<=3)
        {
            
            frame.size.width = 126 ;
            frame.size.height = 135 ;
        }
        
        else if(i>3)
        {
          
            frame.size.width = 126 ;
            frame.size.height = 125 ;
            
        }
        
        view.frame = frame ;
        
        
        
        if (x>500 && i>=8) {
            y+=127 ;
            x=61;
        }
        
        if (x>500 && i>=3) {
            y+=127 ;
            x=61;
        }
        
        
        point.x =x;
        point.y =y ;
        
        view.center=point ;
        
       
        view.tag=i;
        
//        if(view.tag==_runvalue && _runvalue==0)
//        {
//            if (view.frame.size.width==126)
//            {
//            view.layer.borderWidth=1.0;
//            view.layer.borderColor=[[UIColor whiteColor]CGColor];
//            }
//            tag=_runvalue ;
//        }
//        
//         else if(view.tag==_runvalue-1 && _runvalue!=0)
//        {
//            if (view.frame.size.width==126)
//            {
//            view.layer.borderWidth=1.0;
//            view.layer.borderColor=[[UIColor whiteColor]CGColor];
//            }
//            tag=_runvalue-1 ;
//        }
        
        if(view.tag==_tagvalue)
        {
            if (view.frame.size.width==126)
            {
                if (view.frame.size.width==126)
                {
                    view.layer.borderWidth = 1.0 ;
                    view.layer.borderColor = [[UIColor whiteColor]CGColor];
                    
                }
                
                
            }
        }
       
        
        [view addTarget:self action:@selector(viewpressed:) forControlEvents:UIControlEventTouchUpInside];
        
        view.backgroundColor=[UIColor clearColor];
        
        [self addSubview:view];
        
    }
    
}

-(void)Addoverview2
{
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Overview2_1K.png"]];
    
    [self removerallButtons];
    
    imageview.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:imageview];
    
    self.backgroundColor=[UIColor clearColor];
    int count=14 ;
    CGFloat x=62;
    CGFloat y=60;
    CGPoint point ;
    tag=_tagvalue;
    
    for (int i=0; i<count; i++,x+=125)
    {
        
        UIButton *view = [[UIButton alloc]init];
        
        CGRect frame ;
        if (i<=3)
        {
            
            frame.size.width = 126 ;
            frame.size.height = 135 ;
        }
        
        else if(i>3)
        {
            
            frame.size.width = 126 ;
            frame.size.height = 125 ;
            
        }
        
        view.frame = frame ;
        
        
        
        if (x>500 && i>=8) {
            y+=127 ;
            x=61;
        }
        
        if (x>500 && i>=3) {
            y+=127 ;
            x=61;
        }
        
        
        
        
        point.x =x;
        point.y =y ;
        
        view.center=point ;
        
        
        view.tag=i;
        
//        if(view.tag==_runvalue && _runvalue==0)
//        {
//            if (view.frame.size.width==126)
//            {
//            view.layer.borderWidth=1.0;
//            view.layer.borderColor=[[UIColor whiteColor]CGColor];
//            }
//            tag=_runvalue ;
//            _tagvalue=tag ;
//        }
//        
//        else if(view.tag==_runvalue-1+_imageNovalue-1 && _runvalue!=0)
//        {
//            if (view.frame.size.width==126)
//            {
//            view.layer.borderWidth=1.0;
//            view.layer.borderColor=[[UIColor whiteColor]CGColor];
//            }
//            tag=_runvalue-1+_imageNovalue-1 ;
//            _tagvalue=tag ;
//        }
        
        if(view.tag==_tagvalue)
        {
            if (view.frame.size.width==126)
            {
                if (view.frame.size.width==126)
                {
                    view.layer.borderWidth = 1.0 ;
                    view.layer.borderColor = [[UIColor whiteColor]CGColor];
                    
                }
                
                
            }
        }
        
        [view addTarget:self action:@selector(viewpressed:) forControlEvents:UIControlEventTouchUpInside];
        
        view.backgroundColor=[UIColor clearColor];
       // view.tag=999 ;
        
        [self addSubview:view];
        
    }
    
    
}

-(void)Addoverview3
{
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Overview3_1K.png"]];
    
    [self removerallButtons];
    
    imageview.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:imageview];
    
    self.backgroundColor=[UIColor clearColor];
    int count=16 ;
    CGFloat x=62;
    CGFloat y=60;
    CGPoint point ;
    tag=_tagvalue;
    
    for (int i=0; i<count; i++,x+=125)
    {
        
        UIButton *view = [[UIButton alloc]init];
        
        CGRect frame ;
        if (i<=3)
        {
            
            frame.size.width = 126 ;
            frame.size.height = 135 ;
        }
        
        else if(i>3)
        {
            
            frame.size.width = 126 ;
            frame.size.height = 125 ;
            
        }
        
        view.frame = frame ;
        
        if (x>500 && i>=12) {
            y+=125 ;
            x=61;
        }
        
        if (x>500 && i>=8) {
            y+=127 ;
            x=61;
        }
        
        if (x>500 && i>=3) {
            y+=127 ;
            x=61;
        }
        
        
        
        
        point.x =x;
        point.y =y ;
        
        view.center=point ;
        
        
        view.tag=i;
        
//        if(view.tag==_runvalue && _runvalue==0)
//        {
//            if (view.frame.size.width==126)
//            {
//            view.layer.borderWidth=1.0;
//            view.layer.borderColor=[[UIColor whiteColor]CGColor];
//            }
//            tag=_runvalue ;
//            _tagvalue=tag;
//        }
//        
//        else if(view.tag==_runvalue-1+_imageNovalue-1 && _runvalue!=0)
//        {
//            if (view.frame.size.width==126)
//            {
//            view.layer.borderWidth=1.0;
//            view.layer.borderColor=[[UIColor whiteColor]CGColor];
//            }
//            tag=_runvalue-1+_imageNovalue-1;
//            _tagvalue=tag ;
//        }
        
        if(view.tag==_tagvalue)
        {
            if (view.frame.size.width==126)
            {
                if (view.frame.size.width==126)
                {
                    view.layer.borderWidth = 1.0 ;
                    view.layer.borderColor = [[UIColor whiteColor]CGColor];
                    
                }
                
                
            }
        }
        
        [view addTarget:self action:@selector(viewpressed:) forControlEvents:UIControlEventTouchUpInside];
        
        view.backgroundColor=[UIColor clearColor];
        
        [self addSubview:view];
        
    }
    
    
}


-(void)viewpressed:(UIButton *)sender
{
    for (UIButton *view in [self subviews])
    {
        if (view.tag==tag)
        {
            view.layer.borderWidth=1.0;
            view.layer.borderColor=[[UIColor clearColor]CGColor];

        }
    }
    
    sender.layer.borderWidth=1.0;
    sender.layer.borderColor=[[UIColor whiteColor]CGColor];
    int oldtag=tag ;
    tag=sender.tag ;
    _tagvalue=tag ;
    
    [_scrolldelegate updateRUN] ; //update the main image
    
    
    if (oldtag==sender.tag) //Clicking once more
    {
        
        self.hidden=YES;
        [_scrolldelegate UpdateRightSidebar];
    }

   
    
}

-(void)nextbuttonOvetview1
{
    
    for (UIButton *view in [self subviews])
    {
        if (view.tag==tag)
        {
            view.layer.borderWidth=1.0;
            view.layer.borderColor=[[UIColor clearColor]CGColor];
            
        }
        
    }
    
    tag=tag+1;
    _tagvalue=tag ;
    
    if (tag>11)
    {
        _tagvalue=0;
        return ;
    }
    
   // else
    {
        for (UIButton *view in [self subviews])
        {
            if (view.tag==tag)
            {
                if (view.frame.size.width==126)
                {
                    view.layer.borderWidth=1.0;
                    view.layer.borderColor=[[UIColor whiteColor]CGColor];

                }
                
            }
        }
        
        
    }
    

}

-(void)prevbuttonOverview1
{
    
    
    for (UIButton *view in [self subviews])
    {
        if (view.tag==tag)
        {
            
                view.layer.borderWidth=1.0;
                view.layer.borderColor=[[UIColor clearColor]CGColor];
            
        }
        
        
    }
    
    tag=tag-1;
    _tagvalue=tag ;
    
    if (tag<0)
    {
        //make the previous button disabled
        _tagvalue=0 ;
       
        return ;
    }
    
    else
    {
        for (UIButton *view in [self subviews])
        {
            if (view.tag==tag)
            {
                if (view.frame.size.width==126)
                {
                view.layer.borderWidth=1.0;
                view.layer.borderColor=[[UIColor whiteColor]CGColor];
                
                }
                
            }
        }
        
        
    }
    
   
}

-(void)prevbuttonOverview2
{
    
    
    for (UIButton *view in [self subviews])
    {
        if (view.tag==tag)
        {
            
            view.layer.borderWidth=1.0;
            view.layer.borderColor=[[UIColor clearColor]CGColor];
            
        }
        
        
    }
    
    tag=tag-1;
    _tagvalue=tag ;
    
    if (tag<0)
    {
        //make the previous button disabled
        _tagvalue=0 ;
        
        return ;
    }
    
    else
    {
        for (UIButton *view in [self subviews])
        {
            if (view.tag==tag)
            {
                if (view.frame.size.width==126)
                {
                    view.layer.borderWidth=1.0;
                    view.layer.borderColor=[[UIColor whiteColor]CGColor];
                    
                }
                
            }
        }
        
        
    }
    

    
}

-(void)prevbuttonOverview3
{
    
    
    for (UIButton *view in [self subviews])
    {
        if (view.tag==tag)
        {
            
            view.layer.borderWidth=1.0;
            view.layer.borderColor=[[UIColor clearColor]CGColor];
            
        }
        
        
    }
    
    tag=tag-1;
    _tagvalue=tag ;
    
    if (tag<0)
    {
        //make the previous button disabled
        _tagvalue=0 ;
        
        return ;
    }
    
    else
    {
        for (UIButton *view in [self subviews])
        {
            if (view.tag==tag)
            {
                if (view.frame.size.width==126)
                {
                    view.layer.borderWidth=1.0;
                    view.layer.borderColor=[[UIColor whiteColor]CGColor];
                    
                }
                
            }
        }
        
        
    }
    

    
}

-(void)nextbuttonOvetview3
{
    for (UIButton *view in [self subviews])
    {
        if (view.tag==tag)
        {
            view.layer.borderWidth=1.0;
            view.layer.borderColor=[[UIColor clearColor]CGColor];
            
        }
        
    }
    
    tag=tag+1;
    _tagvalue=tag ;
    
    if (tag>13)
    {
       
        _tagvalue=0;
        return ;
    }
    
    else
    {
        for (UIButton *view in [self subviews])
        {
            if (view.tag==tag)
            {
                if (view.frame.size.width==126)
                {
                view.layer.borderWidth=1.0;
                view.layer.borderColor=[[UIColor whiteColor]CGColor];
                
                }
                
            }
        }
        
        
    }

     
}




-(void)nextbuttonOvetview2
{
    
    for (UIButton *view in [self subviews])
    {
        if (view.tag==tag)
        {
            view.layer.borderWidth=1.0;
            view.layer.borderColor=[[UIColor clearColor]CGColor];
            
        }
        
    }
    
    tag=tag+1;
    _tagvalue=tag ;
    
    if (tag>15)
    {
        [self Addoverview3];
    }
    
   // else
    {
        for (UIButton *view in [self subviews])
        {
            if (view.tag==tag)
            {
                if (view.frame.size.width==126)
                {
                view.layer.borderWidth=1.0;
                view.layer.borderColor=[[UIColor whiteColor]CGColor];
                }
                
                
            }
        }
        
        
    }
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
