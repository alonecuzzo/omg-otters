//
//  NYTArticleTableViewController.m
//  MartianNewsReader
//

//  Copyright (c) 2012 The New York Times Company. All rights reserved.
//

#import "NYTArticleTableViewController.h"
#import "NYTArticleManager.h"
#import "NYTArticleDetailViewController.h"
#import "NYTArticle.h"
#import "NYTArticleImage.h"
#import "NYTTranslationManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NYTArticleTableViewController ()

@property (nonatomic, strong) NYTArticleManager *articleManager;
@property (nonatomic) UIView *preloader;

@end

@implementation NYTArticleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _articleManager = [[NYTArticleManager alloc] init];
        [[NYTTranslationManager sharedInstance] setArticleManager:_articleManager];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak id weakSelf = self;
    dispatch_queue_t bkgrndQueue = dispatch_queue_create("com.nytimes", 0);
    dispatch_async(bkgrndQueue, ^{
        [weakSelf refreshArticles];
    });
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)refreshArticles
{
    __weak id weakSelf = self;
    [[_articleManager retrieveArticles] subscribeCompleted:^{
        [[weakSelf tableView] reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.articleManager articleCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NYTArticle *article = [self.articleManager articleAtIndex:[indexPath row]];
    
    cell.textLabel.text = [[NYTTranslationManager sharedInstance] translateText:article.title forIndex:[indexPath row] andType:NYTLabelTypeTitle];

    [cell.imageView setImageWithURL:article.image.url placeholderImage:[UIImage imageNamed:@"placeholder"]];

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
