//
//  MEVHorizontalContactsAddContactView.m
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 25/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVHorizontalContactsAddContactView.h"

@implementation MEVHorizontalContactsAddContactView


- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    self.opaque = YES;
    self.backgroundColor = [UIColor lightGrayColor];
    
    UIImage *image = [[UIImage imageNamed:@"IconAdd"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button setImage:image forState:UIControlStateSelected];
    [button setOpaque:YES];
    [button.layer setCornerRadius:30];
    [button setTintColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
    [button setBackgroundColor:[UIColor colorWithRed:34/255.0f green:167/255.0f blue:240/255.0f alpha:1.0f]];
    [button addTarget:self action:@selector(buttonDidTap:) forControlEvents:UIControlEventTouchDown];
    [button setFrame:CGRectMake(0,10,60,60)];
    [self addSubview:button];
    
    return self;
}

- (void)buttonDidTap:(UIButton *)sender
{
    if([_buttonDelegate respondsToSelector:@selector(buttonDidTap:)])
        [_buttonDelegate buttonDidTap:sender];
}


+ (CGSize)defaultSize
{
    return CGSizeMake(60, 60);
}

@end
