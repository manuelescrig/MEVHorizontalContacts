//
//  MEVHorizontalContactListModel.m
//  People Tracker
//
//  Created by Manuel Escrig Ventura on 24/02/15.
//  Copyright (c) 2015 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVHorizontalContactListModel.h"

@implementation MEVHorizontalContactListModel {
    
    Boolean _expanded;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[MEVHorizontalContactListModel class]]) {
        MEVHorizontalContactListModel *other = object;
        
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
    MEVHorizontalContactListModel *model = [[MEVHorizontalContactListModel new] init];
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

- (CGSize)getSize
{    
    if (_expanded) {
        return CGSizeMake(280, 80);
    } else {
        return CGSizeMake(70, 80);
    }
}

@end
