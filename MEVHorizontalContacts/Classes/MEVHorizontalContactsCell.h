//
//  MEVHorizontalContactsCell.h
//  People Tracker
//
//  https://github.com/manuelescrig/MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 24/02/16.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//  Licence: MIT-Licence
//

@import UIKit;

@class MEVHorizontalContactsCell;

@protocol MEVHorizontalContactsCellDataSource <NSObject>

@required

- (NSInteger)numberOfItemsInCellIndexPath:(NSIndexPath *)indexPath;

- (MEVHorizontalContactsCell *)option:(NSInteger)option atContactIndex:(NSInteger)index;

- (CGFloat)itemSpacing;

@end


@protocol MEVHorizontalContactsCellDelegate <NSObject>

- (void)cellSelectedAtIndexPath:(NSIndexPath *)indexPath;

- (void)menuOptionSelected:(NSInteger)option atCellIndexPath:(NSIndexPath *)indexPath;

@end


@interface MEVHorizontalContactsCell : UICollectionViewCell

@property (nonatomic, weak) id<MEVHorizontalContactsCellDelegate> cellDelegate;
@property (nonatomic, weak) id<MEVHorizontalContactsCellDataSource> cellDataSource;

@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) CGFloat labelHeight;
@property (nonatomic, assign) CGFloat itemSpacing;

- (void)showMenuOptionsAnimated:(BOOL)animated;

- (void)hideMenuOptionsAnimated:(BOOL)animated;


@end
