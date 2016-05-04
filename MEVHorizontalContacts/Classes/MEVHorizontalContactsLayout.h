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

@interface MEVHorizontalContactsLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat itemWidth;

- (void)deSelectAllItems;

@end
