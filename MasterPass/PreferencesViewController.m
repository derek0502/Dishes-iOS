//
//  PreferencesViewController.m
//  MasterPass
//
//  Created by Derek Cheung on 21/3/15.
//  Copyright (c) 2015 David Benko. All rights reserved.
//

#import "PreferencesViewController.h"
#import "MainViewController.h"

@interface PreferencesViewController ()

@end

@implementation PreferencesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navContainer hideByHeight:YES];
    [self.footerContainer hideByHeight:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)nextPressed:(id)sender
{
    MainViewController *vc = [[MainViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
