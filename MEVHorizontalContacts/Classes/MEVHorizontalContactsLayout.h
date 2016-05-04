//
//  MEHorizontalContactListFlowLayout.h
//  People Tracker
//
//  https://github.com/manuelescrig/MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 24/02/16.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//  Licence: MIT-Licence
//

@import UIKit;


@protocol MEVHorizontalContactsLayoutDataSource <NSObject>

@required

- (NSInteger)numberOfItemsInCellIndexPath:(NSIndexPath *)indexPath;

@end

@interface MEVHorizontalContactsLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat labelHeight;

@property (nonatomic, strong) id<MEVHorizontalContactsLayoutDataSource> dataSource;

- (void)deSelectAllItems;

@end
