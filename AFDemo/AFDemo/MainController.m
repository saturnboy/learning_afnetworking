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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"row%d", indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d--Bacon ipsum dolor sit amet kevin fatback frankfurter, biltong kielbasa leberkas meatball pork loin. Bacon prosciutto beef ribs capicola. Shankle short ribs turducken, pork chop ham hock meatloaf capicola corned beef jerky. Spare ribs shank chicken short ribs pastrami meatball. Ribeye pancetta salami, kielbasa jerky shoulder chuck ground round venison capicola rump spare ribs bresaola jowl.", indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailPush"]) {
        NSLog(@"DetailPush");
        UITableViewCell *cell = (UITableViewCell*)sender;
        DetailController *detail = [segue destinationViewController];
        detail.title = cell.textLabel.text;
        detail.desc = cell.detailTextLabel.text;
    }
}

@end
