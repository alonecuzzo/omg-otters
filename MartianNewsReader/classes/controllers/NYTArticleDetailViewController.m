//
//  NYTArticleDetailViewController.m
//  MartianNewsReader
//

//  Copyright (c) 2012 The New York Times Company. All rights reserved.
//

#import "NYTArticleDetailViewController.h"
#import "NYTArticle.h"
#import "UIImageView+WebCache.h"
#import "NYTArticleImage.h"
#import "NYTTranslationManager.h"

@interface NYTArticleDetailViewController ()

@property(nonatomic, strong) NYTArticle *article;
@property(nonatomic) UIImageView *imageView;
@property(nonatomic) UILabel *articleLabel;
@property(nonatomic) UILabel *titleLabel;
@property(nonatomic) UIScrollView *scrollView;

@end

@implementation NYTArticleDetailViewController

- (NYTArticleDetailViewController *)initWithArticle:(NYTArticle*)anArticle
{
    self = [super init];
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        [self.scrollView setUserInteractionEnabled:YES];
        [self.view addSubview:self.scrollView];
        [self.scrollView setAlpha:0];
        
        self.article = anArticle;
        self.view.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        [self.scrollView addSubview:self.imageView];
        
        self.articleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.frame.size.height + 70, self.view.frame.size.width, FLT_MAX)];
        self.articleLabel.backgroundColor = [UIColor clearColor];
        self.articleLabel.text = [self translateText:anArticle.body forIndex:anArticle.index andType:NYTLabelTypeBody];
        self.articleLabel.numberOfLines = 0;
        [self.scrollView addSubview:self.articleLabel];
        [self resetArticleLabelFrame];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.frame.size.height + 5, self.view.frame.size.width, 50)];
        self.titleLabel.text = [self translateText:anArticle.title forIndex:anArticle.index andType:NYTLabelTypeTitle];
        [self.scrollView addSubview:self.titleLabel];
        
        NSString *buttonTitle = [self getTranslateButtonTitle];
        __weak id weakSelf = self;
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:buttonTitle style:UIBarButtonItemStyleDone target:nil action:nil];
        rightButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            [[NYTTranslationManager sharedInstance] toggleMartianTranslation];
            rightButton.title = [weakSelf getTranslateButtonTitle];
            [weakSelf articleLabel].text = [weakSelf translateText:[weakSelf articleLabel].text forIndex:[weakSelf article].index andType:NYTLabelTypeBody];
            [weakSelf titleLabel].text = [weakSelf translateText:[weakSelf titleLabel].text forIndex:[weakSelf article].index andType:NYTLabelTypeTitle];
            [weakSelf resetArticleLabelFrame];
            return [RACSignal empty];
        }];
        
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    return self;
}

- (NSString*)translateText:(NSString*)text forIndex:(uint)index andType:(NYTLabelType)labelType
{
    return [[NYTTranslationManager sharedInstance] translateText:text forIndex:index andType:labelType];
}

- (void)resetArticleLabelFrame
{
    CGSize articleSize = [self.articleLabel.text sizeWithFont:self.articleLabel.font constrainedToSize:CGSizeMake(self.view.frame.size.width, FLT_MAX) lineBreakMode:self.articleLabel.lineBreakMode];
    CGRect newFrame = self.articleLabel.frame;
    newFrame.size.height = articleSize.height;
    newFrame.origin.y = _imageView.frame.size.height + 70;
    self.articleLabel.frame = newFrame;
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.imageView.frame.size.height + self.articleLabel.frame.size.height + 90)];
}

- (NSString*)getTranslateButtonTitle
{
    NSString *const kTranslateMartianString = @"Translate: Martian";
    NSString *const kTranslateEnglishString = @"Translate: English";
    return ([[NYTTranslationManager sharedInstance] isMartian]) ? kTranslateMartianString : kTranslateEnglishString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    __weak id weakSelf = self;
    [self.imageView setImageWithURL:self.article.image.url placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [UIView animateWithDuration:0.3f animations:^{
            [weakSelf scrollView].alpha = 1.0;
        }];
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
