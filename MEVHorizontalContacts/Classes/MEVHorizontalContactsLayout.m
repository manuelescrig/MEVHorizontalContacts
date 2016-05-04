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
    
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:path];
    attributes.frame = CGRectMake(0, 0, self.collectionView.frame.size.width, self.itemHeight / 4.0f);
    
    NSString *headerKey = [self layoutKeyForHeaderAtIndexPath:path];
    _layoutAttributes[headerKey] = attributes;
    
    NSUInteger numberOfSections = [self.collectionView numberOfSections];

    CGFloat yOffset = self.insets.top;
    CGFloat xOffset = self.insets.left;
    
    for (int section = 0; section < numberOfSections; section++)
    {
        NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        
        // Section double spacing
        xOffset += self.itemSpacing;

        for (int item = 0; item < numberOfItems; item++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath]; 
            
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            NSLog(@"prepareLayout - cell.isSelected = %d", cell.isSelected);

            CGSize itemSize = CGSizeZero;
            if (cell.isSelected) {
                itemSize.width = (self.itemHeight+self.itemSpacing)  * 3;
            } else {
                itemSize.width = self.itemHeight - 30;
            }
            itemSize.height = self.itemHeight;
            
            attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
            NSString *key = [self layoutKeyForIndexPath:indexPath];
            _layoutAttributes[key] = attributes;
            
            xOffset += itemSize.width;
            xOffset += self.itemSpacing;
            
        }
        
        // Section double spacing
        xOffset += self.itemSpacing;
    }
    
    xOffset += self.insets.right;

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

- (void)deSelectAllItems
{
    NSUInteger numberOfSections = [self.collectionView numberOfSections];
    for (int section = 0; section < numberOfSections; section++) {
        
        NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        for (int item = 0; item < numberOfItems; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            cell.selected = NO;
        }
    }
}

#pragma mark - Invalidate

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {

    [self deSelectAllItems];
    
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
