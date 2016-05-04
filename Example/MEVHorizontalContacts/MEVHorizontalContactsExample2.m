//
//  MEVHorizontalContactsExample2.m
//  MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 02/05/16.
//  Copyright © 2016 Manuel Escrig Ventura. All rights reserved.
//


#import "MEVHorizontalContactsExample2.h"

#import "MEVHorizontalContacts.h"

@interface MEVHorizontalContactsExample2 () <MEVHorizontalContactsDataSource, MEVHorizontalContactsDelegate>

@property (nonatomic, strong) NSArray *contacts;

@end

@implementation MEVHorizontalContactsExample2


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
    
    [self setupData];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    MEVHorizontalContacts *horizontalContacts = [MEVHorizontalContacts new];
    horizontalContacts.dataSource = self;
    horizontalContacts.delegate = self;
    [self addSubview:horizontalContacts];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[horizontalContacts]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"horizontalContacts" : horizontalContacts}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[horizontalContacts]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"horizontalContacts" : horizontalContacts}]];
}

- (void)setupData {
    
    // Data
    NSMutableArray *contacts = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        MEVHorizontalContactsModel *contact =  [MEVHorizontalContactsModel new];
        [contact setId:@"1"];
        [contact setName:[self getRandomUserName]];
        [contact setImage:[UIImage imageNamed:[self getRandomImageName]]];
        [contacts addObject:contact];
    }
    _contacts = [contacts copy];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}



#pragma mark - MEVHorizontalContactsDataSource Methods

- (NSInteger)numberOfContacts {
    return [_contacts count];
}

- (NSInteger)numberOfItemsAtIndex:(NSInteger)index {
    return 1;
}

- (MEVHorizontalContactsModel *)contactAtIndex:(NSInteger)index {
    return [_contacts objectAtIndex:index];
}

- (NSString *)textForItem:(NSInteger)item atIndex:(NSInteger)index {
    switch (item) {
        case 0:
            return @"Call";
            break;
        case 1:
            return @"Email";
            break;
        case 2:
            return @"Message";
            break;
        default:
            return @"Call";
            break;
    }
}

- (UIImage *)imageForItem:(NSInteger)item atIndex:(NSInteger)index {
    switch (item) {
        case 0:
            return [UIImage imageNamed:@"actionCall"];
            break;
        case 1:
            return [UIImage imageNamed:@"actionEmail"];
            break;
        case 2:
            return [UIImage imageNamed:@"actionMessage"];
            break;
        default:
            return [UIImage imageNamed:@"actionCall"];
            break;
    }
}

- (UIColor *)textColorForItem:(NSInteger)item atIndex:(NSInteger)index {
    return [UIColor redColor];
}

- (UIColor *)backgroundColorForItem:(NSInteger)item atIndex:(NSInteger)index {
    return [UIColor whiteColor];
}

- (UIColor *)tintColorForItem:(NSInteger)item atIndex:(NSInteger)index {
    return [UIColor redColor];
}

- (UIEdgeInsets)horizontalContactsInsets {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

- (NSInteger)horizontalContactsItemSpacing {
    return 10;
}

#pragma mark - MEVHorizontalContactsDelegate Methods

- (void)contactSelectedAtIndex:(NSInteger)index {
    NSLog(@"cellSelectedAtIndexPath");
}

- (void)item:(NSInteger)item selectedAtIndex:(NSInteger)index {
    NSLog(@"cellSelectedAtIndexPath");
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
