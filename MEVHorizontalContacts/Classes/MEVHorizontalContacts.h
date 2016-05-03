//
//  MEVHorizontalContactsModel.h
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 24/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

@import UIKit;

#import "MEVHorizontalContactsLayout.h"
#import "MEVHorizontalContactsCell.h"
#import "MEVHorizontalContactsModel.h"

NSInteger const kHorizontalContactsLabelHeight = 30;

@protocol MEVHorizontalContactsDataSource <NSObject>

@required

- (NSInteger)numberOfContacts;

- (NSInteger)numberOfItemsAtIndex:(NSInteger)index;

- (MEVHorizontalContactsModel *)contactAtIndex:(NSInteger)index;

- (NSString *)textForItem:(NSInteger)item atIndex:(NSInteger)index;

- (UIImage *)imageForItem:(NSInteger)item atIndex:(NSInteger)index;

@optional

- (UIColor *)textColorForItem:(NSInteger)item atIndex:(NSInteger)index;

- (UIColor *)backgroundColorForItem:(NSInteger)item atIndex:(NSInteger)index;

- (UIColor *)tintColorForItem:(NSInteger)item atIndex:(NSInteger)index;

- (UIEdgeInsets)horizontalContactsInsets;

- (NSInteger)horizontalContactsItemSpacing;

@end


@protocol MEVHorizontalContactsDelegate <NSObject>

- (void)contactSelectedAtIndex:(NSInteger)index;

- (void)item:(NSInteger)item selectedAtIndex:(NSInteger)index;

@end


@interface MEVHorizontalContacts : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MEVHorizontalContactsCellDelegate, MEVHorizontalContactsCellDataSource>

@property (nonatomic, weak) id<MEVHorizontalContactsDataSource> dataSource;

@property (nonatomic, weak) id<MEVHorizontalContactsDelegate> delegate;

@end
