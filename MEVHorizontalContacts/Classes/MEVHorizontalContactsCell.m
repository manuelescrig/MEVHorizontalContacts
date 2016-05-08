//
//  MEVHorizontalContactsCell.m
//  An iOS UICollectionViewLayout subclass to show a list of contacts with configurable expandable items.
//
//  https://github.com/manuelescrig/MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 24/02/16.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//  Licence: MIT-Licence
//

#import "MEVHorizontalContactsCell.h"

static float const kMEVHorizontalContactsDefaultShowAnimationTime = 0.12f;
static float const kMEVHorizontalContactsDefaultHideAnimationTime = 0.03f;

@interface MEVHorizontalContactsCell()

@property (nonatomic, strong) NSMutableArray *items;

@end


@implementation MEVHorizontalContactsCell


#pragma mark - View Life Cycle (public)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


#pragma mark - View Life Cycle (private)

- (void)setupView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setOpaque:YES];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellSingleTap:)];
    [self addGestureRecognizer:singleTap];
    
    _items = [NSMutableArray new];
    
    _imageView = [UIImageView new];
    _imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - _labelHeight/2);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.opaque = YES;
    _imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _label = [UILabel new];
    _label.opaque = YES;
    _label.textColor = [self mev_horizontalContactsContactLabelTextColor];
    _label.font = [self mev_horizontalContactsContactLabelFont];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_label];
}


#pragma mark - Layout (private)

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Background Colors
    _imageView.backgroundColor = self.backgroundColor;
    _label.backgroundColor = self.backgroundColor;
    
    // Sizes
    float maxWidth = CGRectGetHeight(self.bounds) - _labelHeight;
    _imageView.frame = CGRectMake(0, 0, maxWidth, maxWidth);
    _imageView.layer.cornerRadius = (maxWidth)/2;
    _label.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - _labelHeight, CGRectGetHeight(self.bounds) - _labelHeight, _labelHeight);
}

//TODO:Add asserts
#pragma mark - Getters (private)

- (BOOL)mev_horizontalContactsCornerRadious
{
    return YES;
}

- (UIColor *)mev_horizontalContactsContactLabelTextColor
{
    return [UIColor grayColor];
}

- (UIFont *)mev_horizontalContactsContactLabelFont
{
    return [UIFont systemFontOfSize:12];
}

- (UIColor *)mev_horizontalContactsItemLabelTextColor
{
    return [UIColor grayColor];
}

- (UIFont *)mev_horizontalContactsItemLabelFont
{
    return [UIFont systemFontOfSize:12];
}


#pragma mark - UI Actions (private)

- (void)cellSingleTap:(UITapGestureRecognizer *)recognizer
{
    if (self.isSelected) {
        [self hideItems];
    } else {
        [self showItems];
    }
    
    if ([_delegate respondsToSelector:@selector(cellSelectedAtIndexPath:)])
        [_delegate cellSelectedAtIndexPath:_indexPath];
}

- (void)menuItemSingleTap:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(itemSelected:atCellIndexPath:)])
        [_delegate itemSelected:sender.tag atCellIndexPath:_indexPath];
}


#pragma mark - Setup Methods (Private)

