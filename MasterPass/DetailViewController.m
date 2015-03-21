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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addToCart:(id)sender {
    Product *product = [Product new];
    [product setId:@"MikeHasAnID"];
    
    [product setDesc:@"The Description"];
    [product setImageUrl:@"http://political-science.uchicago.edu/faculty/Mike%20Albertus.jpg"];
    [product setName:@"Awesome Name!"];
    [product setPrice:[NSNumber numberWithFloat:29.99f]];
    

    MPECommerceManager *ecommerce = [MPECommerceManager sharedInstance];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ecommerce addProductToCart:product callback:^(NSError *error) {
        [MBProgressHUD HUDForView:self.view];
        
    }];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
