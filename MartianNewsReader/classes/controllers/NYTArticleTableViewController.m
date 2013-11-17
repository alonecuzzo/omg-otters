//
//  NYTArticleTableViewController.m
//  MartianNewsReader
//

//  Copyright (c) 2012 The New York Times Company. All rights reserved.
//

#import "NYTArticleTableViewController.h"
#import "NYTArticleManager.h"
#import "NYTArticleDetailViewController.h"

@interface NYTArticleTableViewController ()

@property (nonatomic, strong) NYTArticleManager *articleManager;

@end

@implementation NYTArticleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.articleManager = [[NYTArticleManager alloc] init];
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [self.articleManager articleCount];
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    id article = [self.articleManager articleAtIndex:[indexPath row]];

//    [NSException raise:@"NYTNotYetImplementedException" format:@""];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NYTArticleDetailViewController *articleViewController = [[NYTArticleDetailViewController alloc] initWithArticle:
            [self.articleManager articleAtIndex:[indexPath row]]];
    [self.navigationController pushViewController:articleViewController animated:YES];
}


@end
