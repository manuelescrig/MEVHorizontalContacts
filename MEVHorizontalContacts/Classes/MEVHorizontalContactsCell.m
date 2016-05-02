//
//  MEVHorizontalContactsCell.m
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 24/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//


#import "MEVHorizontalContactsCell.h"
#import "MEVHorizontalContactsModel.h"

int const kBottomBarViewLabelHeight = 30;
int const kCellButtonWidth = 50;

@implementation MEVHorizontalContactsCell
{
    NSMutableArray *menuOptions;
}


- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    self.opaque = YES;
    
    menuOptions = [NSMutableArray new];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellSingleTap:)];
    [self addGestureRecognizer:singleTap];

    float maxWidth = CGRectGetHeight(self.bounds) - kBottomBarViewLabelHeight;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, maxWidth)];
    _imageView.opaque = YES;
    _imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - kBottomBarViewLabelHeight/2);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = [UIColor lightGrayColor];
    _imageView.layer.cornerRadius = (maxWidth)/2;
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - kBottomBarViewLabelHeight, CGRectGetWidth(self.bounds), kBottomBarViewLabelHeight)];
    _label.opaque = YES;
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:12];
    [self addSubview:_label];
    
    return self;
}

#pragma mark - MEVHorizontalContactsCellDataSource Methods



#pragma mark - Actions

- (void)cellSingleTap:(UITapGestureRecognizer *)recognizer
{
    if([_cellDelegate respondsToSelector:@selector(cellSelectedAtIndexPath:)])
        [_cellDelegate cellSelectedAtIndexPath:self.cellIndexPath];
}

- (void)menuOptionSingleTap:(UIButton *)sender
{
    NSLog(@"menuOptionSingleTap");
    if([_cellDelegate respondsToSelector:@selector(menuOptionSelected:atIndexPath:)])
        [_cellDelegate menuOptionSelected:sender.tag atIndexPath:self.cellIndexPath];
}

- (void)setUpCellOptions
{
    int numberOfItems;
    if([_cellDataSource respondsToSelector:@selector(numberOfItemsInCellIndexPath:)])
        numberOfItems = [_cellDataSource numberOfItemsInCellIndexPath:self.cellIndexPath];
    
    int y = 70;
    int x = 6;
    
    for (int index = 0; index < numberOfItems ; index++) {
        
        UIButton *button = [UIButton new];
        button.tag = index;
        button.alpha = 0;

        y += 10;
        
        UILabel *buttonLabel = [UILabel new];
        [buttonLabel setFrame:CGRectMake(0 - 10, 0 + 39, kCellButtonWidth + 20, kCellButtonWidth)];
        [button setFrame:CGRectMake(y, x, kCellButtonWidth, kCellButtonWidth)];
        y += kCellButtonWidth + 10;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTintColor:[UIColor redColor]];
        
        if ([_cellDataSource respondsToSelector:@selector(textForItemAtIndex:inCellIndexPath:)]) {
            
            NSString *textLabel = [_cellDataSource textForItemAtIndex:index inCellIndexPath:self.cellIndexPath];
            [buttonLabel setText:textLabel];
            buttonLabel.backgroundColor = [UIColor clearColor];
            buttonLabel.textColor = [UIColor whiteColor];
            buttonLabel.textAlignment = NSTextAlignmentCenter;
            buttonLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
            [button addSubview:buttonLabel];
        }
     
        if ([_cellDataSource respondsToSelector:@selector(imageForItemAtIndex:inCellIndexPath:)]) {
            
            UIImage *image = [_cellDataSource imageForItemAtIndex:index inCellIndexPath:self.cellIndexPath];
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [button setImage:image forState:UIControlStateNormal];
            [button.layer setCornerRadius:kCellButtonWidth/2];
            [self addSubview:button];
        }
        
        [menuOptions addObject:button];
        [button addTarget:self action:@selector(menuOptionSingleTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self showMenuOptions];
}


#pragma mark - Animation Methods

- (void)showMenuOptions
{
    float delay = 0.5f;
    for (UIView *view in menuOptions) {

        [view setUserInteractionEnabled:NO];
        [UIView animateWithDuration:0.1f
                              delay:0.1f + (delay * [menuOptions indexOfObject:view])
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            view.alpha = 1;
        } completion:^(BOOL finished) {
            [view setUserInteractionEnabled:YES];
        }];
    }
}


- (void)hideMenuOptions
{
    float delay = 0.05f;
    int pos = 0;
    for (int i = (int)[menuOptions count]; i > 0 ; i--) {
        UIView *view = [menuOptions objectAtIndex:i-1];
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

- (void)setContactModel:(MEVHorizontalContactsModel *)model
{
    self.contact = model;
    
    [_imageView setImage:[model image]];
    [_label setText:[model getName]];
}

@end
