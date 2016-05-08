//
//  MEVHorizontalContactsExample4.m
//  MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 02/05/16.
//  Copyright © 2016 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVHorizontalContactsExample4.h"

#import "MEVHorizontalContacts.h"

@interface MEVHorizontalContactsExample4 () <MEVHorizontalContactsDataSource, MEVHorizontalContactsDelegate>

@property (nonatomic, strong) MEVHorizontalContacts *horizontalContacts;

@end

@implementation MEVHorizontalContactsExample4


- (id)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupView];
    }
    return self;
}


- (void)setupView {
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    _horizontalContacts = [MEVHorizontalContacts new];
    _horizontalContacts.dataSource = self;
    _horizontalContacts.delegate = self;
    [self addSubview:_horizontalContacts];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[horizontalContacts]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"horizontalContacts" : _horizontalContacts}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[horizontalContacts]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"horizontalContacts" : _horizontalContacts}]];
}


#pragma mark - MEVHorizontalContactsDataSource Methods

- (NSInteger)numberOfContacts {
    return 2;
}

- (NSInteger)numberOfItemsAtContactIndex:(NSInteger)index {
    return 1;
}

- (MEVHorizontalContactsCell *)contactAtIndex:(NSInteger)index {
    MEVHorizontalContactsCell *cell = [_horizontalContacts dequeueReusableContactCellForIndex:index];
    [cell.imageView setImage:[UIImage imageNamed:[self getImageNameAtIndex:index]]];
    [cell.label setText:[self getUserNameAtIndex:index]];
    return cell;
}

- (MEVHorizontalContactsCell *)item:(NSInteger)item atContactIndex:(NSInteger)index {
    
    UIImage *image;
    NSString *labelText;
    switch (item) {
        case 0:
            labelText = @"Call";
            image = [UIImage imageNamed:@"actionCall"];
            break;
        case 1:
            labelText = @"Email";
            image = [UIImage imageNamed:@"actionEmail"];
            break;
        case 2:
            labelText = @"Message";
            image = [UIImage imageNamed:@"actionMessage"];
            break;
        default:
            labelText = @"Call";
            image = [UIImage imageNamed:@"actionCall"];
            break;
    }
    
    MEVHorizontalContactsCell *cell = [_horizontalContacts dequeueReusableItemCellForIndex:index];
    [cell.imageView setImage:image];
    [cell.label setText:labelText];
    return cell;
}

- (UIEdgeInsets)horizontalContactsInsets {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

- (NSInteger)horizontalContactsSpacing {
    return 5;
}

#pragma mark - MEVHorizontalContactsDelegate Methods

- (void)contactSelectedAtIndex:(NSInteger)index {
    NSLog(@"cellSelectedAtIndexPath");
}

- (void)item:(NSInteger)item selectedAtContactIndex:(NSInteger)index {
    NSLog(@"cellSelectedAtIndexPath");
}


#pragma mark - Generate Data Methods

- (NSString *)getUserNameAtIndex:(NSInteger)index {
    NSArray *array = @[@"James", @"Mary", @"Robert", @"Patricia", @"David", @"Linda", @"Charles", @"Barbara", @"John", @"Paul"];
    return [array objectAtIndex:index];
}

- (NSString *)getImageNameAtIndex:(NSInteger)index {
    NSArray *array = @[@"image1", @"image2", @"image3", @"image4", @"image5", @"image6", @"image7", @"image8", @"image9", @"image10"];
    return [array objectAtIndex:index];
}

@end