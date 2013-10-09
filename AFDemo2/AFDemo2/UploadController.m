//
//  UploadController.m
//  AFDemo
//
//  Created by Justin on 10/6/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "UploadController.h"
#import "AFNetworking.h"

@interface UploadController ()

@end

@implementation UploadController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextView delegates

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"description..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        textView.text = @"description...";
        textView.textColor = [UIColor colorWithWhite:0.67f alpha:1.0f];
    }
    [textView resignFirstResponder];
}

#pragma mark - Pic Button

-(IBAction) picClicked:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Picker: no camera");
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"Picker: selected");
	[picker dismissViewControllerAnimated:YES completion:nil];
	self.picImg.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.picBtn.hidden = YES;
    self.picImg.hidden = NO;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"Picker: cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.picBtn.hidden = NO;
    self.picImg.hidden = YES;
}

#pragma mark - Send Button

-(IBAction) sendClicked:(id)sender {
    NSLog(@"SEND!");

    UIBarButtonItem *orig = self.navigationItem.rightBarButtonItem;
    UIActivityIndicatorView *uploading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    uploading.hidesWhenStopped = YES;
    [uploading startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:uploading];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSDictionary *params = @{ @"title":self.titleTxt.text,
                           @"desc":([self.descTxt.text isEqualToString:@"description..."] ? @"" : self.descTxt.text) };
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer]
                             multipartFormRequestWithMethod:@"POST"
                             URLString:@"http://saturnboy.com/afnetworking/upload.php"
                             parameters:params
                             constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

         NSData *dat = UIImageJPEGRepresentation(self.picImg.image, 1.0f);
         [formData appendPartWithFileData:dat name:@"pic" fileName:@"tmp.jpg" mimeType:@"image/jpeg"];
    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Upload: success! resp=%@", responseObject);
        
        //re-init view
        [uploading stopAnimating];
        self.navigationItem.rightBarButtonItem = orig;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.titleTxt.text = @"";
        self.descTxt.text = @"description...";
        self.picBtn.hidden = NO;
        self.picImg.hidden = YES;
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Upload: err=%@", error);
        [uploading stopAnimating];
        self.navigationItem.rightBarButtonItem = orig;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
    
    [operation start];
}

@end
