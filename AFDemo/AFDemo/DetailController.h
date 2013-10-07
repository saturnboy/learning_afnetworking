//
//  DetailController.h
//  AFDemo
//
//  Created by Justin on 10/6/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailController : UIViewController

@property (nonatomic,weak) IBOutlet UITextView *descTxt;
@property (nonatomic,weak) IBOutlet UIImageView *picImg;

@property (nonatomic,weak) NSString *desc;

@end
