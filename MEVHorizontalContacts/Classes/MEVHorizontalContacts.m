//
//  MEVHorizontalContactsModel.m
//  People Tracker
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
static NSString *const kMEVHorizontalContactsOptionCell = @"optionCell";

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
    
    _selectedIndex = -1;
    
    // Contact List
    _layout = [[MEVHorizontalContactsLayout alloc] init];
    _layout.dataSource = self;
    _horizontalContactListView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:_layout];
    [_horizontalContactListView registerClass:[MEVHorizontalContactsCell class] forCellWithReuseIdentifier:kMEVHorizontalContactsContactCell];
    [_horizontalContactListView registerClass:[MEVHorizontalContactsCell class] forCellWithReuseIdentifier:kMEVHorizontalContactsOptionCell];
    [_horizontalContactListView setDataSource:self];
    [_horizontalContactListView setDelegate:self];
    [_horizontalContactListView setOpaque:YES];
    [_horizontalContactListView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
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
    _layout.itemSpacing = [self mev_contactsSpacing];
    _layout.insets = [self mev_contactsInsets];
    _layout.labelHeight = [self mev_contactsLabelHeight];
    _layout.itemHeight = CGRectGetHeight(self.frame) - _layout.insets.top - _layout.insets.bottom;
}


#pragma mark - UICollectionView Datasource (private)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self mev_numberOfContacts];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForItemAtIndexPath - row %zu", indexPath.row);
    MEVHorizontalContactsCell *cell = [self mev_contactAtIndex:indexPath.row];
    cell.labelHeight = [self mev_contactsLabelHeight];;
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.dataSource = self;
    cell.itemSpacing = [self mev_contactsSpacing];
    
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

- (MEVHorizontalContactsCell *)dequeueReusableOptionCellForIndex:(NSInteger)index
{
    return [_horizontalContactListView dequeueReusableCellWithReuseIdentifier:kMEVHorizontalContactsOptionCell forIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

//TODO:Add asserts
#pragma mark - Getters (private)

- (CGFloat)mev_contactsLabelHeight
{
    return kMEVHorizontalContactsDefaultLabelHeight;
}

- (CGFloat)mev_contactsSpacing
{
    if ([_dataSource respondsToSelector:@selector(horizontalContactsSpacing)]) {
        return [_dataSource horizontalContactsSpacing];
    } else {
        return kMEVHorizontalContactsDefaultSpacing;
    }
}

- (UIEdgeInsets)mev_contactsInsets
{
    if ([_dataSource respondsToSelector:@selector(horizontalContactsInsets)]) {
        return [_dataSource horizontalContactsInsets];
    } else {
        return UIEdgeInsetsZero;
    }
}

- (NSInteger)mev_numberOfContacts
{
    if ([_dataSource respondsToSelector:@selector(numberOfContacts)]) {
        return [_dataSource numberOfContacts];
    } else {
        return 0;
    }
}

- (MEVHorizontalContactsCell *)mev_contactAtIndex:(NSInteger)index
{
    if ([_dataSource respondsToSelector:@selector(contactAtIndex:)]) {
        return [_dataSource contactAtIndex:index];
    } else {
        return nil;
    }
}

- (NSInteger)mev_numberOfOptionsAtIndex:(NSInteger)index
{
    if ([_dataSource respondsToSelector:@selector(numberOfOptionsAtContactIndex:)]) {
        return [_dataSource numberOfOptionsAtContactIndex:index];
    } else {
        return 0;
    }
}

- (MEVHorizontalContactsCell *)mev_option:(NSInteger)option atContactAtIndex:(NSInteger)index
{
    if ([_dataSource respondsToSelector:@selector(option:atContactIndex:)]) {
        return [_dataSource option:option atContactIndex:index];
    } else {
        return nil;
    }
}


#pragma mark – MEVHorizontalContactsLayoutDataSource
#pragma mark – MEVHorizontalContactsCellDataSource 

- (NSInteger)numberOfOptionsInCellIndexPath:(NSIndexPath *)indexPath
{
    return [self mev_numberOfOptionsAtIndex:indexPath.row];
}


#pragma mark – MEVHorizontalContactsCellDataSource

- (MEVHorizontalContactsCell *)option:(NSInteger)option atContactIndex:(NSInteger)index
{
    return [self mev_option:option atContactAtIndex:option];
}


#pragma mark – MEVHorizontalContactListCellDelegate

- (void)cellSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellSelectedAtIndexPath");
    
    if (_selectedIndex >= 0 && _selectedIndex != indexPath.row) {
        MEVHorizontalContactsCell *cell = [_horizontalContactListView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
        cell.selected = NO;
        [cell hideMenuOptionsAnimated:YES];
    }
    
    int itemsInScreen = _horizontalContactListView.frame.size.width / (_layout.itemHeight - [self mev_contactsLabelHeight]) ;
    
    NSLog(@"cellSelectedAtIndexPath - itemsInScreen = %d", itemsInScreen);
    
    if (_selectedIndex != indexPath.row) {
//        _horizontalContactListView.scrollEnabled = NO;
//        [_horizontalContactListView setContentOffset:CGPointMake(indexPath.row  * (_layout.itemHeight -_layout.labelHeight  + _layout.itemSpacing), 0) animated:YES];
        
   } else {
        _horizontalContactListView.scrollEnabled = YES;
    }
    
    // Select new cell, in case of deselecting then set -1 as default value
    _selectedIndex = _selectedIndex == indexPath.row ? -1 : indexPath.row;

    [_horizontalContactListView performBatchUpdates:^{ } completion:^(BOOL finished) { }];
    [_horizontalContactListView invalidateIntrinsicContentSize];
    
    if ([_delegate respondsToSelector:@selector(contactSelectedAtIndex:)]) {
        return [_delegate contactSelectedAtIndex:indexPath.row];
    }
}

- (void)menuOptionSelected:(NSInteger)option atCellIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(option:selectedAtContactIndex:)]) {
        return [_delegate option:option selectedAtContactIndex:indexPath.row];
    }
}

@end
