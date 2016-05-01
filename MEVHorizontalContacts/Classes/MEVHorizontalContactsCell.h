//
//  MEVHorizontalContactsCell.h
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 24/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

@import UIKit;
@import QuartzCore;

@protocol MEVHorizontalContactCellDelegate <NSObject>

- (void)cellSelected:(NSInteger)index;

- (void)menuSelectedOption:(NSInteger)option atIndex:(NSInteger)index;

@end


@class MEVHorizontalContactsModel;

@interface MEVHorizontalContactsCell : UICollectionViewCell
{
    UIImageView *imageView;
    UILabel *label;
}

@property (nonatomic, strong) MEVHorizontalContactsModel *contact;

@property (nonatomic,strong) id<MEVHorizontalContactCellDelegate> cellDelegate;


- (void)setUpCellOptions;

- (void)showMenuViews;

- (void)hideMenuViews;

- (void)setContactModel:(MEVHorizontalContactsModel *)contact;


@end
