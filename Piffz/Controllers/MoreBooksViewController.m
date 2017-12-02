//
//  MoreBooksViewController.m
//  Piffz
//
//  Created by AppsCreationTech on 4/7/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreBooksViewController.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "MoreBooksModel.h"

BOOL refreshISOn;
BOOL loadMoreISOn;
NSInteger pageNumber;

@interface MoreBooksViewController ()
{
    NSMutableArray* titleArray;
    NSMutableArray* linkArray;
    NSMutableArray* showBooksArray;
}

@property (strong, nonatomic) NSMutableArray *fakeColors;

@end

@implementation MoreBooksViewController

@synthesize m_lblMoreBooks, m_lblDescription;
@synthesize m_btnBackHome;
@synthesize m_viewBooks;
@synthesize m_collectionView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    refreshISOn = true;
    loadMoreISOn = false;
    
    pageNumber = 0;
    
    m_lblMoreBooks.font = m_fontTitle;
    
    [m_btnBackHome.titleLabel setFont:m_fontHomeButton];
    
    m_viewBooks.layer.cornerRadius = 15;
//    m_viewBooks.layer.shadowOpacity = 0.5;
//    m_viewBooks.layer.shadowRadius = 5.0f;
//    m_viewBooks.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    
    moreBooksArray = [[NSMutableArray alloc] init];
    showBooksArray = [[NSMutableArray alloc] init];
    
    titleArray = [[NSMutableArray alloc] init];
    linkArray = [[NSMutableArray alloc] init];
    
    [self addHeader];
    [self addFooter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)loadMoreBooks
{
    NSString* appId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *currentSysVersion = [[UIDevice currentDevice] systemVersion];
    
    NSDictionary* parameters = @{
                                 key_app_ID:appId,
                                 key_device_OS:currentSysVersion
                                 };
    
    AFHTTPClient* httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:MoreBooks_URL]];
    
    [httpClient getPath:MoreBooks_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id response) {
        
        NSMutableArray* responseObject = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:nil];
        NSLog(@"loadMorebooks response --> %@", [responseObject description]);
        
        for (int i = 0; i < [responseObject count]; i++) {

            MoreBooksModel* moreBooksModel = [[MoreBooksModel alloc] init];
            
            NSDictionary* bookDictionary = responseObject[i];
            
            NSString* book_title = [bookDictionary objectForKey:@"title"];
            NSString* book_price = [bookDictionary objectForKey:@"price"];
            NSString* book_link = [bookDictionary objectForKey:@"store_link"];
            NSString* book_description = [bookDictionary objectForKey:@"description"];
            NSString* book_image = [bookDictionary objectForKey:@"image"];
            
            moreBooksModel.title = book_title;
            moreBooksModel.price = book_price;
            moreBooksModel.storelink = book_link;
            moreBooksModel.bookdescription = book_description;
            moreBooksModel.image = book_image;
            
            book_image = @"http://static2.dmcdn.net/static/video/629/228/44822926:jpeg_preview_small.jpg?20120509181018";
            
            UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:book_image]]];
            moreBooksModel.imageData = img;
            
            if ([titleArray containsObject:book_title] && [linkArray containsObject:book_link]) {
                
            } else {
                [titleArray addObject:book_title];
                [linkArray addObject:book_link];
                
                [moreBooksArray addObject:moreBooksModel];
            }
        }
        
        if (refreshISOn) {
            
            showBooksArray = [[NSMutableArray alloc] init];
            
            if ([moreBooksArray count] > show_book_count) {
                for (int i = 0; i < show_book_count; i++) {
                    [showBooksArray addObject:moreBooksArray[i]];
                }
                
            } else {
                showBooksArray = moreBooksArray;
            }
            
            pageNumber = 1;
            refreshISOn = false;
        }
        
        if (loadMoreISOn) {
            
            for (int i = show_book_count * (pageNumber - 1); i < show_book_count * pageNumber; i++) {
                if ([moreBooksArray count] > i) {
                    [showBooksArray addObject:moreBooksArray[i]];
                }
            }
            
            loadMoreISOn = false;
        }
        
        return;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error --> loadMorebooks]: %@", error.localizedDescription);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert_title", @"") message:NSLocalizedString(@"alert_network_error", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"alert_ok", @"") otherButtonTitles:nil];
        [alert show];
        return;
        
    }];
}


- (IBAction)onClickBtnHome:(id)sender
{
    [self performSegueWithIdentifier:TO_BACK_HOME sender:self];
}

- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;

    [m_collectionView addHeaderWithCallback:^{
        
        refreshISOn = true;
        
        [vc loadMoreBooks];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.m_collectionView reloadData];
            [vc.m_collectionView headerEndRefreshing];
        });
    }];
    
    [m_collectionView headerBeginRefreshing];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;

    [self.m_collectionView addFooterWithCallback:^{
        
        loadMoreISOn = true;
        
        pageNumber++;
        
        [vc loadMoreBooks];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [vc.m_collectionView reloadData];

            [vc.m_collectionView footerEndRefreshing];
        });
    }];
}

- (void) refreshBook
{
    
}

- (void) moreBook
{
    if ([moreBooksArray count] > 4) {
        for (int i = 0; i < 4; i++) {
            [showBooksArray addObject:moreBooksArray[i]];
        }
    } else {
        
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [showBooksArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *_cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    MoreBooksModel* moreBooksInfo = showBooksArray[indexPath.row];
    
    UIButton* _bookImage = (UIButton*)[_cell viewWithTag:1];
    [_bookImage setBackgroundImage:[UIImage imageNamed:@"book_image.png"] forState:0];
    [_bookImage setImage:moreBooksInfo.imageData forState:UIControlStateNormal];
    
    
    UILabel* _bookTitle = (UILabel*)[_cell viewWithTag:2];
    _bookTitle.text = moreBooksInfo.title;
    _bookTitle.font = [UIFont fontWithName:@"OpenSans-Semibold" size:20];
    
    UITextView* _bookContent = (UITextView*)[_cell viewWithTag:3];
    _bookContent.text = moreBooksInfo.bookdescription;
    _bookContent.font = [UIFont fontWithName:@"OpenSans-Light" size:15];
    
    UIButton* _bookCost = (UIButton*)[_cell viewWithTag:4];
    [_bookCost setTitle:moreBooksInfo.price forState:UIControlStateNormal];
    _bookCost.layer.cornerRadius = 5;
    
    return _cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
