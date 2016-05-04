//
//  MEVHorizontalContactsModel.m
//  People Tracker
//
//  https://github.com/manuelescrig/MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 24/02/16.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//  Licence: MIT-Licence
//

#import "MEVHorizontalContactsModel.h"

@implementation MEVHorizontalContactsModel {
    
    Boolean _expanded;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[MEVHorizontalContactsModel class]]) {
        MEVHorizontalContactsModel *other = object;
        
        if ([self.id isEqualToString:other.id]) {
            return true;
        } else {
            return false;
        }
    } else {
        return true;
    }
}

+ (instancetype)contactWithImage:(UIImage *)image name:(NSString *)name
{
    MEVHorizontalContactsModel *model = [[MEVHorizontalContactsModel new] init];
    if (model) {
        model.image = image;
        model.name = name;
        [model setExpanded:NO];
    }
      return model;
}


- (NSString *)getName
{
    return _name;
}

- (void)setExpanded:(BOOL)expanded;
{
    _expanded = expanded;
}

- (BOOL)isExpanded
{
    return _expanded;
}

@end
