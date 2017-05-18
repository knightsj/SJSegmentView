//
//  ViewController.m
//  SJSegmentView
//
//  Created by Sun Shijie on 2017/5/17.
//  Copyright © 2017年 Shijie. All rights reserved.
//

#import "ViewController.h"
#import "SJSegmentView.h"

@interface ViewController ()<SJSegmentViewDelegate,SJSegmentViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    SJSegmentView *segView = [[SJSegmentView alloc] initWithFrame:CGRectMake(-1, 20, self.view.bounds.size.width + 2, 30) titles:@[@"消息",@"记录",@"sdfsd",@"sdfsd"] font:[UIFont systemFontOfSize:16]];
    segView.sjDelegate = self;
    segView.sjDataSource = self;
    
    [self.view addSubview:segView];
    
}

#pragma mark- SJSegmentViewDataSource
- (UIColor *)selectedBgColor{
    return [UIColor redColor];
}

#pragma mark- SJSegmentViewDelegate
- (void)didSelectedIndex:(NSUInteger)index
{
    NSLog(@"did selected index : %ld",index);
}


@end
