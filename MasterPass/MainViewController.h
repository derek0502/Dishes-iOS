//
//  MainViewController.h
//  dreamMaster
//
//  Created by Derek Cheung on 21/3/15.
//  Copyright (c) 2015 Derek Cheung. All rights reserved.
//

#import "GeneralViewController.h"
#import "MPLightboxViewController.h"

@interface MainViewController : GeneralViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIView *dineOutContentView;
@property (strong, nonatomic) IBOutlet UICollectionView *dineOutCollectionView;

@property (strong, nonatomic) IBOutlet UICollectionView *leftCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *rightCollectionView;
@property (strong, nonatomic) IBOutlet UIButton *dineInButton;
@property (strong, nonatomic) IBOutlet UIButton *dineOutButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;


- (IBAction)dineInPressed:(id)sender;
- (IBAction)dineOutPressed:(id)sender;
- (IBAction)searchPressed:(id)sender;
- (IBAction)cartPressed:(id)sender;

@end
