//
//  MainController.m
//  AFDemo
//
//  Created by Justin on 10/6/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "MainController.h"
#import "DetailController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface MainController ()

@end

@implementation MainController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init data
    self.pics = nil;

    //setup refresh control
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (self.pics ? 1 : 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([self.pics count] ? [self.pics count] : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //setup cell
    NSDictionary *pic = self.pics[indexPath.row];
    cell.textLabel.text = pic[@"title"];
    cell.detailTextLabel.text = pic[@"desc"];
    
    NSURL *url = [NSURL URLWithString:[@"http://saturnboy.com/afnetworking/" stringByAppendingString:pic[@"pic"]]];
    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LittleHolder"]];
    
    return cell;
}

#pragma mark - Pull to refresh

- (void)refresh:(id)sender {
    NSURL *URL = [NSURL URLWithString:@"http://saturnboy.com/afnetworking/list.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Refresh");
        self.pics = responseObject;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Refresh: err=%@", error);
        [self.refreshControl endRefreshing];
    }];
    
    [operation start];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailPush"]) {
        NSLog(@"DetailPush");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailController *detail = [segue destinationViewController];
        detail.pic = self.pics[indexPath.row];
    }
}

@end
