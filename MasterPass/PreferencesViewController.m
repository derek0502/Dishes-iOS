//
//  PreferencesViewController.m
//  MasterPass
//
//  Created by Derek Cheung on 21/3/15.
//  Copyright (c) 2015 David Benko. All rights reserved.
//

#import "PreferencesViewController.h"
#import "MainViewController.h"
#import "PreferencesButton.h"

@interface PreferencesViewController ()
{
    IBOutletCollection(UIButton) NSArray *buttons;
    int amountSelected;
}
@end

@implementation PreferencesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    amountSelected = 0;
    // Do any additional setup after loading the view from its nib.
    [self.navContainer hideByHeight:YES];
    [self.footerContainer hideByHeight:YES];
    
    for(PreferencesButton *button in buttons) {
        [button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setIsWanted:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectedButton:(id)sender {
    PreferencesButton *selectedButton = (PreferencesButton*)sender;
    if(!selectedButton.isWanted) {
        amountSelected++;
        [selectedButton setIsWanted:YES];
        [selectedButton setTitleColor:COLOR_SelectedButton forState:UIControlStateNormal];
    } else {
        amountSelected--;
        [selectedButton setIsWanted:NO];
        [selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if(amountSelected >=5) {
        [self nextPage];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)nextPage
{
    MainViewController *vc = [[MainViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
