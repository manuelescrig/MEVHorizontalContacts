//
//  MEHorizontalContactListFlowLayout.h
//  An iOS UICollectionViewLayout subclass to show a list of contacts with configurable expandable items.
//
//  https://github.com/manuelescrig/MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 24/02/16.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//  Licence: MIT-Licence
//

@import UIKit;

/**
 * The object that acts as the data source of the horizontal contacts layout.
 * @discussion The data source adopts the MEVHorizontalContactsLayoutDataSource protocol. The data source is not retained.
 *
 */
@protocol MEVHorizontalContactsLayoutDataSource <NSObject>

@required

/**
 * Asks the delegate the number of total items for a specific contact to represent.
 * @warning It is required to be implemented.
 *
 * @param index A NSInteger with the index of the contact.
 * @return An NSInteger with the number of items for the specific contact index.
 *
 */
- (NSInteger)numberOfItemsInCellIndexPath:(NSIndexPath *)indexPath;

@end

/**
 * A UICollectionViewLayout object subclass that represents the layout.
 * @author Manuel Escrig Ventura
 *
 */
@interface MEVHorizontalContactsLayout : UICollectionViewLayout

/** An UIEdgeInsets object to represent insets to be applied to the horizontal contacts list */
@property (nonatomic, assign) UIEdgeInsets insets;

/** An CGFloat object to represent the height of the items in the horizontal contacts list */
@property (nonatomic, assign) CGFloat itemHeight;

/** An CGFloat object to represent the label height of the items in the horizontal contacts list */
@property (nonatomic, assign) CGFloat labelHeight;

/** An CGFloat object to represent the space between the items in the horizontal contacts list */
@property (nonatomic, assign) CGFloat itemSpacing;

/** The horizontal contacts layout data source object. */
@property (nonatomic, weak) id<MEVHorizontalContactsLayoutDataSource> dataSource;

@end
