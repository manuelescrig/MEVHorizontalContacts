//
//  MEHorizontalContactListFlowLayout.m
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 25/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVHorizontalContactListFlowLayout.h"
#import "MEVHorizontalContactListAddContactView.h"

@interface MEVHorizontalContactListFlowLayout()

// arrays to keep track of insert, delete index paths
@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertIndexPaths;
@end

@implementation MEVHorizontalContactListFlowLayout


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [self registerClass:[MEVHorizontalContactListAddContactView class] forDecorationViewOfKind:@"addContactView"];
        [self setMinimumInteritemSpacing:2];
        [self setMinimumLineSpacing:2];
        
    }
    return self;
}


-(void)prepareLayout
{
    [super prepareLayout];
}


//-(CGSize)collectionViewContentSize
//{
//    NSLog(@"collectionViewContentSize");
//
//    return [self collectionView].frame.size;
//}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
//{
//    NSLog(@"layoutAttributesForItemAtIndexPath = %@",path);
//
//    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
//    return attributes;
//}


//-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSMutableArray* attributes = [NSMutableArray array];
//    return attributes;
//}


- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    NSLog(@"prepareForCollectionViewUpdates = %@",updateItems);

    // Keep track of insert and delete index paths
    [super prepareForCollectionViewUpdates:updateItems];
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
        }
    }
    NSLog(@"deleteIndexPaths = %@",self.deleteIndexPaths);
    NSLog(@"insertIndexPaths = %@",self.insertIndexPaths);
}

- (void)finalizeCollectionViewUpdates
{
    NSLog(@"finalizeCollectionViewUpdates");
    
    [super finalizeCollectionViewUpdates];
    // release the insert and delete index paths
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
}


/*
// Note: name of method changed
// Also this gets called for all visible cells (not just the inserted ones) and
// even gets called when deleting cells!
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // Must call super
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    if ([self.insertIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on inserted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        // Configure attributes ...
        attributes.alpha = 0.0;
    }
    return attributes;
}

// Note: name of method changed
// Also this gets called for all visible cells (not just the deleted ones) and
// even gets called when inserting cells!
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // So far, calling super hasn't been strictly necessary here, but leaving it in
    // for good measure
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    if ([self.deleteIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on deleted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        // Configure attributes ...
        attributes.alpha = 0.0;
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
    return attributes;
}
*/

@end
