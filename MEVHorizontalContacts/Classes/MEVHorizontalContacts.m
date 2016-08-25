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

@property (nonatomic, strong) MEVHorizontalContactsLayout *layout;
@property (nonatomic, strong) UICollectionView *horizontalContactListView;
@property (nonatomic, assign) NSInteger selectedIndex;

@end


@implementation MEVHorizontalContacts

#pragma mark - View Life Cycle (private)

- (id)init
{
    self = [super init];
    if (self) {
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
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    // Default View Background Color
    [self setBackgroundColor:[UIColor whiteColor]];

    // Default Configuration
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

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
    [_horizontalContactListView setAlpha:1.0f];
    [_horizontalContactListView setBackgroundColor:[UIColor clearColor]];
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
    [super layoutSubviews];

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
    cell.labelHeight = [self mev_horizontalContactsLabelHeight];;
    cell.itemSpacing = [self mev_horizontalContactsSpacing];
    cell.animationMode = [self mev_horizontalContactsAnimationMode];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.dataSource = self;

    if (indexPath.row == _selectedIndex) {
        cell.selected = YES;
        [cell showMenuItemsAnimated:NO];
    } else {
        cell.selected = NO;
        [cell hideMenuItemsAnimated:NO];
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

- (void)reloadData
{
    _selectedIndex = -1;

    [_horizontalContactListView reloadData];
}


#pragma mark - Setters (Public)

- (void)setDataSource:(id<MEVHorizontalContactsDataSource>)dataSource
{
    if ([dataSource conformsToProtocol:@protocol(MEVHorizontalContactsDataSource)]) {
        _dataSource = dataSource;
    } else {
        NSAssert(NO, @"You must assign a valid MEVHorizontalContactsDataSource type for -setDataSource:");
    }
}

- (void)setDelegate:(id<MEVHorizontalContactsDelegate>)delegate
{
    if ([delegate conformsToProtocol:@protocol(MEVHorizontalContactsDelegate)]) {
        _delegate = delegate;
    } else {
        NSAssert(NO, @"You must assign a valid MEVHorizontalContactsDelegate type for -setDelegate:");
    }
}

- (void)setAnimationMode:(MEVHorizontalsAnimationMode)animationMode
{
    if (animationMode == MEVHorizontalsAnimationNone ||
        animationMode == MEVHorizontalsAnimationBounce) {
        _animationMode = animationMode;
    } else {
        NSAssert(NO, @"You must assign a valid MEVHorizontalsAnimationMode type for -setAnimationMode:");
    }
}


#pragma mark - Getters (private)

- (MEVHorizontalsAnimationMode)mev_horizontalContactsAnimationMode
{
    if (_animationMode) {
        return _animationMode;
    } else {
        // Default value when not assigend
        _animationMode = MEVHorizontalsAnimationBounce;
        return _animationMode;
    }
}

- (BOOL)mev_horizontalContactsContractWhenItemSelected
{
    return _contractCellWhenItemSelected;
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
    if ([_dataSource respondsToSelector:@selector(numberOfContacts)]) {
        return [_dataSource numberOfContacts];
    } else {
        NSAssert([_dataSource respondsToSelector:@selector(numberOfContacts)], @"'numberOfContacts' Not implemented");
        return 0;
    }
}

- (MEVHorizontalContactsCell *)mev_horizontalContactsContactAtIndex:(NSInteger)index
{
    if ([_dataSource respondsToSelector:@selector(contactAtIndex:)]) {
        return [_dataSource contactAtIndex:index];
    } else {
        NSAssert([_dataSource respondsToSelector:@selector(contactAtIndex:)], @"'contactAtIndex:' Not implemented");
        return nil;
    }
}

- (NSInteger)mev_horizontalContactsNumberOfItemsAtIndex:(NSInteger)index
{
    if ([_dataSource respondsToSelector:@selector(numberOfItemsAtContactIndex:)]) {
        return [_dataSource numberOfItemsAtContactIndex:index];
    } else {
        NSAssert([_dataSource respondsToSelector:@selector(numberOfItemsAtContactIndex:)], @"'numberOfItemsAtContactIndex:' Not implemented");
        return 0;
    }
}

- (MEVHorizontalContactsCell *)mev_horizontalContactsItem:(NSInteger)item atContactAtIndex:(NSInteger)index
{
    if ([_dataSource respondsToSelector:@selector(item:atContactIndex:)]) {
        return [_dataSource item:item atContactIndex:index];
    } else {
        NSAssert([_dataSource respondsToSelector:@selector(item:atContactIndex:)], @"'item:atContactIndex:' Not implemented");
        return nil;
    }
}


#pragma mark – Animations (private)

- (void)expandCellAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self mev_horizontalContactsAnimationMode] == MEVHorizontalsAnimationNone) {
        [_horizontalContactListView setContentOffset:CGPointMake(indexPath.row  * (_layout.itemHeight -_layout.labelHeight  + _layout.itemSpacing), 0) animated:NO];
    } else {
        [_horizontalContactListView setContentOffset:CGPointMake(indexPath.row  * (_layout.itemHeight -_layout.labelHeight  + _layout.itemSpacing), 0) animated:YES];
    }
    [UIView performWithoutAnimation:^{
        _horizontalContactListView.layer.speed = 1.0;
        [_horizontalContactListView performBatchUpdates:^{ } completion:^(BOOL finished) { }];
    }];
}

