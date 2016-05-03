//
//  MEVHorizontalContactsCell.h
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 24/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

@import UIKit;
@import QuartzCore;


@protocol MEVHorizontalContactsCellDataSource <NSObject>

@required

- (NSInteger)numberOfItemsInCellIndexPath:(NSIndexPath *)indexPath;

- (NSString *)textForItemAtIndex:(NSInteger)index inCellIndexPath:(NSIndexPath *)indexPath;

- (UIImage *)imageForItemAtIndex:(NSInteger)index inCellIndexPath:(NSIndexPath *)indexPath;

@optional

- (UIColor *)textColorForItemAtIndex:(NSInteger)index inCellIndexPath:(NSIndexPath *)indexPath;

- (UIColor *)backgroundColorForItemAtIndex:(NSInteger)index inCellIndexPath:(NSIndexPath *)indexPath;

- (UIColor *)tintColorForItemAtIndex:(NSInteger)index inCellIndexPath:(NSIndexPath *)indexPath;

@end


@protocol MEVHorizontalContactsCellDelegate <NSObject>

- (void)cellSelectedAtIndexPath:(NSIndexPath *)indexPath;

- (void)menuOptionSelected:(NSInteger)option atIndexPath:(NSIndexPath *)indexPath;

@end


@class MEVHorizontalContactsModel;

@interface MEVHorizontalContactsCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) MEVHorizontalContactsModel *contact;
@property (nonatomic, strong) id<MEVHorizontalContactsCellDelegate> cellDelegate;
@property (nonatomic, strong) id<MEVHorizontalContactsCellDataSource> cellDataSource;
@property (nonatomic, strong) NSIndexPath *cellIndexPath;


- (void)showMenuOptions;

- (void)hideMenuOptions;

- (BOOL)isMenuShown;

- (void)setContactModel:(MEVHorizontalContactsModel *)contact;


@end
