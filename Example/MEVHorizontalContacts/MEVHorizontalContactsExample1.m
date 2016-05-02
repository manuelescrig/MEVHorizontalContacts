//
//  MEVHorizontalContactsExample1.m
//  MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 02/05/16.
//  Copyright © 2016 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVHorizontalContactsExample1.h"

@interface MEVHorizontalContactsExample1()

@property (nonatomic, strong) UICollectionView *horizontalContactListView;
@property (nonatomic, strong) NSArray *contacts;

@end

@implementation MEVHorizontalContactsExample1


#pragma mark - View Life Cycle


- (void)loadView
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self setAlpha:1];
    [self setOpaque:YES];
    
    // Data
    NSMutableArray *contacts = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        MEVHorizontalContactsModel *contact =  [MEVHorizontalContactsModel new];
        [contact setId:@"1"];
        [contact setName:@"Manuel"];
        [contact setImage:nil];
        [contacts addObject:contact];
    }
    _contacts = [contacts copy];
    
    // Contact List
    MEVHorizontalContactsFlowLayout *layout = [[MEVHorizontalContactsFlowLayout alloc] init];
    _horizontalContactListView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:layout];
    [_horizontalContactListView registerClass:[MEVHorizontalContactsCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_horizontalContactListView registerClass:[MEVHorizontalContactsAddContactView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"addContactView"];
    [_horizontalContactListView setDataSource:self];
    [_horizontalContactListView setDelegate:self];
    [_horizontalContactListView setBackgroundColor:[UIColor clearColor]];
    [_horizontalContactListView setContentInset:UIEdgeInsetsMake(5, 10, 0, 14)];
    _horizontalContactListView.alwaysBounceHorizontal = YES;
    _horizontalContactListView.showsVerticalScrollIndicator = NO;
    _horizontalContactListView.showsHorizontalScrollIndicator = NO;
    _horizontalContactListView.translatesAutoresizingMaskIntoConstraints = NO;
    [_horizontalContactListView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self addSubview:_horizontalContactListView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"horizontalContactsView" : _horizontalContactListView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"horizontalContactsView" : _horizontalContactListView}]];
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_contacts count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEVHorizontalContactsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.cellDelegate = self;
    cell.tag = indexPath.row;
    
    MEVHorizontalContactsModel *contact = [_contacts objectAtIndex:indexPath.row];
    [cell setContactModel:contact];
    
    if ([contact isExpanded] == NO) {
        [cell hideMenuViews];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionFooter) {
        MEVHorizontalContactsAddContactView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"addContactView" forIndexPath:indexPath];
        footerview.buttonDelegate = self;
        reusableview = footerview;
    }
    
    return reusableview;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectItemAtIndexPath");
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didDeselectItemAtIndexPath");
    
}


#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sizeForItemAtIndexPath _contacts = %@", _contacts);
    MEVHorizontalContactsModel *contact = [_contacts objectAtIndex:indexPath.row];
    return [contact getSize];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return [MEVHorizontalContactsAddContactView defaultSize];
    }
    
    return CGSizeZero;
}


#pragma mark – MEVHorizontalContactListCellDelegate

- (void)closeAllContacts
{
    NSLog(@"closeAllContacts");
    
    for (int i = 0; i < [_contacts count]; i++) {
        MEVHorizontalContactsModel *contact = [_contacts objectAtIndex:i];
        [contact setExpanded:NO];
        MEVHorizontalContactsCell *cell = (MEVHorizontalContactsCell *)[_horizontalContactListView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell hideMenuViews];
    }
    [_horizontalContactListView invalidateIntrinsicContentSize];
    [_horizontalContactListView performBatchUpdates:nil completion:nil];
}

- (void)cellSelected:(NSInteger)index
{
    NSLog(@"cellSelected");
    
    [_horizontalContactListView invalidateIntrinsicContentSize];
    MEVHorizontalContactsCell *cell = (MEVHorizontalContactsCell *)[_horizontalContactListView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    if ([[_contacts objectAtIndex:index] isExpanded]) {
        [cell hideMenuViews];
        [[_contacts objectAtIndex:index] setExpanded:NO];
        
        [_horizontalContactListView performBatchUpdates:nil completion:nil];
        [_horizontalContactListView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    } else {
        [self closeAllContacts];
        
        [[_contacts objectAtIndex:index] setExpanded:YES];
        [cell setUpCellOptions];
        
        [_horizontalContactListView performBatchUpdates:nil completion:nil];
        [_horizontalContactListView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (void)menuSelectedOption:(NSInteger)option atIndex:(NSInteger)index
{
    NSLog(@"index = %zu",index);
    NSLog(@"option = %zi",option);
    
}

- (void)buttonDidTap:(UIButton *)button
{
    NSLog(@"button = %@",button);
    
    // Close Contacts
    [self closeAllContacts];
    
}


@end
