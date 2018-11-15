//
//  ViewController.m
//  PaintView
//
//  Created by 栗子哇 on 2018/11/15.
//  Copyright © 2018 NineTon. All rights reserved.
//

#import "ViewController.h"
#import "PaintingView.h"

@interface ViewController ()

@property (nonatomic , strong) PaintingView *lView;

@end

@implementation ViewController

- (void)loadView{
    self.view = self.lView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma  mark Setter && Getter
- (PaintingView *)lView{
    if (!_lView) {
        _lView = [[PaintingView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _lView;
}


@end
