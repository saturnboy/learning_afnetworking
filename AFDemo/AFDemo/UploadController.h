//
//  UploadController.h
//  AFDemo
//
//  Created by Justin on 10/6/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *descTxt;
@property (nonatomic, weak) IBOutlet UIButton *picBtn;
@property (nonatomic, weak) IBOutlet UIImageView *picImg;

-(IBAction) picClicked:(id)sender;
-(IBAction) sendClicked:(id)sender;

@end
