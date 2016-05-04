//
//  MEHorizontalContactListFlowLayout.m
//  People Tracker
//
//  https://github.com/manuelescrig/MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 24/02/16.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//  Licence: MIT-Licence
//

#import "MEVHorizontalContactsLayout.h"

#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))

@interface MEVHorizontalContactsLayout()
{
    NSMutableDictionary *_layoutAttributes;
    CGSize _contentSize;
}

@end

@implementation MEVHorizontalContactsLayout


#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
//    self.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
//    self.itemSize = CGSizeMake(125.0f, 125.0f);
//    self.interItemSpacingY = 12.0f;
//    self.numberOfColumns = 2;
}


#pragma mark - Layout

- (void)prepareLayout
{
    NSLog(@"prepareLayout");
    
    [super prepareLayout];
    
    _layoutAttributes = [NSMutableDictionary dictionary];
    
   
    NSUInteger numberOfSections = [self.collectionView numberOfSections];

    CGFloat yOffset = _insets.top;
    CGFloat xOffset = _insets.left;
    
    for (int section = 0; section < numberOfSections; section++)
    {
        NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        
        // Section double spacing
        xOffset += _itemSpacing;

        for (int item = 0; item < numberOfItems; item++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath]; 
            
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            NSLog(@"prepareLayout - cell.isSelected = %d", cell.isSelected);

            NSInteger items = 0;
            if([_dataSource respondsToSelector:@selector(numberOfItemsInCellIndexPath:)]) {
                items = [_dataSource numberOfItemsInCellIndexPath:indexPath];
            }
            NSLog(@"prepareLayout - items = %zu", items);
            NSLog(@"prepareLayout - _itemHeight = %f", _itemHeight);
            NSLog(@"prepareLayout - _itemSpacing = %f", _itemSpacing);

            CGSize itemSize = CGSizeZero;
            itemSize.height = _itemHeight;
            itemSize.width = _itemHeight - _labelHeight;
            if (cell.isSelected) {
                itemSize.width += (itemSize.width + _itemSpacing) * (items);
            }
            
            attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
            NSString *key = [self layoutKeyForIndexPath:indexPath];
            _layoutAttributes[key] = attributes;
            
            xOffset += itemSize.width;
            xOffset += _itemSpacing;
            
        }
        
        // Section double spacing
        xOffset += _itemSpacing;
    }
    
    xOffset += _insets.right;

    _contentSize = CGSizeMake(xOffset, self.collectionView.frame.size.height - 10);
}


#pragma mark - Helpers

- (NSString *)layoutKeyForIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"%d_%d", indexPath.section, indexPath.row];
}

- (NSString *)layoutKeyForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"s_%d_%d", indexPath.section, indexPath.row];
}


#pragma mark - Invalidate

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return !(CGSizeEqualToSize(newBounds.size, self.collectionView.frame.size));
}


 #pragma mark - Required methods

- (CGSize)collectionViewContentSize
{
    return _contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atCellIndexPath:(NSIndexPath *)indexPath
{

    NSString *headerKey = [self layoutKeyForHeaderAtIndexPath:indexPath];
    return _layoutAttributes[headerKey];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self layoutKeyForIndexPath:indexPath];
    return _layoutAttributes[key];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
        UICollectionViewLayoutAttributes *layoutAttribute = _layoutAttributes[evaluatedObject];
        return CGRectIntersectsRect(rect, [layoutAttribute frame]);
    }];
    
    NSArray *matchingKeys = [[_layoutAttributes allKeys] filteredArrayUsingPredicate:predicate];
    return [_layoutAttributes objectsForKeys:matchingKeys notFoundMarker:[NSNull null]];
}

@end
