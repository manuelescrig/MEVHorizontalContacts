//
//  MEVViewController.m
//  MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 04/29/2016.
//  Copyright (c) 2016 Manuel Escrig Ventura. All rights reserved.
//

#import "MEVViewController.h"

// Examples
#import "MEVHorizontalContactsExample1.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface MEVViewController ()

@end

@implementation MEVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"MEVHorizontalContacts";
    
    [self.tableView setBackgroundColor:[UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self.tableView setEstimatedRowHeight:100];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 120;
            break;
        case 1:
            return 100;
            break;
        case 2:
            return 80;
            break;
        case 3:
            return 160;
            break;
        default:
            return 100;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setBackgroundColor:[UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1]];

    MEVHorizontalContactsExample1 *horizontalContactsView = [MEVHorizontalContactsExample1 new];
    [horizontalContactsView loadView];
    [cell addSubview:horizontalContactsView];
    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"horizontalContactsView" : horizontalContactsView}]];
    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[horizontalContactsView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"horizontalContactsView" : horizontalContactsView}]];
    
    return cell;
}


@end
