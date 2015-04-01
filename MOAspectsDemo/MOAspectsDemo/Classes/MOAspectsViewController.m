//
//  MOAspectsViewController.m
//  MOAspectsDemo
//
//  Created by Hiromi Motodera on 2015/03/27.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import "MOAspectsViewController.h"

#import "MOAspects.h"

@interface MOAspectsViewController ()

@end

@implementation MOAspectsViewController

#pragma mark - Initialize

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Demo";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - Property

- (UILabel *)aspectsLogView
{
    if (!_aspectsLogView) {
        _aspectsLogView = [[UILabel alloc] init];
        _aspectsLogView.backgroundColor = [UIColor blackColor];
        _aspectsLogView.textColor = [UIColor whiteColor];
        _aspectsLogView.font = [UIFont boldSystemFontOfSize:15.f];
    }
    return _aspectsLogView;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.aspectsLogView];
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.aspectsLogView.frame = (CGRect) {
        .origin = CGPointMake(0,
                              self.view.bounds.size.height - 50.f),
        .size = CGSizeMake(self.view.bounds.size.width,
                           50.f)
    };
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
