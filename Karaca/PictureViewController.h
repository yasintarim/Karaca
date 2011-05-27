//
//  PictureViewController.h
//  Karaca
//
//  Created by yasin on 3/19/11.
//  Copyright 2011 YKB. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PictureViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate>{
    NSMutableDictionary *array;
    UITableView     *m_tableView;
    UIView          *m_overlay;
    UIActivityIndicatorView *m_activityIndicator;
    NSString        *flickerUrl;
    NSMutableArray  *m_photoTitles;
    NSMutableArray  *m_photoSmallImageData;
    NSMutableArray  *m_photoURLsLargeImage;
    NSMutableArray  *m_imgLoaded;
    NSMutableArray  *m_cachedImageData;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)loadContentForVisibleCells;
- (void)AnimationFinished:(int)index;

@end
