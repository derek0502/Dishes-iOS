//
//  MainViewController.m
//  dreamMaster
//
//  Created by Derek Cheung on 21/3/15.
//  Copyright (c) 2015 Derek Cheung. All rights reserved.
//

#import "MainViewController.h"
#import "MPManager.h"
#import "LongFeedCollectionViewCell.h"
#import "ShortFeedCollectionViewCell.h"
#import "DetailViewController.h"
#import "MPECommerceManager.h"
#import "CartViewController.h"

#define LongCellHeight 245
#define ShortCellHeight 181

@interface MainViewController () {
    IBOutlet UIButton *cartButton;
}
@property (nonatomic, strong) NSArray *productsData;
@property (nonatomic, strong) NSArray *fullProductsData;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [cartButton setHidden:YES];
    // Do any additional setup after loading the view from its nib.
    [self.titleLabel setText:@"Hello"];
    [self.leftCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ShortFeedCollectionViewCell"];
    [self.rightCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"LongFeedCollectionViewCell"];
    
    
    [self.dineOutCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.dineOutContentView setHidden:YES];
    [self.contentContainer addSubview:self.dineOutContentView];
    [self addConstraintForViewToContainer:self.dineOutContentView];
    
    [self.dineInButton setSelected:YES];
    
    __block int callsComplete = 0;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self fullInventory:^(NSArray *products) {
        self.productsData = [NSArray arrayWithArray:products];
        self.fullProductsData = [NSArray arrayWithArray:products];
        [self.leftCollectionView reloadData];
        [self.rightCollectionView reloadData];
        callsComplete++;
        if(callsComplete >= 2) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
    
    MPECommerceManager *ecommerce = [MPECommerceManager sharedInstance];
    [ecommerce getCurrentCart:^(OrderHeader *header, NSArray *cart) {
        if(!cart || cart.count == 0) {
            [cartButton setHidden:YES];
        } else {
            [cartButton setHidden:NO];
        }
        callsComplete++;
        if(callsComplete >= 2) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
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
    UICollectionViewCell *cell;
    
    if(collectionView == self.rightCollectionView)
    {
        NSString *identifier = @"LongFeedCollectionViewCell";
        
        static BOOL nibMyCellloaded = NO;
        
        if(!nibMyCellloaded)
        {
            UINib *nib = [UINib nibWithNibName:@"LongFeedCollectionViewCell" bundle: nil];
            [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
            nibMyCellloaded = YES;
        }
        cell = (LongFeedCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"LongFeedCollectionViewCell" forIndexPath:indexPath];
        
        
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
        
        UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
        
        UILabel *authorLabel = (UILabel *)[cell.contentView viewWithTag:3];

        
        
    }
    else if(collectionView == self.leftCollectionView)
    {
        NSString *identifier = @"ShortFeedCollectionViewCell";
        
        static BOOL nibMyCellloaded = NO;
        
        if(!nibMyCellloaded)
        {
            UINib *nib = [UINib nibWithNibName:@"ShortFeedCollectionViewCell" bundle: nil];
            [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
            nibMyCellloaded = YES;
        }
        cell = (ShortFeedCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ShortFeedCollectionViewCell" forIndexPath:indexPath];
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
        
        UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
        
        UILabel *authorLabel = (UILabel *)[cell.contentView viewWithTag:3];
    }
    else
    {
        cell = (UICollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    }
        
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.leftCollectionView)
    {
        return CGSizeMake(collectionView.frame.size.width-15, ShortCellHeight);
    }
    else if(collectionView == self.rightCollectionView)
    {
        return CGSizeMake(collectionView.frame.size.width-15, LongCellHeight);
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

- (IBAction)cartPressed:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CartViewController *cvc = [sb instantiateViewControllerWithIdentifier:@"CartViewController"];
    [self presentViewController:cvc animated:YES completion:nil];
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
