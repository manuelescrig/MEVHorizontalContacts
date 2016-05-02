//
//  MEVHorizontalContactsExample2.h
//  MEVHorizontalContacts
//
//  Created by Manuel Escrig Ventura on 02/05/16.
//  Copyright © 2016 Manuel Escrig Ventura. All rights reserved.
//

@import UIKit;

#import "MEVHorizontalContactsFlowLayout.h"
#import "MEVHorizontalContactsCell.h"
#import "MEVHorizontalContactsModel.h"

@interface MEVHorizontalContactsExample2 : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MEVHorizontalContactsCellDelegate, MEVHorizontalContactsCellDataSource>

- (void)loadView;

@end
