//
//  MainViewController.h
//  dreamMaster
//
//  Created by Derek Cheung on 21/3/15.
//  Copyright (c) 2015 Derek Cheung. All rights reserved.
//

#import "GeneralViewController.h"
#import "MPLightboxViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface MainViewController : GeneralViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *dineOutContentView;
@property (strong, nonatomic) IBOutlet UICollectionView *dineOutCollectionView;

@property (strong, nonatomic) IBOutlet UICollectionView *leftCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *rightCollectionView;
@property (strong, nonatomic) IBOutlet UIButton *dineInButton;
@property (strong, nonatomic) IBOutlet UIButton *dineOutButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) IBOutlet UIView *dogContentView;

- (IBAction)dineInPressed:(id)sender;
- (IBAction)dineOutPressed:(id)sender;
- (IBAction)searchPressed:(id)sender;
- (IBAction)cartPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *feedButton;
@property (strong, nonatomic) IBOutlet UIButton *basketButton;
@property (strong, nonatomic) IBOutlet UIButton *receiptButton;
@property (strong, nonatomic) IBOutlet UIButton *msgButton;
@property (strong, nonatomic) IBOutlet UIButton *profileButton;
@property (strong, nonatomic) IBOutlet UIImageView *dineInLine;
@property (strong, nonatomic) IBOutlet UIImageView *dineOutLine;
- (IBAction)bowlPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *bowlButton;

@end