- (void)setUpCellOptions
{
    [_items makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_items removeAllObjects];
    
    int numberOfItems;
    if ([_dataSource respondsToSelector:@selector(numberOfItemsInCellIndexPath:)]) {
        numberOfItems = [_dataSource numberOfItemsInCellIndexPath:_indexPath];
    }
    
    float maxWidth = CGRectGetHeight(self.bounds) - _labelHeight;
    int xOffset = maxWidth;
    xOffset += _itemSpacing;
    
    for (int index = 0; index < numberOfItems ; index++) {
        
        UIButton *button = [UIButton new];
        button.frame = CGRectMake(xOffset,0, maxWidth, CGRectGetHeight(self.bounds));
        button.tag = index;
        button.opaque = YES;
        button.alpha = 0;
        button.backgroundColor = self.backgroundColor;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(menuItemSingleTap:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([_dataSource respondsToSelector:@selector(item:atContactIndex:)]) {
            MEVHorizontalContactsCell *cell = [_dataSource item:index atContactIndex:_indexPath.row];
            [cell.imageView setFrame:CGRectMake(0, 0, maxWidth, maxWidth)];
            [cell.imageView setOpaque:YES];
            [cell.imageView setImage:[[cell.imageView image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            [cell.imageView setTintColor:[UIColor blueColor]];
            [cell.imageView setBackgroundColor:self.backgroundColor];
            [cell.imageView setContentMode:UIViewContentModeCenter];
            [cell.imageView.layer setCornerRadius:maxWidth/2];
            [cell.imageView.layer setMasksToBounds:YES];
            [button addSubview:cell.imageView];
            
            [cell.label setFrame:CGRectMake(0, CGRectGetHeight(button.frame) - _labelHeight, CGRectGetWidth(button.frame), _labelHeight)];
            [cell.label setOpaque:YES];
            [cell.label setBackgroundColor:self.backgroundColor];
            [cell.label setTextAlignment:NSTextAlignmentCenter];
            [cell.label setTextColor:[self mev_horizontalContactsItemLabelTextColor]];
            [cell.label setFont:[self mev_horizontalContactsItemLabelFont]];
            [button addSubview:cell.label];
        }
        
        [_items addObject:button];
        [self addSubview:button];
        
        xOffset += (maxWidth + _itemSpacing);
    }
}


#pragma mark - Animation Methods (Public)

- (void)showItems
{
    switch (_animationMode) {
        case MEVHorizontalsAnimationBounce:
            [self setSelectedAnimated:YES];
            [self showMenuItemsAnimated:YES];
            break;
            
        default:
            [self setSelectedAnimated:NO];
            [self showMenuItemsAnimated:NO];
            break;
    }
}

- (void)hideItems
{
    switch (_animationMode) {
        case MEVHorizontalsAnimationBounce:
            [self setUnselectedAnimated:YES];
            [self hideMenuItemsAnimated:YES];
            break;
            
        default:
            [self setUnselectedAnimated:NO];
            [self hideMenuItemsAnimated:NO];
            break;
    }
}

- (void)setSelectedAnimated:(BOOL)animated
{
    self.selected = YES;
    [self setUserInteractionEnabled:NO];
    
    if (animated) {
        float animationTime = animated ? kMEVHorizontalContactsDefaultShowAnimationTime : 0.0;
        [UIView animateWithDuration:animationTime
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.9, 0.9, 0.9);
                             _label.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.9, 0.9, 0.9);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:animationTime
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.01, 1.01, 1.01);
                                                  _label.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.01, 1.01, 1.01);
                                              } completion:^(BOOL finished) {
                                                  [UIView animateWithDuration:animationTime
                                                                        delay:0
                                                                      options:UIViewAnimationOptionCurveEaseOut
                                                                   animations:^{
                                                                       _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1);
                                                                       _label.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1);
                                                                   } completion:^(BOOL finished) {
                                                                       [self setUserInteractionEnabled:YES];
                                                                   }];
                                              }];
                         }];
    } else {
        [self setUserInteractionEnabled:YES];
    }
}

- (void)setUnselectedAnimated:(BOOL)animated
{
    self.selected = NO;
    [self setUserInteractionEnabled:NO];
    
    if (animated) {
        float animationTime = animated ? (kMEVHorizontalContactsDefaultShowAnimationTime*2) : 0.0;
        [UIView animateWithDuration:animationTime
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.01, 1.01, 1.01);
                             _label.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.01, 1.01, 1.01);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:animationTime
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1);
                                                  _label.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1);
                                              } completion:^(BOOL finished) {
                                                  [self setUserInteractionEnabled:YES];
                                              }];
                         }];
        
    } else {
        [self setUserInteractionEnabled:YES];
    }
}

- (void)showMenuItemsAnimated:(BOOL)animated
{
    [self setUpCellOptions];
    
    float animationTime = animated ? kMEVHorizontalContactsDefaultShowAnimationTime : 0.0;
    for (UIView *view in _items) {
        view.alpha = 0;
        view.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5);
        [UIView animateWithDuration:animationTime
                              delay:animationTime * ([_items indexOfObject:view]+1)
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             view.alpha = 0.6;
                             view.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.05, 1.05, 1.05);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:animationTime
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  view.alpha = 1;
                                                  view.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1);
                                              } completion:^(BOOL finished) {  }];
                         }];
    }
}


- (void)hideMenuItemsAnimated:(BOOL)animated
{
    int pos = 0;
    float animationTime = animated ? kMEVHorizontalContactsDefaultHideAnimationTime : 0.0f;
    for (int i = (int)[_items count]; i > 0 ; i--) {
        UIView *view = [_items objectAtIndex:i-1];
        [UIView animateWithDuration:animationTime
                              delay:animationTime * pos
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             view.alpha = 0;
                         } completion:^(BOOL finished) {
                             [view removeFromSuperview];
                         }];
        pos++;
    }
}

@end
