//
//  DetailController.m
//  AFDemo
//
//  Created by Justin on 10/6/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "DetailController.h"
#import "UIImageView+AFNetworking.h"

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
    
    //setup view
    NSLog(@"pic=%@", self.pic);
    self.title = ([self.pic[@"title"] length] > 0 ? self.pic[@"title"] : @"<title>");;
	self.descTxt.text = ([self.pic[@"desc"] length] > 0 ? self.pic[@"desc"] : @"<desc>");
    
    NSURL *picUrl = [NSURL URLWithString:[@"http://saturnboy.com/afnetworking/" stringByAppendingString:self.pic[@"pic"]]];
    [self.picImg setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"BigHolder"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
