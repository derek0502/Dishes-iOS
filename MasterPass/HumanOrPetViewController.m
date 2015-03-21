//
//  HumanOrPetViewController.m
//  MasterPass
//
//  Created by Derek Cheung on 21/3/15.
//  Copyright (c) 2015 David Benko. All rights reserved.
//

#import "HumanOrPetViewController.h"
#import "PreferencesViewController.h"

@interface HumanOrPetViewController ()

@end

@implementation HumanOrPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.footerContainer hideByHeight:YES];
    [self.navContainer hideByHeight:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)nextPressed:(id)sender
{
    PreferencesViewController *vc = [[PreferencesViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
