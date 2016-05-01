//
//  MEVHorizontalContactListAddContactView.h
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 25/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

@import UIKit;

#import "MEVHorizontalContactListView.h"

@protocol MEVHorizontalContactListAddContactViewDelegate <NSObject>

- (void)buttonDidTap:(UIButton *)button;

@end

@interface MEVHorizontalContactListAddContactView : UICollectionReusableView

@property (nonatomic,strong) id<MEVHorizontalContactListAddContactViewDelegate> buttonDelegate;

+ (CGSize)defaultSize;

@end
