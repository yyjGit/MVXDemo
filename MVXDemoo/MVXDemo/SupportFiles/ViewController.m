//
//  ViewController.m
//  MVXDemo
//
//  Created by YangYongJie on 2019/3/5.
//  Copyright © 2019年 yyj. All rights reserved.
//

#import "ViewController.h"

#import "MVCUserViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MVC:(UIButton *)sender
{
    [self.navigationController pushViewController:[MVCUserViewController instanceWithUserId:sender.tag] animated:YES];
}

@end
