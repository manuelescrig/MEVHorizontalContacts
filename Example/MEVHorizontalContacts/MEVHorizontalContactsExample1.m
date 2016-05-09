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
    
    self.translatesAutoresizingMaskIntoConstraints = NO;

    _horizontalContacts = [MEVHorizontalContacts new];
    _horizontalContacts.backgroundColor = [UIColor whiteColor];
    _horizontalContacts.dataSource = self;
    _horizontalContacts.delegate = self;
    [self addSubview:_horizontalContacts];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[horizontalContacts]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"horizontalContacts" : _horizontalContacts}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[horizontalContacts]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"horizontalContacts" : _horizontalContacts}]];
}


#pragma mark - MEVHorizontalContactsDataSource Methods

- (NSInteger)numberOfContacts {
    return 30;
}

- (NSInteger)numberOfItemsAtContactIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 4;
            break;
        default:
            return 3;
            break;
    }
}

- (MEVHorizontalContactsCell *)contactAtIndex:(NSInteger)index {
    MEVHorizontalContactsCell *cell = [_horizontalContacts dequeueReusableContactCellForIndex:index];
    [cell.imageView setImage:[UIImage imageNamed:[self getImageNameAtIndex:index]]];
    [cell.imageView.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:167/255.0f blue:240/255.0f alpha:1].CGColor];
    [cell.imageView.layer setBorderWidth:1.0f];
    [cell.label setText:[self getUserNameAtIndex:index]];
    [cell.label setFont:[UIFont boldSystemFontOfSize:12.0f]];
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
    [cell.imageView setTintColor:[UIColor colorWithRed:34/255.0f green:167/255.0f blue:240/255.0f alpha:1]];
    [cell.imageView.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:167/255.0f blue:240/255.0f alpha:1].CGColor];
    [cell.imageView.layer setBorderWidth:1.0f];
    [cell.label setText:labelText];
    [cell.label setFont:[UIFont boldSystemFontOfSize:10.0f]];

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
    NSLog(@"selectedAtContactIndex - index : %zu option : %zu ", index, item);
}


#pragma mark - Generate Data Methods

- (NSString *)getUserNameAtIndex:(NSInteger)index {
    NSArray *array = @[@"James", @"Mary", @"Robert", @"Patricia", @"David", @"Linda", @"Charles", @"Barbara", @"John", @"Paul", @"James", @"Mary", @"Robert", @"Patricia", @"David", @"Linda", @"Charles", @"Barbara", @"John", @"Paul", @"James", @"Mary", @"Robert", @"Patricia", @"David", @"Linda", @"Charles", @"Barbara", @"John", @"Paul"];
    return [array objectAtIndex:index];
}

- (NSString *)getImageNameAtIndex:(NSInteger)index {
    NSArray *array = @[@"image1", @"image2", @"image3", @"image4", @"image5", @"image6", @"image7", @"image8", @"image9", @"image10", @"image1", @"image2", @"image3", @"image4", @"image5", @"image6", @"image7", @"image8", @"image9", @"image10", @"image1", @"image2", @"image3", @"image4", @"image5", @"image6", @"image7", @"image8", @"image9", @"image10"];
    return [array objectAtIndex:index];
}

@end
