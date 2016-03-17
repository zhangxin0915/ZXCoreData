//
//  ViewController.m
//  ZXCoreData
//
//  Created by macmini on 16/3/16.
//  Copyright © 2016年 macmini. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManger.h"
#import "Person.h"
#import "Company.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CoreDataManger sharedInstance]insertCoreDataTest];
    [[CoreDataManger sharedInstance]queryCoreDataTest];
    [[CoreDataManger sharedInstance]deleteCoreDataTest];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
