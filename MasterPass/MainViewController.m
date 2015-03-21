//
//  MainViewController.m
//  dreamMaster
//
//  Created by Derek Cheung on 21/3/15.
//  Copyright (c) 2015 Derek Cheung. All rights reserved.
//

#import "MainViewController.h"
#import "MPManager.h"
#import "MPLightboxViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.titleLabel setText:@"Hello"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loadMasterPass:(id)sender {
    
    MPLightboxViewController *lightboxViewController = [[MPLightboxViewController alloc]init];
    
    NSDictionary *lightBoxParams = @{@"requestToken":@"3DIWiJjAC8vTIcrwkFuOqHxAwWdsr5bRZlCHFNgTb9a7626b!414969684342562b53374f47485157794272354a6d55773d",
                                     @"merchantCheckoutId":@"a466w4xy5ex04i2z936ao1i3adi17b1jpd",
                                     @"requestedDataTypes":@[@"CARD", @"ADDRESS", @"PROFILE"],
                                     @"callbackUrl":@"http://mikeisgreat.com",
                                     @"pairingRequestToken":@"0d6b4de661b5627af734da118ea4ebae4a7f9779",
                                     @"allowedCardTypes":@[@"amex", @"discover", @"master", @"maestro"],
                                     @"requestPairing":@1,
                                     @"version":@"v6"};
    
    lightboxViewController.delegate = self;
    [self presentViewController:lightboxViewController animated:YES completion:^{
        [lightboxViewController initiateLightBoxOfType:MPLightBoxTypePreCheckout WithOptions:lightBoxParams];
    }];
}

-(void)pairingView:(MPLightboxViewController *)pairingViewController didCompletePairing:(BOOL)success error:(NSError *)error {
    //Add code for completing pairing lightbox
}

-(void)lightBox:(MPLightboxViewController *)lightBoxViewController didCompletePreCheckout:(BOOL)success data:(NSDictionary *)data error:(NSError *)error {
    //Add code for completing precheckout lighbox
}

-(void)lightBox:(MPLightboxViewController *)pairingViewController didCompleteCheckout:(BOOL)success error:(NSError *)error {
    //Add code for completion of checkout lightbox
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
