//
//  SearchBar.h
//  BaseKit
//
//  Created by Jack on 2018/5/21.
//  Copyright © 2018 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchBar;

#pragma mark - SearchBarDelegate

@protocol SearchBarDelegate <NSObject>

@optional

/// Default self.bounds
- (CGRect)searchBar:(SearchBar *)searchBar frameForSearchField:(UITextField *)searchField;
/// Default CGRectZero
- (CGRect)searchBar:(SearchBar *)searchBar frameForCancelButton:(UIButton *)cancelButton;
- (CGRect)searchBar:(SearchBar *)searchBar frameForSearchButton:(UIButton *)searchButton;
- (CGRect)searchBar:(SearchBar *)searchBar frameForClearButton:(UIButton *)clearButton;

- (BOOL)searchBarShouldBeginEditing:(SearchBar *)searchBar;
//- (void)searchBarTextDidBeginEditing:(SearchBar *)searchBar;
- (BOOL)searchBarShouldEndEditing:(SearchBar *)searchBar;
//- (void)searchBarTextDidEndEditing:(SearchBar *)searchBar;
- (void)searchBar:(SearchBar *)searchBar textDidChange:(NSString *)searchText;
- (BOOL)searchBar:(SearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

- (void)searchBarSearchButtonClicked:(SearchBar *)searchBar;
//- (void)searchBarBookmarkButtonClicked:(SearchBar *)searchBar;
- (void)searchBarCancelButtonClicked:(SearchBar *)searchBar;
//- (void)searchBarResultsListButtonClicked:(SearchBar *)searchBar;

//- (void)searchBar:(SearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope;
@end

/// Custom search bar, because of iOS 11 with new style.
@interface SearchBar: UIView
@property (nonatomic) IBInspectable NSString *placeholder;
@property (nonatomic) IBInspectable NSString *text;
@property (nonatomic, weak) id<SearchBarDelegate> delegate;
/// Cancel Button
@property (nonatomic) UIButton *cancelButton;
/// Only support UISearchBarIconSearch and UISearchBarIconClear
- (void)setImage:(UIImage *)iconImage forSearchBarIcon:(UISearchBarIcon)icon state:(UIControlState)state;
@end
