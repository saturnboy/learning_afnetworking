//
//  MainController.m
//  AFDemo
//
//  Created by Justin on 10/6/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "MainController.h"
#import "DetailController.h"

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
    
    //dummy data
    self.pics = @[
                  @{ @"title":@"my title", @"desc":@"my desc" },
                  @{ @"title":@"other title", @"desc":@"other desc" },
                  ];

    //setup refresh control
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
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
    cell.textLabel.text = self.pics[indexPath.row][@"title"];
    cell.detailTextLabel.text = self.pics[indexPath.row][@"desc"];
    
    return cell;
}

#pragma mark - Pull to refresh

- (void)refresh:(id)sender {
    NSLog(@"Refresh");
    
    //add mock data
    NSString *title2 = [NSString stringWithFormat:@"new title %d", self.pics.count + 1];
    NSString *desc2 = [NSString stringWithFormat:@"new desc %d", self.pics.count + 1];
    NSMutableArray *p2 = [self.pics mutableCopy];
    p2[p2.count] = @{ @"title":title2, @"desc":desc2 };
    self.pics = [NSArray arrayWithArray:p2];
    
    //refresh the table
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
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
