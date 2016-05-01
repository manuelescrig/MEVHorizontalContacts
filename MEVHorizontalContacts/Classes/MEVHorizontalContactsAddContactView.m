//
//  MEVHorizontalContactsAddContactView.m
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 25/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVHorizontalContactsAddContactView.h"

@implementation MEVHorizontalContactsAddContactView

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    self.opaque = YES;
    self.backgroundColor = [UIColor clearColor];
    
    UIImage *image = [[UIImage imageNamed:@"IconAdd"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button setImage:image forState:UIControlStateSelected];
    [button setOpaque:YES];
    [button.layer setCornerRadius:30];
    [button setTintColor:UIColorFromRGB(0xFFFFFF)];
    [button setBackgroundColor:UIColorFromRGB(0x00C4E5)];
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
    return CGSizeMake(50, 50);
}

@end
