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
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellSingleTap:)];
    [self addGestureRecognizer:singleTap];
    
    _items = [NSMutableArray new];
    _rounded = YES;

    _imageView = [UIImageView new];
    _imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - _labelHeight/2);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _label = [UILabel new];
    _label.textColor = [self mev_horizontalContactsContactLabelTextColor];
    _label.font = [self mev_horizontalContactsContactLabelFont];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_label];
}


#pragma mark - Layout (private)

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Colors
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];

    // Sizes
    float itemWidth = [self mev_horizontalContactsItemWidth];
    _imageView.frame = CGRectMake(0, 0, itemWidth, itemWidth);
    _imageView.layer.cornerRadius = [self mev_horizontalContactsCornerRadious];
    _label.frame = CGRectMake(0, itemWidth, itemWidth, _labelHeight);
}


#pragma mark - Getters (private)

- (CGFloat)mev_horizontalContactsCornerRadious
{
    if (self.isRounded) {
        return [self mev_horizontalContactsItemWidth]/2;
    } else {
        return 0;
    }
}

- (CGFloat)mev_horizontalContactsItemWidth
{
    return CGRectGetHeight(self.bounds) - _labelHeight;
}

- (CGFloat)mev_horizontalContactsItemHeight
{
    return CGRectGetHeight(self.bounds);
}

- (UIColor *)mev_horizontalContactsContactLabelTextColor
{
    if (self.backgroundColor) {
        return self.backgroundColor;
    } else {
        // Default value when not assigend
        self.backgroundColor = [UIColor clearColor];
        return self.backgroundColor;
    }
}

- (UIFont *)mev_horizontalContactsContactLabelFont
{
    // Default value when not assigend
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
    
    NSInteger numberOfItems = 0;
    if ([_dataSource respondsToSelector:@selector(numberOfItemsInCellIndexPath:)]) {
        numberOfItems = [_dataSource numberOfItemsInCellIndexPath:_indexPath];
    }
    
    float itemWidth = [self mev_horizontalContactsItemWidth];
    float itemHeight = [self mev_horizontalContactsItemHeight];
    int xOffset = itemWidth;
    xOffset += _itemSpacing;
    
    for (int index = 0; index < numberOfItems ; index++) {
        
        UIButton *button = [UIButton new];
        button.frame = CGRectMake(xOffset,0, itemWidth, itemHeight);
        button.tag = index;
        button.opaque = YES;
        button.alpha = 0;
        button.backgroundColor = [UIColor clearColor];
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(menuItemSingleTap:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([_dataSource respondsToSelector:@selector(item:atContactIndex:)]) {
            MEVHorizontalContactsCell *cell = [_dataSource item:index atContactIndex:_indexPath.row];
            [cell.imageView setFrame:CGRectMake(0, 0, itemWidth, itemWidth)];
            [cell.imageView setOpaque:YES];
            [cell.imageView setImage:[[cell.imageView image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            [cell.imageView setContentMode:UIViewContentModeCenter];
            [cell.imageView.layer setCornerRadius:[self mev_horizontalContactsCornerRadious]];
            [cell.imageView.layer setMasksToBounds:YES];
            [button addSubview:cell.imageView];
            
            [cell.label setFrame:CGRectMake(0, itemWidth, itemWidth, _labelHeight)];
            [cell.label setOpaque:YES];
            [cell.label setTextAlignment:NSTextAlignmentCenter];
            [button addSubview:cell.label];
        }
        
        [_items addObject:button];
        [self addSubview:button];
        
        xOffset += (itemWidth + _itemSpacing);
    }
}


#pragma mark - Animation Methods (Private)

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
        float animationTime = animated ? kMEVHorizontalContactsDefaultShowAnimationTime : 0;
        float minValue = 0.9;
        float maxValue = 1.02;
        float regValue = 1;
        [UIView animateWithDuration:animationTime
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, minValue, minValue, minValue);
                             _label.layer.transform = CATransform3DScale(CATransform3DIdentity, minValue, minValue, minValue);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:animationTime
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, maxValue, maxValue, maxValue);
                                                  _label.layer.transform = CATransform3DScale(CATransform3DIdentity, maxValue, maxValue, maxValue);
                                              } completion:^(BOOL finished) {
                                                  [UIView animateWithDuration:animationTime
                                                                        delay:0
                                                                      options:UIViewAnimationOptionCurveEaseOut
                                                                   animations:^{
                                                                       _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, regValue, regValue, regValue);
                                                                       _label.layer.transform = CATransform3DScale(CATransform3DIdentity, regValue, regValue, regValue);
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
        float animationTime = animated ? (kMEVHorizontalContactsDefaultShowAnimationTime*2) : 0;
        float maxValue = 1.02;
        float regValue = 1;
        [UIView animateWithDuration:animationTime
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, maxValue, maxValue, maxValue);
                             _label.layer.transform = CATransform3DScale(CATransform3DIdentity, maxValue, maxValue, maxValue);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:animationTime
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, regValue, regValue, regValue);
                                                  _label.layer.transform = CATransform3DScale(CATransform3DIdentity, regValue, regValue, regValue);
                                              } completion:^(BOOL finished) {
                                                  [self setUserInteractionEnabled:YES];
                                              }];
                         }];
        
    } else {
        [self setUserInteractionEnabled:YES];
    }
}


#pragma mark - Animation Methods (Public)

- (void)showMenuItemsAnimated:(BOOL)animated
{
    [self setUpCellOptions];
    
    float animationTime = animated ? kMEVHorizontalContactsDefaultShowAnimationTime : 0;
    float minValue = 0.5;
    float maxValue = 1.02;
    float regValue = 1;
    for (UIView *view in _items) {
        view.alpha = 0;
        view.layer.transform = CATransform3DMakeScale(minValue, minValue, minValue);
        [UIView animateWithDuration:animationTime
                              delay:animationTime * ([_items indexOfObject:view]+1)
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             view.alpha = 0.6;
                             view.layer.transform = CATransform3DScale(CATransform3DIdentity, maxValue, maxValue, maxValue);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:animationTime
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  view.alpha = 1;
                                                  view.layer.transform = CATransform3DScale(CATransform3DIdentity, regValue, regValue, regValue);
                                              } completion:^(BOOL finished) {  }];
                         }];
    }
}

- (void)hideMenuItemsAnimated:(BOOL)animated
{
    int pos = 0;
    float animationTime = animated ? kMEVHorizontalContactsDefaultHideAnimationTime : 0;
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
