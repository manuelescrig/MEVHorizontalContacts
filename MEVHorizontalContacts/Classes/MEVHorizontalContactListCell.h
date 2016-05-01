//
//  MEVHorizontalContactListCell.h
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 24/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

@import UIKit;
@import QuartzCore;

@protocol MEVHorizontalContactListCellDelegate <NSObject>

- (void)cellSelected:(NSInteger)index;

- (void)menuSelectedOption:(NSInteger)option atIndex:(NSInteger)index;

@end


@class MEVHorizontalContactListModel;

@interface MEVHorizontalContactListCell : UICollectionViewCell
{
    UIImageView *imageView;
    UILabel *label;
}

@property (nonatomic, strong) MEVHorizontalContactListModel *contact;

@property (nonatomic,strong) id<MEVHorizontalContactListCellDelegate> cellDelegate;


- (void)setUpCellOptions;

- (void)showMenuViews;

- (void)hideMenuViews;

- (void)setContactModel:(MEVHorizontalContactListModel *)contact;


@end
