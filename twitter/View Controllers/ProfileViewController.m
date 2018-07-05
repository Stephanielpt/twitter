//
//  ProfileViewController.m
//  twitter
//
//  Created by Stephanie Lampotang on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profilePic.layer.cornerRadius = 30;
    self.profilePic.layer.borderWidth = 3.0;
    self.profilePic.layer.borderColor = [UIColor whiteColor].CGColor;
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

@end
