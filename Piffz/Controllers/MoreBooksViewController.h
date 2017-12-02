//
//  MoreBooksViewController.h
//  Piffz
//
//  Created by AppsCreationTech on 4/7/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import "ViewController.h"

@interface MoreBooksViewController : ViewController

@property (strong, nonatomic) IBOutlet UILabel *m_lblMoreBooks;
@property (strong, nonatomic) IBOutlet UILabel *m_lblDescription;
@property (strong, nonatomic) IBOutlet UIButton *m_btnBackHome;
@property (strong, nonatomic) IBOutlet UIView *m_viewBooks;
@property (strong, nonatomic) IBOutlet UICollectionView *m_collectionView;


- (IBAction)onClickBtnHome:(id)sender;

@end

extern BOOL refreshISOn;
extern BOOL loadMoreISOn;
extern NSInteger pageNumber;
