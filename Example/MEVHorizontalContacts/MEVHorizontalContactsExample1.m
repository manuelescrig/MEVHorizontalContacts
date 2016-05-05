//
//  MEVHorizontalContactsExample1.m
//  MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 02/05/16.
//  Copyright © 2016 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVHorizontalContactsExample1.h"

#import "MEVHorizontalContacts.h"

@interface MEVHorizontalContactsExample1 () <MEVHorizontalContactsDataSource, MEVHorizontalContactsDelegate>

@property (nonatomic, strong) MEVHorizontalContacts *horizontalContacts;

@end

@implementation MEVHorizontalContactsExample1


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
    NSLog(@"setupView = %@", self);
    
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
    return 10;
}

- (NSInteger)numberOfOptionsAtContactIndex:(NSInteger)index {
    return 3;
}

- (MEVHorizontalContactsCell *)contactAtIndex:(NSInteger)index {
    MEVHorizontalContactsCell *cell = [_horizontalContacts dequeueReusableContactCellForIndex:index];
    [cell.imageView setImage:[UIImage imageNamed:[self getRandomImageName]]];
    [cell.label setText:[self getRandomUserName]];
    return cell;
}

- (MEVHorizontalContactsCell *)option:(NSInteger)option atContactIndex:(NSInteger)index {
    
    NSString *labelText;
    switch (option) {
        case 0:
            labelText = @"Call";
            break;
        case 1:
            labelText = @"Email";
            break;
        case 2:
            labelText = @"Message";
            break;
        default:
            labelText = @"Call";
            break;
    }
    
    UIImage *image;
    switch (option) {
        case 0:
            image = [UIImage imageNamed:@"actionCall"];
            break;
        case 1:
            image = [UIImage imageNamed:@"actionEmail"];
            break;
        case 2:
            image = [UIImage imageNamed:@"actionMessage"];
            break;
        default:
            image = [UIImage imageNamed:@"actionCall"];
            break;
    }
    
    MEVHorizontalContactsCell *cell = [_horizontalContacts dequeueReusableOptionCellForIndex:index];
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

- (void)option:(NSInteger)option selectedAtContactIndex:(NSInteger)index {
    NSLog(@"selectedAtContactIndex - index : %zu option : %zu ", index, option);
}


#pragma mark - Generate Data Methods

- (NSString *)getRandomUserName {
    NSArray *array = @[@"James", @"Mary", @"Robert", @"Patricia", @"David", @"Linda", @"Charles", @"Barbara", @"John", @"Paul"];
    return [array objectAtIndex: arc4random() % [array count]];
}

- (NSString *)getRandomImageName {
    NSArray *array = @[@"image1", @"image2", @"image3", @"image4", @"image5", @"image6", @"image7", @"image8", @"image9", @"image10"];
    return [array objectAtIndex: arc4random() % [array count]];
}

@end