- (void)contractCell
{
    if ([self mev_horizontalContactsAnimationMode] == MEVHorizontalsAnimationNone) {
        [UIView performWithoutAnimation:^{
            _horizontalContactListView.layer.speed = 2.0;
            [_horizontalContactListView performBatchUpdates:^{ } completion:^(BOOL finished) { }];
        }];
    } else {
        _horizontalContactListView.layer.speed = 2.0;
        [_horizontalContactListView performBatchUpdates:^{ } completion:^(BOOL finished) { }];
    }
}


#pragma mark – MEVHorizontalContactsLayoutDataSource (private)
#pragma mark – MEVHorizontalContactsCellDataSource (private)

- (NSInteger)numberOfItemsInCellIndexPath:(NSIndexPath *)indexPath
{
    return [self mev_horizontalContactsNumberOfItemsAtIndex:indexPath.row];
}


#pragma mark – MEVHorizontalContactsCellDataSource (private)

- (MEVHorizontalContactsCell *)item:(NSInteger)item atContactIndex:(NSInteger)index
{
    return [self mev_horizontalContactsItem:item atContactAtIndex:index];
}


#pragma mark – MEVHorizontalContactListCellDelegate (private)

- (void)cellSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedIndex >= 0 && _selectedIndex != indexPath.row) {
        MEVHorizontalContactsCell *cell = (MEVHorizontalContactsCell *)[_horizontalContactListView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
        cell.selected = NO;
        [cell hideMenuItemsAnimated:YES];
    }

    if (_selectedIndex != indexPath.row) {
        [self expandCellAtIndexPath:indexPath];
    } else {
        [self contractCell];
    }

    // Select new cell, in case of deselecting then set -1 as default value
    _selectedIndex = _selectedIndex == indexPath.row ? -1 : indexPath.row;

    if ([_delegate respondsToSelector:@selector(contactSelectedAtIndex:)]) {
        return [_delegate contactSelectedAtIndex:indexPath.row];
    }
}

- (void)itemSelected:(NSInteger)option atCellIndexPath:(NSIndexPath *)indexPath
{
    if ([self mev_horizontalContactsContractWhenItemSelected]) {
        MEVHorizontalContactsCell *cell = (MEVHorizontalContactsCell *)[_horizontalContactListView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
        cell.selected = NO;
        [cell hideMenuItemsAnimated:YES];
        [self contractCell];

        // Select new cell, in case of deselecting then set -1 as default value
        _selectedIndex = _selectedIndex == indexPath.row ? -1 : indexPath.row;
    }

    if ([_delegate respondsToSelector:@selector(item:selectedAtContactIndex:)]) {
        return [_delegate item:option selectedAtContactIndex:indexPath.row];
    }
}

@end
