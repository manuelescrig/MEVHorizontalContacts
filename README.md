# MEVHorizontalContacts
An **iOS** UICollectionViewLayout subclass to show a **list of contacts** with configurable expandable **items**.


[![CI Status](http://img.shields.io/travis/manuelescrig/MEVHorizontalContacts.svg?style=flat)](https://travis-ci.org/manuelescrig/MEVHorizontalContacts)
[![Version](https://img.shields.io/cocoapods/v/MEVHorizontalContacts.svg?style=flat)](http://cocoapods.org/pods/MEVHorizontalContacts)
[![License](https://img.shields.io/cocoapods/l/MEVHorizontalContacts.svg?style=flat)](http://cocoapods.org/pods/MEVHorizontalContacts)
[![Platform](https://img.shields.io/cocoapods/p/MEVHorizontalContacts.svg?style=flat)](http://cocoapods.org/pods/MEVHorizontalContacts)
[![Language](http://img.shields.io/badge/language-objective--c-blue.svg?style=flat)](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html)

<p align="center"><img src="https://cloud.githubusercontent.com/assets/1849990/15137846/645a0d18-168c-11e6-96e2-651d8f8de3b0.gif" align="center" height="600" width="800" ></p>

 
## Features
- [x] Customizable contacts cells
- [x] Customizable contact items cells
- [x] Different sizes and responsive design
- [x] Multiple delegate methods


## Demo App

Run the demo app and play with it!
[Demo App](https://appetize.io/app/y5mq0egpmtvvj6e7up8qg07qjg?device=iphone6splus&scale=50&orientation=portrait&osVersion=9.3&deviceColor=white)

## Demo Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Getting Started

### Requirements

Requires iOS SDK version > 7.0

Requires ARC

### Installation with CocoaPods

[CocoaPods](cocoapods.org) is a 3rd-party dependency manager for Swift and Objective-C projects. For more information, refer to the [CocoaPods Getting Started Guide](https://guides.cocoapods.org/using/getting-started.html). Otherwise, you can install CocoaPods with the following command:

```bash
$ gem install cocoapods
```

#### Podfile
To integrate MEVHorizontalContacts into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
pod 'MEVHorizontalContacts'
```

Then, run the following command:

```bash
$ pod install
```

###  Installation Manually
To integrate MEVHorizontalContacts into your Xcode project manually, just include the filest from [/Pod/Classes/](https://github.com/manuelescrig/MEVHorizontalContacts/tree/master/MEVHorizontalContacts/Classes) folder in your App’s Xcode project.

Then, import the following file your classes:
```objc
#import "MEVHorizontalContacts.h"
```

## Quick Guide

### Usage

###### 1. Import class

```objective-c
#import "MEVHorizontalContacts.h"
```

###### 2. Add Datasource and Delegate protocols.

```objective-c
@interface ViewController () <MEVHorizontalContactsDataSource, MEVHorizontalContactsDelegate>
@property (nonatomic, strong) MEVHorizontalContacts *horizontalContacts;
@end
```

###### 3. Create, initialize and add MEVHorizontalContacts view.

```objective-c
_horizontalContacts = [MEVHorizontalContacts new];
_horizontalContacts.backgroundColor = [UIColor whiteColor];
_horizontalContacts.dataSource = self;
_horizontalContacts.delegate = self;
[self addSubview:_horizontalContacts];
[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[horizontalContacts]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:@{@"horizontalContacts" : _horizontalContacts}]];
[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[horizontalContacts]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"horizontalContacts" : _horizontalContacts}]];
```

###### 4. Implement Datasource Methods

```objective-c
#pragma mark - MEVHorizontalContactsDataSource Methods

- (NSInteger)numberOfContacts;
- (NSInteger)numberOfItemsAtContactIndex:(NSInteger)index;
- (MEVHorizontalContactsCell *)contactAtIndex:(NSInteger)index;
- (MEVHorizontalContactsCell *)item:(NSInteger)item atContactIndex:(NSInteger)index;
- (UIEdgeInsets)horizontalContactsInsets;
- (NSInteger)horizontalContactsSpacing;

```

###### 5. Implement Delegate Methods

```objective-c
#pragma mark - MEVHorizontalContactsDelegate Methods

- (void)contactSelectedAtIndex:(NSInteger)index;
- (void)item:(NSInteger)item selectedAtContactIndex:(NSInteger)index;

```

### Example

###### Customization 1

<p align="center"><img src="https://cloud.githubusercontent.com/assets/1849990/15117532/42b3110c-1608-11e6-81ce-36a493962c8b.gif" align="center" height="78" width="332" ></p>

```objective-c
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

```


###### Customization 2

<p align="center"><img src="https://cloud.githubusercontent.com/assets/1849990/15117199/c853d546-1606-11e6-924a-15e8dcd0e709.gif" align="center"  height="97" width="332" ></p>

```objective-c
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
    [cell.imageView setBackgroundColor:[UIColor colorWithRed:34/255.0f green:167/255.0f blue:240/255.0f alpha:1]];
    [cell.imageView setTintColor:[UIColor whiteColor]];
    [cell.label setText:labelText];
    [cell.label setTextColor:[UIColor colorWithRed:34/255.0f green:167/255.0f blue:240/255.0f alpha:1]];
    return cell;
}

```


## Roadmap
- [x] CocoaPods support
- [ ] Carthage support
- [ ] Tests

## Change Log

See [Changelog.md](https://github.com/manuelescrig/MEVHorizontalContacts/blob/master/CHANGELOG.md)

## Author

- Manuel Escrig Ventura, [@manuelescrig](https://www.twitter.com/manuelescrig/)
- Email [manuel@ventura.media](mailto:manuel@ventura.media)
- Portfolio [http://ventura.media](http://ventura.media)

## Apps using this library

- [People Tracker App](http://itunes.apple.com/us/app/people-tracker-pro/id539205975?ls=1&mt=8), [www.peopletrackerapp.com](http://www.peopletrackerapp.com)

## License

MEVHorizontalContacts is available under the MIT license. See the [LICENSE](https://github.com/manuelescrig/MEVHorizontalContacts/blob/master/LICENSE) file for more info.

Icons made by [Gregor Cresnar](http://www.flaticon.com/authors/gregor-cresnar) is licensed by [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0/)
