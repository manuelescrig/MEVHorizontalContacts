//
//  MEHorizontalContactListFlowLayout.m
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 25/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVHorizontalContactsFlowLayout.h"

@interface MEVHorizontalContactsFlowLayout()

// Arrays to keep track of insert, delete index paths
@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertIndexPaths;

@end

@implementation MEVHorizontalContactsFlowLayout


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [self setMinimumInteritemSpacing:0];
        [self setMinimumLineSpacing:1];
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
}

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


@end
