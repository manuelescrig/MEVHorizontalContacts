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

@implementation MEVHorizontalContactsModel

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

@end
