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
static float const kMEVHorizontalContactsDefaultHideAnimationTime = 0.06f;

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
    _imageView.opaque = YES;
    _imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - _labelHeight/2);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = [UIColor lightGrayColor];
    _imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _label = [UILabel new];
    _label.opaque = YES;
    _label.textColor = [UIColor grayColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_label];
}


#pragma mark - Layout (private)

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float maxWidth = CGRectGetHeight(self.bounds) - _labelHeight;
    _imageView.frame = CGRectMake(0, 0, maxWidth, maxWidth);
    _imageView.layer.cornerRadius = (maxWidth)/2;
    _label.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - _labelHeight, CGRectGetHeight(self.bounds) - _labelHeight, _labelHeight);
}


#pragma mark - UI Actions (private)

- (void)cellSingleTap:(UITapGestureRecognizer *)recognizer
{
    if (self.isSelected) {
        [self setUnselectedAnimated:YES];
        [self hideMenuOptionsAnimated:NO];
        
    } else {
        [self setSelectedAnimated:YES];
        [self showMenuOptionsAnimated:YES];
    }
    
    if ([_delegate respondsToSelector:@selector(cellSelectedAtIndexPath:)])
        [_delegate cellSelectedAtIndexPath:_indexPath];
}

- (void)menuOptionSingleTap:(UIButton *)sender
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
        button.alpha = .0f;
        button.tintColor = [UIColor colorWithRed:34/255.0f green:167/255.0f blue:240/255.0f alpha:1];
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(menuOptionSingleTap:) forControlEvents:UIControlEventTouchUpInside];
       
        if ([_dataSource respondsToSelector:@selector(item:atContactIndex:)]) {
            MEVHorizontalContactsCell *cell = [_dataSource item:index atContactIndex:_indexPath.row];

            UIImage *image = cell.imageView.image;
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, maxWidth)];
            imageView.image = image;
            imageView.opaque = YES;
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.contentMode = UIViewContentModeCenter;
            imageView.layer.cornerRadius = (maxWidth)/2;
            imageView.layer.masksToBounds = YES;
            [button addSubview:imageView];
            
            NSString *textLabel = cell.label.text;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(button.frame) - _labelHeight, CGRectGetWidth(button.frame), _labelHeight)];
            label.opaque = YES;
            //            label.backgroundColor = [UIColor orangeColor];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            label.text = textLabel;
            [button addSubview:label];
        }
        
        [_items addObject:button];
        [self addSubview:button];

        xOffset += (maxWidth + _itemSpacing);
    }
}


#pragma mark - Animation Methods (Public)


- (void)setSelectedAnimated:(BOOL)animated
{
    self.selected = YES;
    [self setUserInteractionEnabled:NO];
    
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
    
}

- (void)setUnselectedAnimated:(BOOL)animated
{
    self.selected = NO;
    [self setUserInteractionEnabled:NO];
    
    float animationTime = animated ? (kMEVHorizontalContactsDefaultShowAnimationTime*2) : 0.0;
    [UIView animateWithDuration:animationTime
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _imageView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.05, 1.05, 1.05);
                         _label.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.05, 1.05, 1.05);
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

}

- (void)showMenuOptionsAnimated:(BOOL)animated
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


- (void)hideMenuOptionsAnimated:(BOOL)animated
{
    int pos = 0;
    float animationTime = animated ? kMEVHorizontalContactsDefaultHideAnimationTime : 0.0f;
    for (int i = (int)[_items count]; i > 0 ; i--) {
        UIView *view = [_items objectAtIndex:i-1];
        [UIView animateWithDuration:animationTime
                              delay:animationTime * pos
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             view.alpha = 0;
                         } completion:^(BOOL finished) {
                             [view removeFromSuperview];
                         }];
        pos++;
    }
}

@end
