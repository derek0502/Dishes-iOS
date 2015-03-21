//
//  MainViewController.m
//  dreamMaster
//
//  Created by Derek Cheung on 21/3/15.
//  Copyright (c) 2015 Derek Cheung. All rights reserved.
//

#import "MainViewController.h"
#import "MPManager.h"
#import "DetailViewController.h"
#import "MPECommerceManager.h"

@interface MainViewController ()
@property (nonatomic, strong) NSArray *productsData;
@property (nonatomic, strong) NSArray *fullProductsData;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.titleLabel setText:@"Hello"];
    [self.leftCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.rightCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    [self.dineOutCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.dineOutContentView setHidden:YES];
    [self.contentContainer addSubview:self.dineOutContentView];
    [self addConstraintForViewToContainer:self.dineOutContentView];
    
    [self.dineInButton setSelected:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self fullInventory:^(NSArray *products) {
        self.productsData = [NSArray arrayWithArray:products];
        self.fullProductsData = [NSArray arrayWithArray:products];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.leftCollectionView reloadData];
        [self.rightCollectionView reloadData];
    }];
}

-(void)fullInventory:(void (^)(NSArray *products))callback{
    MPECommerceManager *manager = [MPECommerceManager sharedInstance];
    [manager getAllProducts:callback];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = (UICollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.leftCollectionView)
    {
        return CGSizeMake(collectionView.frame.size.width-15, 90.f);
    }
    else if(collectionView == self.rightCollectionView)
    {
        return CGSizeMake(collectionView.frame.size.width-15, 120.f);
    }
    else
    {
        return CGSizeMake(collectionView.frame.size.width, 80.f);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == self.leftCollectionView)
    {
        self.rightCollectionView.contentOffset = self.leftCollectionView.contentOffset;
    }
    else if(scrollView ==self.rightCollectionView)
    {
        self.leftCollectionView.contentOffset = self.rightCollectionView.contentOffset;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *dvc = [DetailViewController new];
    [self presentViewController:dvc animated:YES completion:nil];
}

- (IBAction)dineInPressed:(id)sender {
    [self.dineInButton setSelected:YES];
    [self.dineOutButton setSelected:NO];
    [self.contentView setHidden:NO];
    [self.dineOutContentView setHidden:YES];
}

- (IBAction)dineOutPressed:(id)sender {
    [self.dineInButton setSelected:NO];
    [self.dineOutButton setSelected:YES];
    [self.contentView setHidden:YES];
    [self.dineOutContentView setHidden:NO];
}

- (IBAction)searchPressed:(id)sender {
}
@end
