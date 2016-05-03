//
//  MEHorizontalContactListFlowLayout.h
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 25/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

@import UIKit;

@interface MEVHorizontalContactsLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat itemWidth;

- (void)deSelectAllItems;

@end
