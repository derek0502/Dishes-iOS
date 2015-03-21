//
//  ShortCollectionViewCell.h
//  MasterPass
//
//  Created by Derek Cheung on 22/3/15.
//  Copyright (c) 2015 David Benko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShortFeedCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;

@end
