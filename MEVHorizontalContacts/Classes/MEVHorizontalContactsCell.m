//
//  MEVHorizontalContactsCell.m
//  People Tracker
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

@property (nonatomic, strong) NSMutableArray *menuOptions;

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
    
    _menuOptions = [NSMutableArray new];
    
    _imageView = [UIImageView new];
    _imageView.opaque = YES;
    _imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - _labelHeight/2);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = [UIColor lightGrayColor];
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
    
    _label = [UILabel new];
    _label.opaque = YES;
    _label.textColor = [UIColor grayColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:12];
    [self addSubview:_label];
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
    NSLog(@"cellSingleTap");
    
    if (self.isSelected) {
        self.selected = NO;
        [self hideMenuOptionsAnimated:NO];
        
    } else {
        self.selected = YES;
        [self showMenuOptionsAnimated:YES];
    }
    
    if ([_delegate respondsToSelector:@selector(cellSelectedAtIndexPath:)])
        [_delegate cellSelectedAtIndexPath:_indexPath];
}

- (void)menuOptionSingleTap:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(menuOptionSelected:atCellIndexPath:)])
        [_delegate menuOptionSelected:sender.tag atCellIndexPath:_indexPath];
}


#pragma mark - Setup Methods (Private)

- (void)setUpCellOptions
{
    [_menuOptions makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_menuOptions removeAllObjects];
    
    int numberOfItems;
    if ([_dataSource respondsToSelector:@selector(numberOfOptionsInCellIndexPath:)]) {
        numberOfItems = [_dataSource numberOfOptionsInCellIndexPath:_indexPath];
    }
    
    float maxWidth = CGRectGetHeight(self.bounds) - _labelHeight;
    int xOffset = maxWidth;
    xOffset += _itemSpacing;
    
    for (int index = 0; index < numberOfItems ; index++) {
        NSLog(@"index = %d", index);

        UIButton *button = [UIButton new];
        button.frame = CGRectMake(xOffset,0, maxWidth, CGRectGetHeight(self.bounds));
        button.tag = index;
        button.opaque = YES;
        button.alpha = .0f;
        button.tintColor = [UIColor colorWithRed:34/255.0f green:167/255.0f blue:240/255.0f alpha:1];
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(menuOptionSingleTap:) forControlEvents:UIControlEventTouchUpInside];
       
        if ([_dataSource respondsToSelector:@selector(option:atContactIndex:)]) {
            MEVHorizontalContactsCell *cell = [_dataSource option:index atContactIndex:_indexPath.row];

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
        
        [_menuOptions addObject:button];
        [self addSubview:button];

        xOffset += (maxWidth + _itemSpacing);
    }
}


#pragma mark - Animation Methods (Public)

- (void)showMenuOptionsAnimated:(BOOL)animated
{
    NSLog(@"showMenuOptionsAnimated = %d", animated);
    
    [self setUpCellOptions];
    
    float animationTime = animated ? kMEVHorizontalContactsDefaultShowAnimationTime : 0.0f;
    for (UIView *view in _menuOptions) {
        view.alpha = 0;
        view.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5);

        [view setUserInteractionEnabled:NO];
        [UIView animateWithDuration:animationTime
                              delay:animationTime * ([_menuOptions indexOfObject:view]+1)
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             view.alpha = 1;
                             view.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1);
                         } completion:^(BOOL finished) {
                             [view setUserInteractionEnabled:YES];
                         }];
    }
}


- (void)hideMenuOptionsAnimated:(BOOL)animated
{
    NSLog(@"hideMenuOptionsAnimated = %d", animated);

    int pos = 0;
    float animationTime = animated ? kMEVHorizontalContactsDefaultHideAnimationTime : 0.0f;
    for (int i = (int)[_menuOptions count]; i > 0 ; i--) {
        UIView *view = [_menuOptions objectAtIndex:i-1];
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
