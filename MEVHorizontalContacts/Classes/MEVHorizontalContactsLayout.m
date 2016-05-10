//
//  MEHorizontalContactListFlowLayout.m
//  An iOS UICollectionViewLayout subclass to show a list of contacts with configurable expandable items.
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


#pragma mark - Layout (private)

- (void)prepareLayout
{
    [super prepareLayout];
    
    _layoutAttributes = [NSMutableDictionary dictionary];
    
    NSUInteger numberOfSections = [self.collectionView numberOfSections];
    CGFloat yOffset = _insets.top;
    CGFloat xOffset = _insets.left;
    CGFloat xOffsetExpaned = 0;

    for (int section = 0; section < numberOfSections; section++) {
        NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        
        // Section double spacing
        xOffset += _itemSpacing;

        for (int item = 0; item < numberOfItems; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath]; 
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];

            NSInteger items = 0;
            if([_dataSource respondsToSelector:@selector(numberOfItemsInCellIndexPath:)]) {
                items = [_dataSource numberOfItemsInCellIndexPath:indexPath];
            }

            CGSize itemSize = CGSizeZero;
            itemSize.height = _itemHeight;
            itemSize.width = _itemHeight - _labelHeight;
            if (cell.isSelected) {
                
                itemSize.width += (itemSize.width + _itemSpacing) * (items);
                int itemsInScreen = self.collectionView.frame.size.width / (itemSize.width + _itemSpacing);
                itemsInScreen -= items;
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
    _contentSize = CGSizeMake(xOffset + xOffsetExpaned, self.collectionView.frame.size.height - 10);
}


#pragma mark - Helpers (private)

- (NSString *)layoutKeyForIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"%d_%d", (int)indexPath.section, (int)indexPath.row];
}

- (NSString *)layoutKeyForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"s_%d_%d", (int)indexPath.section, (int)indexPath.row];
}


#pragma mark - Invalidate (private)

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return !(CGSizeEqualToSize(newBounds.size, self.collectionView.frame.size));
}


 #pragma mark - Required methods (private)

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
