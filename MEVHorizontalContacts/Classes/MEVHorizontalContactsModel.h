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

@interface MEVHorizontalContactsModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *name;

+ (instancetype)contactWithImage:(UIImage *)image name:(NSString *)name;

- (NSString *)getName;

- (void)setExpanded:(BOOL)expanded;
- (BOOL)isExpanded;


@end
