//
//  MEVHorizontalContactsAddContactView.h
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 25/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

@import UIKit;

@protocol MEVHorizontalContactsAddContactViewDelegate <NSObject>

- (void)buttonDidTap:(UIButton *)button;

@end

@interface MEVHorizontalContactsAddContactView : UICollectionReusableView

@property (nonatomic,strong) id<MEVHorizontalContactsAddContactViewDelegate> buttonDelegate;

+ (CGSize)defaultSize;

@end
