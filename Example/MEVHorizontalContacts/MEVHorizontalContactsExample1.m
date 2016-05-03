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
        [contact setName:[self getRandomUserName]];
        [contact setImage:[UIImage imageNamed:[self getRandomImageName]]];
        [contacts addObject:contact];
    }
    _contacts = [contacts copy];
    
    // Contact List
    MEVHorizontalContactsFlowLayout *layout = [[MEVHorizontalContactsFlowLayout alloc] init];
    _horizontalContactListView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:layout];
    [_horizontalContactListView registerClass:[MEVHorizontalContactsCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_horizontalContactListView setDataSource:self];
    [_horizontalContactListView setDelegate:self];
    [_horizontalContactListView setContentInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_horizontalContactListView setBackgroundColor:[UIColor colorWithRed:170/255.0f green:178/255.0f blue:189/255.0f alpha:1.0f]];
    _horizontalContactListView.alwaysBounceHorizontal = YES;
    _horizontalContactListView.showsVerticalScrollIndicator = NO;
    _horizontalContactListView.showsHorizontalScrollIndicator = NO;
    _horizontalContactListView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_horizontalContactListView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"horizontalContactsView" : _horizontalContactListView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"horizontalContactsView" : _horizontalContactListView}]];
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_contacts count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEVHorizontalContactsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.cellIndexPath = indexPath;
    cell.cellDelegate = self;
    cell.cellDataSource = self;
    [cell.imageView.layer setBorderWidth:2.f];
    [cell.imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [cell.label setTextColor:[UIColor whiteColor]];
    [cell.label setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:16]];
    
    MEVHorizontalContactsModel *contact = [_contacts objectAtIndex:indexPath.row];
    [cell setContactModel:contact];
    if ([contact isExpanded] == NO) {
        [cell hideMenuOptions];
    } else {
        [cell showMenuOptions];
    }
    return cell;
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
    MEVHorizontalContactsModel *contact = [_contacts objectAtIndex:indexPath.row];
    if ([contact isExpanded]) {
        return CGSizeMake(120 + 300, 120);
    } else {
        return CGSizeMake(120, 120);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark – MEVHorizontalContactsCellDataSource Methods

- (NSInteger)numberOfItemsInCellIndexPath:(NSIndexPath *)indexPath
{
    return 4;
}

- (UIImage *)imageForItemAtIndex:(NSInteger)index inCellIndexPath:(NSIndexPath *)indexPath
{
    switch (index) {
        case 0:
            return [UIImage imageNamed:@"actionCall"];
            break;
        case 1:
            return [UIImage imageNamed:@"actionEmail"];
            break;
        case 2:
            return [UIImage imageNamed:@"actionMessage"];
            break;
        default:
            return [UIImage imageNamed:@"actionCall"];
            break;
    }
}

- (NSString *)textForItemAtIndex:(NSInteger)index inCellIndexPath:(NSIndexPath *)indexPath
{
    switch (index) {
        case 0:
            return @"Call";
            break;
        case 1:
            return @"Email";
            break;
        case 2:
            return @"Message";
            break;
        default:
            return @"Call";
            break;
    }
}


#pragma mark – MEVHorizontalContactsCellDelegate Methods

- (void)closeAllContacts
{
    NSLog(@"closeAllContacts");
    
    for (int i = 0; i < [_contacts count]; i++) {
        MEVHorizontalContactsModel *contact = [_contacts objectAtIndex:i];
        [contact setExpanded:NO];
        MEVHorizontalContactsCell *cell = (MEVHorizontalContactsCell *)[_horizontalContactListView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell hideMenuOptions];
    }
    [_horizontalContactListView invalidateIntrinsicContentSize];
    [_horizontalContactListView performBatchUpdates:nil completion:nil];
}

- (void)cellSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellSelected");
    
    [_horizontalContactListView invalidateIntrinsicContentSize];
    MEVHorizontalContactsCell *cell = (MEVHorizontalContactsCell *)[_horizontalContactListView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    
    if ([[_contacts objectAtIndex:indexPath.row] isExpanded]) {
        [cell hideMenuOptions];
        [[_contacts objectAtIndex:indexPath.row] setExpanded:NO];
        
        [_horizontalContactListView performBatchUpdates:nil completion:nil];
        [_horizontalContactListView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    } else {
        [self closeAllContacts];
        
        [[_contacts objectAtIndex:indexPath.row] setExpanded:YES];
        [cell showMenuOptions];
        
        [_horizontalContactListView performBatchUpdates:nil completion:nil];
        [_horizontalContactListView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (void)menuOptionSelected:(NSInteger)option atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row = %zu",indexPath.row);
    NSLog(@"option = %zi",option);
}


#pragma mark - Generate Data Methods

- (NSString *)getRandomUserName
{
    NSLog(@"getRandomUserName");
    NSArray *array = @[@"James Neil", @"Mary", @"Robert", @"Patricia David", @"David", @"Linda", @"Charles", @"Barbara", @"John", @"Paul"];
    return [array objectAtIndex: arc4random() % [array count]];
}

- (NSString *)getRandomImageName
{
    NSLog(@"getRandomImageName");
    NSArray *array = @[@"image1", @"image2", @"image3", @"image4", @"image5", @"image6", @"image7", @"image8", @"image9", @"image10"];
    return [array objectAtIndex: arc4random() % [array count]];
}

@end
