//
//  MEVHorizontalContactsCell.h
//  An iOS UICollectionViewLayout subclass to show a list of contacts with configurable expandable items.
//
//  https://github.com/manuelescrig/MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 24/02/16.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//  Licence: MIT-Licence
//

@import UIKit;

@class MEVHorizontalContactsCell;

/**
 * @enum MEVHorizontalsAnimationMode
 * @abstract Animation mode for MEVHorizontalContacts.
 * @constant MEVHorizontalsAnimationNone
 * @constant MEVHorizontalsAnimationBounce
 *
 */
typedef NS_ENUM(NSInteger, MEVHorizontalsAnimationMode) {
    MEVHorizontalsAnimationNone,
    MEVHorizontalsAnimationBounce
};

/**
 * The object that acts as the data source of the horizontal contacts.
 * @discussion The data source adopts the MEVHorizontalContactsCellDataSource protocol. The data source is not retained.
 * @discussion Use this for configuring and customazing the content of the horizontal contacts list.
 *
 */
@protocol MEVHorizontalContactsCellDataSource <NSObject>

@required

/**
 * Asks the delegate the number of total items for a specific contact to represent.
 * @warning It is required to be implemented.
 *
 * @param indexPath A NSIndexPath with the index of the contact.
 * @return An NSInteger with the number of items for the specific contact index.
 *
 */
- (NSInteger)numberOfItemsInCellIndexPath:(NSIndexPath *)indexPath;

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

@end

/**
 * The object that acts as the delegate of the horizontal contacts.
 * @discussion The delegate adopts the MEVHorizontalContactsDelegate protocol. The delegate is not retained. All delegate methods are optional.
 * @discussion Use this delegate for receiving action callbacks.
 *
 */
@protocol MEVHorizontalContactsCellDelegate <NSObject>

/**
 * Tells the delegate that the contact was tapped.
 * @param indexPath The indexPath of the contact that was tapped from the horizontal list.
 *
 */
- (void)cellSelectedAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Tells the delegate that an item from a contact  was tapped.
 * @param indexPath The index of the contact that was tapped from the horizontal list.
 * @param item The index of the item that was tapped from the horizontal list.
 *
 */
- (void)itemSelected:(NSInteger)item atCellIndexPath:(NSIndexPath *)indexPath;

@end

/**
 * A UICollectionViewCell object subclass that represents the cell for each contact.
 * @author Manuel Escrig Ventura
 *
 */
@interface MEVHorizontalContactsCell : UICollectionViewCell

/** The horizontal contacts data source object. */
@property (nonatomic, weak) id<MEVHorizontalContactsCellDelegate> delegate;

/** The horizontal contacts delegate object. */
@property (nonatomic, weak) id<MEVHorizontalContactsCellDataSource> dataSource;

/** The indexPath object with the row and section information. */
@property (nonatomic, strong) NSIndexPath *indexPath;

/** The imageView object that shows the image for each contact cell. */
@property (nonatomic, strong) UIImageView *imageView;

/** The UILabel object that shows the text for each contact cell. */
@property (nonatomic, strong) UILabel *label;

/** An CGFloat object to represent the label height of the items in the horizontal contacts list */
@property (nonatomic, assign) CGFloat labelHeight;

/** An CGFloat object to represent the space between the items in the horizontal contacts list */
@property (nonatomic, assign) CGFloat itemSpacing;

/** 
 * Indicates if the MEVHorizontalContacts should be either square or rounded.
 * @param rounded A BOOL value.
 * @discussion Default value is YES.
 * 
 */
@property (nonatomic, getter=isRounded) BOOL rounded;

/**
 * @abstract Sets the animation type MEVHorizontalsAnimationMode for the MEVHorizontalContacts.
 * @param animationMode A MEVHorizontalsAnimationMode type.
 * @discussion MEVHorizontalsAnimationBounce is the default value when this property is not assigned.
 *
 */
@property (nonatomic, assign) MEVHorizontalsAnimationMode animationMode;

/**
 * Show the contact cell items.
 *
 * @param animated When animated is YES then the menu items appear animated.
 *
 */
- (void)showMenuItemsAnimated:(BOOL)animated;

/**
 * Hide the contact cell items.
 *
 * @param animated When animated is YES then the menu items appear animated.
 *
 */
- (void)hideMenuItemsAnimated:(BOOL)animated;


@end
