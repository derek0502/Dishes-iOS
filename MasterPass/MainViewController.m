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
#import <MapKit/MapKit.h>
#import <XMLDictionary/XMLDictionary.h>
#import <AFNetworking/AFNetworking.h>

#define LongCellHeight 245
#define ShortCellHeight 181

@interface MainViewController ()  {
    IBOutlet UIButton *cartButton;
    NSArray *images;
    NSArray *names;
    NSArray *authors;
    UIView *restaurantView;
    

    float longi;
    float lati;
    
    IBOutlet UITableView *restaurantTableView;
    
}
@property (strong, nonatomic)  MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray *productsData;
@property (nonatomic, strong) NSArray *fullProductsData;
@property (nonatomic, strong) NSDictionary *restaurantData;
@end

@implementation MainViewController

-(void)setupLocalData {
    lati = 22.286343;
    longi = 114.190339;
    
    images = @[@"sandwich.png", @"salad.png", @"glazedtofu.png", @"friedegg.png", @"easyshrimp.png", @"creamy.png", @"classicitaliantiramisu.png"];
    
    names = @[@"Tuna Sandwich", @"Healthy Salad", @"Glazed Tofu", @"Fried Egg", @"Easy Shrimp", @"Creamy Pasta", @"Classic Italian Tiramisu"];
    
    authors = @[@"Amelia Lee", @"Mike Woodruff", @"Derek Cheung", @"Julia Wood", @"Joseph Liu", @"Kit Chan", @"Momo Woodruff"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLocalData];
    
    self.mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
    [self.mapView setDelegate:self];
    [self.dineOutContentView addSubview:self.mapView];
    CLLocationCoordinate2D coord = {.latitude =  lati, .longitude =  longi};
    MKCoordinateSpan span = {.latitudeDelta =  0.01, .longitudeDelta =  0.01};
    MKCoordinateRegion region = {coord, span};
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    point.coordinate = coord;
    [point setTitle:@"YOU ARE HERE"];
    [self.mapView addAnnotation:point];
    [self.mapView setRegion:region];
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
    
    if([collectionView isEqual:self.rightCollectionView]) {
        return 3;
    } else if([collectionView isEqual:self.leftCollectionView]) {
        return 4;
    }
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
        UIButton *heartButton = (UIButton*)[cell.contentView viewWithTag:4];
        [heartButton addTarget:self action:@selector(pressedHeart:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
        [imageView setImage:[UIImage imageNamed:[images objectAtIndex:indexPath.row]]];
        
        UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
        [nameLabel setText:[names objectAtIndex:indexPath.row]];

        UILabel *authorLabel = (UILabel *)[cell.contentView viewWithTag:3];
        [authorLabel setText:[authors objectAtIndex:indexPath.row]];
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
        
        UIButton *heartButton = (UIButton*)[cell.contentView viewWithTag:4];
        [heartButton addTarget:self action:@selector(pressedHeart:) forControlEvents:UIControlEventTouchUpInside];

        UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
        [imageView setImage:[UIImage imageNamed:[images objectAtIndex:indexPath.row+3]]];
        
        UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:2];
        [nameLabel setText:[names objectAtIndex:indexPath.row+3]];
        
        UILabel *authorLabel = (UILabel *)[cell.contentView viewWithTag:3];
        [authorLabel setText:[authors objectAtIndex:indexPath.row+3]];
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
    DetailViewController *dvc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:dvc animated:YES];
    
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
    
    //Get Lat and Long...;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer * requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer * responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *ua = @"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25";
    [requestSerializer setValue:ua forHTTPHeaderField:@"User-Agent"];
    //    [requestSerializer setValue:@"application/xml" forHTTPHeaderField:@"Content-type"];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", nil];
    manager.responseSerializer = responseSerializer;
    manager.requestSerializer = requestSerializer;
    
    [manager POST:@"http://smartkalkyl.se/rateapp.aspx?user=xxxxx&pass=xxxxxx"
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData * data = (NSData *)responseObject;
              self.restaurantData = [[XMLDictionaryParser sharedInstance]dictionaryWithData:data];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
    
}


- (IBAction)searchPressed:(id)sender {

}

-(void)pressedHeart:(id)sender {
    UIButton *heartButton = (UIButton*)sender;
    if(!heartButton.selected) {
        [heartButton setBackgroundImage:[UIImage imageNamed:@"heartup.png"] forState:UIControlStateNormal];
        [heartButton setSelected:YES];
    } else {
        [heartButton setBackgroundImage:[UIImage imageNamed:@"heartdown.png"] forState:UIControlStateNormal];
        [heartButton setSelected:NO];
    }
}


#pragma mark - ---table view---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    [cell.textLabel setText:@"GREAT"];
//    NSInteger section = [indexPath section];
//    
//    switch (section) {
//        case 0: // First cell in section 1
//            cell.textLabel.text = [collectionHelpTitles objectAtIndex:[indexPath row]];
//            break;
//        case 1: // Second cell in section 1
//            cell.textLabel.text = [noteHelpTitles objectAtIndex:[indexPath row]];
//            break;
//        case 2: // Third cell in section 1
//            cell.textLabel.text = [checklistHelpTitles objectAtIndex:[indexPath row]];
//            break;
//        case 3: // Fourth cell in section 1
//            cell.textLabel.text = [photoHelpTitles objectAtIndex:[indexPath row]];
//            break;
//        default:
//            // Do something else here if a cell other than 1,2,3 or 4 is requested
//            break;
//    }
    return cell;
}

@end
