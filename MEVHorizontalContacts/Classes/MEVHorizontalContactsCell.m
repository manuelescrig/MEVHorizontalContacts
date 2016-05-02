//
//  MEVHorizontalContactsCell.m
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 24/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//


#import "MEVHorizontalContactsCell.h"
#import "MEVHorizontalContactsModel.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

int const kBottomBarViewLabelHeight = 20;
int const kCellButtonWidth = 50;

@implementation MEVHorizontalContactsCell
{
    NSArray *menuViews;
}


- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    self.opaque = YES;
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleFingerTap];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.bounds) - kBottomBarViewLabelHeight, CGRectGetHeight(self.bounds) - kBottomBarViewLabelHeight)];
    _imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - kBottomBarViewLabelHeight/2);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = [UIColor lightGrayColor];
    _imageView.opaque = YES;
    _imageView.layer.cornerRadius = (CGRectGetHeight(self.bounds) - kBottomBarViewLabelHeight)/2;
//    imageView.layer.borderColor = UIColorFromRGB(PT_THEME_DARK_COLOR_2).CGColor;
    _imageView.layer.borderWidth = 1;
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - kBottomBarViewLabelHeight, CGRectGetWidth(self.bounds), kBottomBarViewLabelHeight)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
    [self addSubview:_label];
    
    return self;
}




#pragma mark - Actions

- (void)setUpCellOptions
{
    UIButton *view1 = [UIButton new];
    UIButton *view2 = [UIButton new];
    UIButton *view3 = [UIButton new];

    // create an array of those views
    menuViews = @[view1, view2, view3];
    
    int y = 70;
    int x = 6;
    int index = 0;
    for (UIButton *view in menuViews) {
        y += 10;

        view.alpha = 0.0f;
        
        UILabel *btnLabel = [UILabel new];
        [btnLabel setFrame:CGRectMake(0 - 10, 0 + 39, kCellButtonWidth + 20, kCellButtonWidth)];
        [view setFrame:CGRectMake(y, x, kCellButtonWidth, kCellButtonWidth)];
        y += kCellButtonWidth + 10;
        [view setBackgroundColor:[UIColor whiteColor]];
        [view setTintColor:UIColorFromRGB(0x00C4E5)];
        UIImage *btnImage;
        
        switch (index) {
            case 0:
                [btnLabel setText:@"Call"];
//                btnImage = [[[UIImage imageNamed:@"IconProfilePhone"] imageToFitSize:CGSizeMake(40, 40) method:MGImageResizeScale] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                [view addTarget:self action:@selector(buttonCall:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                [btnLabel setText:@"Message"];
//                btnImage = [[[UIImage imageNamed:@"IconProfileMessage"] imageToFitSize:CGSizeMake(40, 40) method:MGImageResizeScale] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                [view addTarget:self action:@selector(buttonMessage:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                [btnLabel setText:@"Email"];
//                btnImage = [[[UIImage imageNamed:@"IconProfileEmail"] imageToFitSize:CGSizeMake(40, 40) method:MGImageResizeScale] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                [view addTarget:self action:@selector(buttonEmail:) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
        [view setImage:btnImage forState:UIControlStateNormal];
        [view.layer setCornerRadius:kCellButtonWidth/2];
        [self addSubview:view];
    
        btnLabel.backgroundColor = [UIColor clearColor];
        btnLabel.textColor = [UIColor whiteColor];
        btnLabel.textAlignment = NSTextAlignmentCenter;
        btnLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
        [view addSubview:btnLabel];
        
        index++;
    }
    
    [self showMenuViews];
}


- (void)buttonCall:(UIButton *)sender
{

    if([_cellDelegate respondsToSelector:@selector(menuSelectedOption:atIndex:)])
        [_cellDelegate menuSelectedOption:0 atIndex:self.tag];
}


- (void)buttonMessage:(UIButton *)sender
{
    
    if([_cellDelegate respondsToSelector:@selector(menuSelectedOption:atIndex:)])
        [_cellDelegate menuSelectedOption:1 atIndex:self.tag];
}

- (void)buttonEmail:(UIButton *)sender
{
    
    if([_cellDelegate respondsToSelector:@selector(menuSelectedOption:atIndex:)])
        [_cellDelegate menuSelectedOption:2 atIndex:self.tag];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    if([_cellDelegate respondsToSelector:@selector(cellSelected:)])
        [_cellDelegate cellSelected:self.tag];
}

#pragma mark - Animation Methods

- (void)showMenuViews
{
    float delay = 0.05f;
    for (UIView *view in menuViews) {

        [view setUserInteractionEnabled:NO];
        [UIView animateWithDuration:0.1f
                              delay:0.1f + (delay * [menuViews indexOfObject:view])
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            view.alpha = 1;
        } completion:^(BOOL finished) {
            [view setUserInteractionEnabled:YES];
        }];
    }
}


- (void)hideMenuViews
{
    float delay = 0.05f;
    int pos = 0;
    for (int i = (int)[menuViews count]; i > 0 ; i--) {
        UIView *view = [menuViews objectAtIndex:i-1];
        [UIView animateWithDuration:0.1f
                              delay:delay * pos
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             view.alpha = 0;
                         } completion:^(BOOL finished) {
                             [view removeFromSuperview];
                         }];
        pos++;
    }
}


#pragma mark - Overridden Properties


-(void)setContactModel:(MEVHorizontalContactsModel *)model
{
    self.contact = model;
    
    [_imageView setImage:[model image]];
    [_label setText:[model getName]];
}

@end
