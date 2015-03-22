//
//  DetailViewController.m
//  MasterPass
//
//  Created by Mike on 22/3/15.
//  Copyright (c) 2015 David Benko. All rights reserved.
//

#import "DetailViewController.h"
#import <APSDK/Product.h>
#import "MPECommerceManager.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.footerContainer hideByHeight:YES];
    [_myScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 3812)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addToCart:(id)sender {
    MPECommerceManager *ecommerce = [MPECommerceManager sharedInstance];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ecommerce addProductToCart:self.detailedProduct callback:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    [_numberLabel setText:@"2"];
    
//    @property (nonatomic, strong) NSString * desc;
//    /*!
//     @var imageUrl
//     @abstract Generated model property: image_url.
//     */
//    @property (nonatomic, strong) NSString * imageUrl;
//    /*!
//     @var name
//     @abstract Generated model property: name.
//     */
//    @property (nonatomic, strong) NSString * name;
//    /*!
//     @var price
//     @abstract Generated model property: price.
//     */
//    @property (nonatomic, strong) NSNumber * price;
//    
//    /*!
//     @var orderDetails
//     @abstract Generated property for has-many relationship to orderDetails.
//     */
//    @property (nonatomic, strong) NSOrderedSet * orderDetails;
    
    
}


@end
