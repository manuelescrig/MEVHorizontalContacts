//
//  MEVHorizontalContacts.m
//  An iOS UICollectionViewLayout subclass to show a list of contacts with configurable expandable items.
//
//  https://github.com/manuelescrig/MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 24/02/16.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//  Licence: MIT-Licence
//

#import "MEVHorizontalContacts.h"

static float const kMEVHorizontalContactsDefaultLabelHeight = 30.0f;
static float const kMEVHorizontalContactsDefaultSpacing = 5.0f;

static NSString *const kMEVHorizontalContactsContactCell = @"contactCell";
static NSString *const kMEVHorizontalContactsItemCell = @"itemCell";

@interface MEVHorizontalContacts()  <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MEVHorizontalContactsCellDelegate, MEVHorizontalContactsCellDataSource, MEVHorizontalContactsLayoutDataSource>

@property (nonatomic, strong) UICollectionView *horizontalContactListView;
@property (nonatomic, strong) MEVHorizontalContactsLayout *layout;
@property (nonatomic, assign) NSInteger selectedIndex;

@end


@implementation MEVHorizontalContacts

#pragma mark - View Life Cycle (private)

- (id)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setOpaque:YES];
    [self setBackgroundColor:[self mev_horizontalContactsBackgroundColor]];
    
    _selectedIndex = -1;
    
    // Contact List
    _layout = [[MEVHorizontalContactsLayout alloc] init];
    _layout.dataSource = self;
    _horizontalContactListView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:_layout];
    [_horizontalContactListView registerClass:[MEVHorizontalContactsCell class] forCellWithReuseIdentifier:kMEVHorizontalContactsContactCell];
    [_horizontalContactListView registerClass:[MEVHorizontalContactsCell class] forCellWithReuseIdentifier:kMEVHorizontalContactsItemCell];
    [_horizontalContactListView setDataSource:self];
    [_horizontalContactListView setDelegate:self];
    [_horizontalContactListView setOpaque:YES];
    [_horizontalContactListView setBackgroundColor:self.backgroundColor];
    [_horizontalContactListView setAlwaysBounceHorizontal:YES];
    [_horizontalContactListView setShowsVerticalScrollIndicator:NO];
    [_horizontalContactListView setShowsHorizontalScrollIndicator:NO];
    [_horizontalContactListView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_horizontalContactListView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"horizontalContactsView" : _horizontalContactListView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"horizontalContactsView" : _horizontalContactListView}]];
}


#pragma mark - Layout (private)

- (void)layoutSubviews
{    
    _layout.itemSpacing = [self mev_horizontalContactsSpacing];
    _layout.insets = [self mev_horizontalContactsInsets];
    _layout.labelHeight = [self mev_horizontalContactsLabelHeight];
    _layout.itemHeight = [self mev_horizontalContactsItemHeight];
}


#pragma mark - UICollectionView Datasource (private)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self mev_horizontalContactsNumberOfContacts];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEVHorizontalContactsCell *cell = [self mev_horizontalContactsContactAtIndex:indexPath.row];
    cell.backgroundColor = [self mev_horizontalContactsBackgroundColor];
    cell.labelHeight = [self mev_horizontalContactsLabelHeight];;
    cell.itemSpacing = [self mev_horizontalContactsSpacing];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.dataSource = self;

    if (indexPath.row == _selectedIndex) {
        cell.selected = YES;
        [cell showMenuOptionsAnimated:NO];
    } else {
        cell.selected = NO;
        [cell hideMenuOptionsAnimated:NO];
    }
    return cell;
}


#pragma mark - ReusableCells Methods (public)

