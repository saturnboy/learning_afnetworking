//
//  DetailController.m
//  AFDemo
//
//  Created by Justin on 10/6/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "DetailController.h"

@interface DetailController ()

@end

@implementation DetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.descTxt.text = self.desc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
