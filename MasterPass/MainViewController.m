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
@property (nonatomic, strong) NSArray *restaurants;
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
    
    [self.dineInButton setTintColor:[UIColor whiteColor]];
    [self.dineOutButton setTintColor:[UIColor whiteColor]];
    [self.dineInButton setTitleColor:COLOR_GreyText forState:UIControlStateNormal];
    [self.dineInButton setTitleColor:COLOR_OrangeText forState:UIControlStateSelected];
    [self.dineOutButton setTitleColor:COLOR_GreyText forState:UIControlStateNormal];
    [self.dineOutButton setTitleColor:COLOR_OrangeText forState:UIControlStateSelected];
    [self.dineInLine setHidden:NO];
    [self.dineOutLine setHidden:YES];
  
    UIImage *image = [UIImage imageNamed:@"feedup.png"];
    [_feedButton setImage:image forState:UIControlStateNormal];
    image = [UIImage imageNamed:@"basketup.png"];
    [_basketButton setImage:image forState:UIControlStateNormal];
    image = [UIImage imageNamed:@"recipeup.png"];
    [_receiptButton setImage:image forState:UIControlStateNormal];
    image = [UIImage imageNamed:@"msgup.png"];
    [_msgButton setImage:image forState:UIControlStateNormal];
    image = [UIImage imageNamed:@"profileup.png"];
    [_profileButton setImage:image forState:UIControlStateNormal];
    
    image = [UIImage imageNamed:@"feeddown.png"];
    [_feedButton setImage:image forState:UIControlStateSelected];
    image = [UIImage imageNamed:@"basketdown.png"];
    [_basketButton setImage:image forState:UIControlStateSelected];
    image = [UIImage imageNamed:@"recipedown.png"];
    [_receiptButton setImage:image forState:UIControlStateSelected];
    image = [UIImage imageNamed:@"msgup.png"];
    [_msgButton setImage:image forState:UIControlStateSelected];
    image = [UIImage imageNamed:@"profiledown.png"];
    [_profileButton setImage:image forState:UIControlStateSelected];
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
        [nameLabel setFont:[UIFont fontWithName:FONT_UniversLTStd size:nameLabel.font.pointSize]];

        UILabel *authorLabel = (UILabel *)[cell.contentView viewWithTag:3];
        [authorLabel setText:[authors objectAtIndex:indexPath.row]];
        [authorLabel setFont:[UIFont fontWithName:FONT_UniversLTStd size:authorLabel.font.pointSize]];
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
        [nameLabel setFont:[UIFont fontWithName:FONT_UniversLTStd size:nameLabel.font.pointSize]];
        
        
        UILabel *authorLabel = (UILabel *)[cell.contentView viewWithTag:3];
        [authorLabel setText:[authors objectAtIndex:indexPath.row+3]];
        [authorLabel setFont:[UIFont fontWithName:FONT_UniversLTStd size:authorLabel.font.pointSize]];
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
    
    //doesn't matter which product we add as backend is hidden from user..
    
    int randNum = rand() % (self.productsData.count - 0) + 0; //create the random number.
    
    dvc.detailedProduct = [self.productsData objectAtIndex:randNum];
    
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
    [self.dineInLine setHidden:NO];
    [self.dineOutLine setHidden:YES];
}

- (IBAction)dineOutPressed:(id)sender {
    [self.dineInButton setSelected:NO];
    [self.dineOutButton setSelected:YES];
    [self.contentView setHidden:YES];
    [self.dineOutContentView setHidden:NO];
    [self.dineInLine setHidden:YES];
    [self.dineOutLine setHidden:NO];
    
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
    
    NSString *getReq = [NSString stringWithFormat:@"http://dmartin.org:8021/restaurants/v1/restaurant?Format=XML&PageOffset=0&PageLength=10&Latitude=%f&Longitude=%f",lati, longi];
    [manager GET:getReq
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData * data = (NSData *)responseObject;
              self.restaurantData = [[XMLDictionaryParser sharedInstance]dictionaryWithData:data];
              self.restaurants = [self.restaurantData valueForKey:@"Restaurant"];
              [restaurantTableView reloadData];
              [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    if(self.restaurantData) {
        return 5;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 130)];
    switch(indexPath.row) {
        case 0:
            [iv setImage:[UIImage imageNamed:@"restaurantF-VeggieSF.png"]];
            break;
        case 1:
            [iv setImage:[UIImage imageNamed:@"restaurantE-PureVeggieHouse.png"]];
            break;
        case 2:
            [iv setImage:[UIImage imageNamed:@"restaurantC-Locofama.png"]];
            break;
        case 3:
            [iv setImage:[UIImage imageNamed:@"restaurantB-Herbivores.png"]];
            break;
        case 4:
            [iv setImage:[UIImage imageNamed:@"restaurantA-Finds.png"]];
            break;
    }

    [cell.contentView addSubview:iv];
    return cell;
}

@end
