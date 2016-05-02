//
//  MEVHorizontalContactsExample1.h
//  MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 02/05/16.
//  Copyright © 2016 Manuel Escrig Ventura. All rights reserved.
//

@import UIKit;

#import "MEVHorizontalContactsModel.h"
#import "MEVHorizontalContactsFlowLayout.h"
#import "MEVHorizontalContactsCell.h"
#import "MEVHorizontalContactsAddContactView.h"

@interface MEVHorizontalContactsExample1 : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MEVHorizontalContactsCellDelegate, MEVHorizontalContactsAddContactViewDelegate>

- (void)loadView;

@end
