//
//  MEVHorizontalContactsModel.h
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 24/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "MEVHorizontalContactsView.h"

@interface MEVHorizontalContactsModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *name;

+ (instancetype)contactWithImage:(UIImage *)image name:(NSString *)name;

- (NSString *)getName;

- (void)setExpanded:(BOOL)expanded;
- (BOOL)isExpanded;

- (CGSize)getSize;


@end
