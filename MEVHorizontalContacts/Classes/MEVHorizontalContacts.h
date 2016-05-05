//
//  MEVHorizontalContactsModel.h
//  People Tracker
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

@protocol MEVHorizontalContactsDataSource <NSObject>

@required

- (NSInteger)numberOfContacts;

- (NSInteger)numberOfOptionsAtContactIndex:(NSInteger)index;

- (MEVHorizontalContactsCell *)contactAtIndex:(NSInteger)index;

- (MEVHorizontalContactsCell *)option:(NSInteger)option atContactIndex:(NSInteger)index;

@optional

- (NSInteger)horizontalContactsSpacing;

- (UIEdgeInsets)horizontalContactsInsets;

@end


@protocol MEVHorizontalContactsDelegate <NSObject>

- (void)contactSelectedAtIndex:(NSInteger)index;

- (void)option:(NSInteger)option selectedAtContactIndex:(NSInteger)index;

@end


@interface MEVHorizontalContacts : UIView

@property (nonatomic, weak) id<MEVHorizontalContactsDataSource> dataSource;

@property (nonatomic, weak) id<MEVHorizontalContactsDelegate> delegate;

- (MEVHorizontalContactsCell *)dequeueReusableContactCellForIndex:(NSInteger)index;

- (MEVHorizontalContactsCell *)dequeueReusableOptionCellForIndex:(NSInteger)index;

@end
