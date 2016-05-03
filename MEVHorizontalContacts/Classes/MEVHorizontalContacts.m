//
//  MEVHorizontalContactsModel.m
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 24/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVHorizontalContacts.h"

@interface MEVHorizontalContacts()

@property (nonatomic, strong) UICollectionView *horizontalContactListView;
@property (nonatomic, strong) MEVHorizontalContactsLayout *layout;

@end

@implementation MEVHorizontalContacts


#pragma mark - View Life Cycle

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
    [self setAlpha:1];
    [self setOpaque:YES];
    
    // Contact List
    _layout = [[MEVHorizontalContactsLayout alloc] init];
    _horizontalContactListView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:_layout];
    [_horizontalContactListView registerClass:[MEVHorizontalContactsCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_horizontalContactListView setDataSource:self];
    [_horizontalContactListView setDelegate:self];
    [_horizontalContactListView setBackgroundColor:[UIColor colorWithRed:204/255.0f green:209/255.0f blue:217/255.0f alpha:1.0f]];
    [_horizontalContactListView setAlwaysBounceHorizontal:YES];
    [_horizontalContactListView setShowsVerticalScrollIndicator:NO];
    [_horizontalContactListView setShowsHorizontalScrollIndicator:NO];
    [_horizontalContactListView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_horizontalContactListView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"horizontalContactsView" : _horizontalContactListView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"horizontalContactsView" : _horizontalContactListView}]];
}


#pragma mark - Layout

- (void)layoutSubviews
{
    if ([_dataSource respondsToSelector:@selector(horizontalContactsItemSpacing)]) {
        _layout.itemSpacing =  [_dataSource horizontalContactsItemSpacing];
    }

    UIEdgeInsets insets;
    if ([_dataSource respondsToSelector:@selector(horizontalContactsInsets)]) {
        insets =  [_dataSource horizontalContactsInsets];
    }
    
    _layout.insets = insets;
    _layout.itemHeight = CGRectGetHeight(self.frame) - insets.top - insets.bottom;
    _layout.itemWidth = _layout.itemHeight - kHorizontalContactsLabelHeight;
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_dataSource respondsToSelector:@selector(numberOfContacts)]) {
        return [_dataSource numberOfContacts];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEVHorizontalContactsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.labelHeight = 30;
    cell.itemSpacing = 5;
    cell.cellIndexPath = indexPath;
    cell.cellDelegate = self;
    cell.cellDataSource = self;

    
    MEVHorizontalContactsModel *contact;
    if ([_dataSource respondsToSelector:@selector(contactAtIndex:)]) {
        contact = [_dataSource contactAtIndex:indexPath.row];
        [cell.imageView setImage:[contact image]];
        [cell.label setText:[contact getName]];
    }

    //    if ([contact isExpanded] == NO) {
    //        [cell hideMenuOptions];
    //    } else {
    //        [cell showMenuOptions];
    //    }
    return cell;
}


#pragma mark – MEVHorizontalContactsCellDataSource Methods

- (NSInteger)numberOfItemsInCellIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataSource respondsToSelector:@selector(numberOfItemsAtIndex:)]) {
        return [_dataSource numberOfItemsAtIndex:indexPath.row];
    }
    return 0;
}

- (NSString *)textForItemAtIndex:(NSInteger)index atCellIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataSource respondsToSelector:@selector(textForItem:atIndex:)]) {
        return [_dataSource textForItem:index atIndex:indexPath.row];
    }
    return @"";
}

- (UIImage *)imageForItemAtIndex:(NSInteger)index atCellIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataSource respondsToSelector:@selector(imageForItem:atIndex:)]) {
        return [_dataSource imageForItem:index atIndex:indexPath.row];
    }
    return nil;
}

- (CGFloat)heightForLabel
{
    30;
}

- (CGFloat)itemSpacing
{
    5;
}


#pragma mark – MEVHorizontalContactListCellDelegate


- (void)cellSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    [_horizontalContactListView performBatchUpdates:nil completion:nil];
    //    MEVHorizontalContactsCell *cell = (MEVHorizontalContactsCell *)[_horizontalContactListView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    //    if (cell.isSelected) {
    //        [_horizontalContactListView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    //    } else {
    //        [_horizontalContactListView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    //    }
    
    if ([_delegate respondsToSelector:@selector(contactSelectedAtIndex:)]) {
        return [_delegate contactSelectedAtIndex:indexPath.row];
    }
}

- (void)menuOptionSelected:(NSInteger)option atCellIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(item:selectedAtIndex:)]) {
        return [_delegate item:option selectedAtIndex:indexPath.row];
    }
}

@end
