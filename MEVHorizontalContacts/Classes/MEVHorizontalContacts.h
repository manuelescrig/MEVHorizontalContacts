//
//  MEVHorizontalContacts.h
//  An iOS UICollectionViewLayout subclass to show a list of contacts with configurable expandable items.
//
//  https://github.com/manuelescrig/MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 24/02/16.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//  Licence: MIT-Licence
//

@import UIKit;

#import "MEVHorizontalContactsLayout.h"
#import "MEVHorizontalContactsCell.h"


/**
 * The object that acts as the data source of the horizontal contacts.
 * @discussion The data source adopts the MEVHorizontalContactsDataSource protocol. The data source is not retained. 
 * @discussion Use this for configuring and customazing the content of the horizontal contacts list.
 *
 */
@protocol MEVHorizontalContactsDataSource <NSObject>

@required

/**
 * Asks the delegate the number of total contacts to represent.
 * @warning It is required to be implemented.
 *
 * @return An NSInteger with the number of contacts.
 *
 */
- (NSInteger)numberOfContacts;

/**
 * Asks the delegate the number of total items for a specific contact to represent.
 * @warning It is required to be implemented.
 *
 * @param index A NSInteger with the index of the contact.
 * @return An NSInteger with the number of items for the specific contact index.
 *
 */
- (NSInteger)numberOfItemsAtContactIndex:(NSInteger)index;

/**
 * Asks the delegate for the content for a specific contact index.
 * @discussion Use this protocol method as you would use `- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath`.
 * @warning It is required to be implemented.
 *
 * @param index A NSInteger with the index of the contact.
 * @return A MEVHorizontalContactsCell object representing the data of the specific contact index.
 *
 */
- (MEVHorizontalContactsCell *)contactAtIndex:(NSInteger)index;

/**
 * Asks the delegate for the content for an item for a specific contact index.
 * @discussion Use this protocol method as you would use `- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath`.
 * @warning It is required to be implemented.
 *
 * @param index A NSInteger with the index of the contact.
 * @param item A NSInteger with the index of the item for the specific contact index.
 * @return A MEVHorizontalContactsCell object representing the data of the specific item for the contact index.
 *
 */
- (MEVHorizontalContactsCell *)item:(NSInteger)item atContactIndex:(NSInteger)index;

@optional

/**
 * Asks the delegate the padding between contacts and between items to be applied to the horizontal contacts list.
 * @discussion It is an optional method.
 * @discussion Default value is 0.
 *
 * @return An NSInteger representing the desired padding.
 *
 */
- (NSInteger)horizontalContactsSpacing;

/**
 * Asks the delegate the UIEdgeInsets to be applied to the horizontal contacts list.
 * @discussion It is an optional method.
 * @discussion Default value is UIEdgeInsetsZero.
 *
 * @return An UIEdgeInsets object representing the desired padding.
 *
 */
- (UIEdgeInsets)horizontalContactsInsets;

@end

/**
 * The object that acts as the delegate of the horizontal contacts.
 * @discussion The delegate adopts the MEVHorizontalContactsDelegate protocol. The delegate is not retained. All delegate methods are optional.
 * @discussion Use this delegate for receiving action callbacks.
 *
 */
@protocol MEVHorizontalContactsDelegate <NSObject>

/**
 * Tells the delegate that the contact was tapped.
 * @param index The index of the contact that was tapped from the horizontal list.
 *
 */
- (void)contactSelectedAtIndex:(NSInteger)index;

/**
 * Tells the delegate that an item from a contact  was tapped.
 * @param index The index of the contact that was tapped from the horizontal list.
 * @param item The index of the item that was tapped from the horizontal list.
 *
 */
- (void)item:(NSInteger)item selectedAtContactIndex:(NSInteger)index;

@end

/**
 * A UIView object subclass that represents the list of contacts itself.
 * @author Manuel Escrig Ventura
 *
 */
@interface MEVHorizontalContacts : UIView

/** 
 * The horizontal contacts data source object. 
 *
 */
@property (nonatomic, weak) id<MEVHorizontalContactsDataSource> dataSource;

/** 
 * The horizontal contacts delegate object. 
 *
 */
@property (nonatomic, weak) id<MEVHorizontalContactsDelegate> delegate;

/**
 * Indicates if the MEVHorizontalContacts should contract when an item is selected.
 * @param contractCellWhenItemSelected A BOOL value.
 * @discussion Default value is NO.
 *
 */
@property (nonatomic, assign) BOOL contractCellWhenItemSelected;

/**
 * @abstract Sets the animation type MEVHorizontalsAnimationMode for the MEVHorizontalContacts.
 * @param animationMode A MEVHorizontalsAnimationMode type.
 * @discussion MEVHorizontalsAnimationBounce is the default value when this property is not assigned.
 *
 */
@property (nonatomic, assign) MEVHorizontalsAnimationMode animationMode;


/**
 * Required to be used with "MEVHorizontalContactsDataSource" in the `- (MEVHorizontalContactsCell *)contactAtIndex:(NSInteger)index` method.
 *
 * @see  `- (MEVHorizontalContactsCell *)contactAtIndex:(NSInteger)index` method.
 *
 * @param index The contact index.
 * @return MEVHorizontalContactsCell An MEVHorizontalContactsCell object to be returned by the method itself.
 *
 */
- (MEVHorizontalContactsCell *)dequeueReusableContactCellForIndex:(NSInteger)index;

/**
 * Required to be used with "MEVHorizontalContactsDataSource" in the 
 * `- (MEVHorizontalContactsCell *)item:(NSInteger)item atContactIndex:(NSInteger)index` method.
 * 
 * @see  `- (MEVHorizontalContactsCell *)item:(NSInteger)item atContactIndex:(NSInteger)index` method.
 *
 * @param index The contact index.
 * @param item The item index for the specific contact.
 * @return MEVHorizontalContactsCell An MEVHorizontalContactsCell object item to be returned by the method itself.
 *
 */
- (MEVHorizontalContactsCell *)dequeueReusableItemCellForIndex:(NSInteger)index;

/**
 * Reloads the data of the MEVHorizontalContacts in case the user needs to refresh the contacts.
 *
 */
- (void)reloadData;

@end
