//
//  NYTAppDelegate.m
//  MartianNewsReader
//

//  Copyright (c) 2012 The New York Times Company. All rights reserved.
//

#import "NYTAppDelegate.h"

#import "NYTArticleTableViewController.h"
#import "NYTArticleManager.h"

@implementation NYTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    NYTArticleManager *manager = [[NYTArticleManager alloc] init];


    [[manager retrieveArticles] subscribeCompleted:^{
        NSLog(@"LOLOLZ");
    }];


    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[UINavigationController alloc] initWithRootViewController:[
                    [NYTArticleTableViewController alloc] initWithStyle:UITableViewStylePlain]];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
