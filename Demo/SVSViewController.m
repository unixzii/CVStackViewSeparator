//
//  SVSViewController.m
//  CocoaTouchPlayground
//
//  Created by 杨弘宇 on 16/6/1.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

#import "SVSViewController.h"
#import "UIStackView+Separator.h"

@interface SVSViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *stackView1;
@property (weak, nonatomic) IBOutlet UIStackView *stackView2;

@end

@implementation SVSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stackView1.separatorColor = [UIColor redColor];
    self.stackView1.separatorLength = 10;
    
    self.stackView2.separatorColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.stackView2.separatorLength = 100;
}

@end