- (MEVHorizontalContactsCell *)dequeueReusableContactCellForIndex:(NSInteger)index
{
   return [_horizontalContactListView dequeueReusableCellWithReuseIdentifier:kMEVHorizontalContactsContactCell forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (MEVHorizontalContactsCell *)dequeueReusableItemCellForIndex:(NSInteger)index
{
    return [_horizontalContactListView dequeueReusableCellWithReuseIdentifier:kMEVHorizontalContactsItemCell forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

//TODO:Add asserts
#pragma mark - Getters (private)

- (UIColor *)mev_horizontalContactsBackgroundColor
{
    return [UIColor groupTableViewBackgroundColor];
}

- (CGFloat)mev_horizontalContactsItemHeight
{
    return CGRectGetHeight(self.frame) - _layout.insets.top - _layout.insets.bottom;
}

- (CGFloat)mev_horizontalContactsLabelHeight
{
    return kMEVHorizontalContactsDefaultLabelHeight;
}

- (CGFloat)mev_horizontalContactsSpacing
{
    if ([_dataSource respondsToSelector:@selector(horizontalContactsSpacing)]) {
        return [_dataSource horizontalContactsSpacing];
    } else {
        return kMEVHorizontalContactsDefaultSpacing;
    }
}

- (UIEdgeInsets)mev_horizontalContactsInsets
{
    if ([_dataSource respondsToSelector:@selector(horizontalContactsInsets)]) {
        return [_dataSource horizontalContactsInsets];
    } else {
        return UIEdgeInsetsZero;
    }
}

- (NSInteger)mev_horizontalContactsNumberOfContacts
{
    NSInteger number;
    if ([_dataSource respondsToSelector:@selector(numberOfContacts)]) {
        number = [_dataSource numberOfContacts];
    }
    NSAssert(number >= 0, @"You must assign a valid number.");
    return number;
}

- (MEVHorizontalContactsCell *)mev_horizontalContactsContactAtIndex:(NSInteger)index
{
    if ([_dataSource respondsToSelector:@selector(contactAtIndex:)]) {
        return [_dataSource contactAtIndex:index];
    } else {
        return nil;
    }
}

- (NSInteger)mev_horizontalContactsNumberOfItemsAtIndex:(NSInteger)index
{
    if ([_dataSource respondsToSelector:@selector(numberOfItemsAtContactIndex:)]) {
        return [_dataSource numberOfItemsAtContactIndex:index];
    } else {
        return 0;
    }
}

- (MEVHorizontalContactsCell *)mev_horizontalContactsItem:(NSInteger)item atContactAtIndex:(NSInteger)index
{
    if ([_dataSource respondsToSelector:@selector(item:atContactIndex:)]) {
        return [_dataSource item:item atContactIndex:index];
    } else {
        return nil;
    }
}


#pragma mark – MEVHorizontalContactsLayoutDataSource
#pragma mark – MEVHorizontalContactsCellDataSource 

- (NSInteger)numberOfItemsInCellIndexPath:(NSIndexPath *)indexPath
{
    return [self mev_horizontalContactsNumberOfItemsAtIndex:indexPath.row];
}


#pragma mark – MEVHorizontalContactsCellDataSource

- (MEVHorizontalContactsCell *)item:(NSInteger)item atContactIndex:(NSInteger)index
{
    return [self mev_horizontalContactsItem:item atContactAtIndex:index];
}


#pragma mark – MEVHorizontalContactListCellDelegate

- (void)cellSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedIndex >= 0 && _selectedIndex != indexPath.row) {
        MEVHorizontalContactsCell *cell = [_horizontalContactListView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
        cell.selected = NO;
        [cell hideMenuOptionsAnimated:NO];
    }
    
    if (_selectedIndex != indexPath.row) {
        [_horizontalContactListView setContentOffset:CGPointMake(indexPath.row  * (_layout.itemHeight -_layout.labelHeight  + _layout.itemSpacing), 0) animated:YES];
        [UIView performWithoutAnimation:^{
            _horizontalContactListView.layer.speed = 1.0;
            [_horizontalContactListView performBatchUpdates:^{ } completion:^(BOOL finished) { }];
        }];

    } else {
        _horizontalContactListView.layer.speed = 2.0;
        [_horizontalContactListView performBatchUpdates:^{ } completion:^(BOOL finished) { }];
    }
    
    // Select new cell, in case of deselecting then set -1 as default value
    _selectedIndex = _selectedIndex == indexPath.row ? -1 : indexPath.row;
    
    if ([_delegate respondsToSelector:@selector(contactSelectedAtIndex:)]) {
        return [_delegate contactSelectedAtIndex:indexPath.row];
    }
}

- (void)itemSelected:(NSInteger)option atCellIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(item:selectedAtContactIndex:)]) {
        return [_delegate item:option selectedAtContactIndex:indexPath.row];
    }
}

@end
