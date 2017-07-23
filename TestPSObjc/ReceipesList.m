//
//  ViewController.m
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import "ReceipesList.h"
#import "RecipeModel.h"
#import "RecipeCell.h"
#import "Utils.h"
#import "Server.h"
@import SafariServices;

static NSString *const kCellReuseIdentifier = @"RecipeCell";

@interface ReceipesList ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ReceipesList {
    NSArray<RecipeModel *> *models;
    Server *server;
}

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark init table view
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 20;
    UINib *const cell = [UINib nibWithNibName:kCellReuseIdentifier bundle:nil];
    [_tableView registerNib:cell forCellReuseIdentifier:kCellReuseIdentifier];
#pragma mark init search bar
    _searchBar.delegate = self;
#pragma mark init server
    server = [[Server alloc] initWithDelegate:self];
    __weak typeof(self) const weakSelf = self;
    [server searchText:^(NSArray<RecipeModel *> *_models) {
        __strong typeof(self) const strongSelf = weakSelf;
        models = _models;
        [strongSelf.tableView reloadData];
    }];
}

# pragma mark UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeCell *const cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    cell.model = models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    RecipeModel *const model = models[indexPath.row];
    NSURL *const url = [NSURL URLWithString:model.siteURLPath];
    if(url && [[UIApplication sharedApplication] canOpenURL:url]) {
        SFSafariViewController *const controller = [[SFSafariViewController alloc] initWithURL:url];
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        NSString *const errorString = [NSString stringWithFormat:@"Can't open url %@", url];
        [Utils showText:NSLocalizedString(errorString, @"")];
    }
}

# pragma mark UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchText:) object:searchText];
    [self performSelector:@selector(searchText:) withObject:searchText afterDelay:0.5];
}

- (void) searchText:(NSString *)text {
    __weak typeof(self) const weakSelf = self;
    [server searchText:text completion:^(NSArray<RecipeModel *> *_models) {
        __strong typeof(self) const strongSelf = weakSelf;
        models = _models;
        [strongSelf.tableView reloadData];
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    return YES;
}

#pragma mark Server delegate
- (void)errorWithNSError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
}

@end
