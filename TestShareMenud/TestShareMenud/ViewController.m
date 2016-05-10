//
//  ViewController.m
//  TestShareMenud
//
//  Created by zc on 16/4/29.
//  Copyright © 2016年 56dian. All rights reserved.
//

#import "ViewController.h"
#import "ShareViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
}


- (IBAction)modalBtnClick:(id)sender {
    ShareLinkInfo *info = [[ShareLinkInfo alloc]init];
    info.title = @"0000";
    info.desc = @"1111";
    info.link = @"www.hao123.com";
    [ShareViewController share:info inViewController:self];
}

@end
