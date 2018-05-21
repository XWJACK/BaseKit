//
//  SearchBar.m
//  BaseKit
//
//  Created by Jack on 2018/5/21.
//  Copyright © 2018 Jack. All rights reserved.
//

#import "SearchBar.h"

@interface SearchBar() <UITextFieldDelegate> {
    /// Flag for delegate.
    struct {
        unsigned int searchBar_frameForSearchField_ : 1;
        unsigned int searchBar_frameForCancelButton_ : 1;
        unsigned int searchBar_frameForSearchButton_ : 1;
        unsigned int searchBar_frameForClearButton_ : 1;
        
        unsigned int searchBarShouldBeginEditing_ : 1;
        unsigned int searchBarShouldEndEditing_ : 1;
        unsigned int searchBar_textDidChange_ : 1;
        unsigned int searchBar_shouldChangeTextInRange_replacementText_ : 1;
        unsigned int searchBarSearchButtonClicked_ : 1;
        unsigned int searchBarCancelButtonClicked_ : 1;
    } _delegateFlags;
}
/// Search field.
@property (nonatomic) UITextField *searchField;
/// Search icon button.
@property (nonatomic) UIButton *searchTextFieldLeftButton;
/// Clear button.
@property (nonatomic) UIButton *searchTextFieldRightButton;
@end

@implementation SearchBar
- (void)awakeFromNib {
    [super awakeFromNib];
    [self customInit];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}
- (void)customInit {
    self.backgroundColor = UIColor.clearColor;
    
    _searchTextFieldLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchTextFieldRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchTextFieldRightButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _searchField = [[UITextField alloc] initWithFrame:self.bounds];
    _searchField.returnKeyType = UIReturnKeySearch;
    _searchField.delegate = self;
    _searchField.leftView = _searchTextFieldLeftButton;
    _searchField.leftViewMode = UITextFieldViewModeAlways;
    _searchField.rightView = _searchTextFieldRightButton;
    _searchField.rightViewMode = UITextFieldViewModeAlways;
    /// Custom hidden and display clear button.
    _searchTextFieldRightButton.hidden = YES;
    [self addSubview:_searchField];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotificationAction:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_cancelButton sizeToFit];
    _cancelButton.frame = _delegateFlags.searchBar_frameForCancelButton_ ? [_delegate searchBar:self frameForCancelButton:_cancelButton] : CGRectZero;
    
    _searchField.frame = _delegateFlags.searchBar_frameForSearchField_ ? [_delegate searchBar:self frameForSearchField:_searchField] : self.bounds;
    
    [_searchTextFieldLeftButton sizeToFit];
    _searchTextFieldLeftButton.frame = _delegateFlags.searchBar_frameForSearchButton_ ? [_delegate searchBar:self frameForSearchButton:_searchTextFieldLeftButton] : _searchTextFieldLeftButton.frame;
    
    [_searchTextFieldRightButton sizeToFit];
    _searchTextFieldRightButton.frame = _delegateFlags.searchBar_frameForClearButton_ ? [_delegate searchBar:self frameForClearButton:_searchTextFieldRightButton] : _searchTextFieldRightButton.frame;
}
- (BOOL)resignFirstResponder {
    return [_searchField resignFirstResponder];
}

- (void)clearButtonAction:(UIButton *)sender {
    sender.hidden = YES;
    _searchField.text = @"";
    
    if (_delegateFlags.searchBar_textDidChange_) {
        [_delegate searchBar:self textDidChange:@""];
    }
}
- (void)cancelButtonAction:(UIButton *)sender {
    if (_delegateFlags.searchBarCancelButtonClicked_) {
        [_delegate searchBarCancelButtonClicked:self];
    }
}
- (void)setImage:(UIImage *)iconImage forSearchBarIcon:(UISearchBarIcon)icon state:(UIControlState)state {
    switch (icon) {
        case UISearchBarIconSearch: {
            [_searchTextFieldLeftButton setImage:iconImage forState:state];
        }
            break;
        case UISearchBarIconClear: {
            [_searchTextFieldRightButton setImage:iconImage forState:state];
        }
            break;
        default:
            break;
    }
}
- (void)setDelegate:(id<SearchBarDelegate>)delegate {
    _delegate = delegate;
    
    _delegateFlags.searchBar_frameForSearchField_ = [_delegate respondsToSelector:@selector(searchBar:frameForSearchField:)];
    _delegateFlags.searchBar_frameForCancelButton_ = [_delegate respondsToSelector:@selector(searchBar:frameForCancelButton:)];
    _delegateFlags.searchBar_frameForSearchButton_ = [_delegate respondsToSelector:@selector(searchBar:frameForSearchButton:)];
    _delegateFlags.searchBar_frameForClearButton_ = [_delegate respondsToSelector:@selector(searchBar:frameForClearButton:)];
    
    
    _delegateFlags.searchBarShouldBeginEditing_ = [_delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)];
    _delegateFlags.searchBarShouldEndEditing_ = [_delegate respondsToSelector:@selector(searchBarShouldEndEditing:)];
    _delegateFlags.searchBar_textDidChange_ = [_delegate respondsToSelector:@selector(searchBar:textDidChange:)];
    _delegateFlags.searchBar_shouldChangeTextInRange_replacementText_ = [_delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)];
    _delegateFlags.searchBarSearchButtonClicked_ = [_delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)];
    _delegateFlags.searchBarCancelButtonClicked_ = [_delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)];
}
#pragma mark selecotr delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return _delegateFlags.searchBarShouldBeginEditing_ ? [_delegate searchBarShouldBeginEditing:self] : YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return _delegateFlags.searchBarShouldEndEditing_ ? [_delegate searchBarShouldEndEditing:self] : YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return _delegateFlags.searchBar_shouldChangeTextInRange_replacementText_ ? [_delegate searchBar:self shouldChangeTextInRange:range replacementText:string] : YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_delegateFlags.searchBarSearchButtonClicked_) {
        [_delegate searchBarSearchButtonClicked:self];
    }
    return YES;
}
- (void)textFieldTextDidChangeNotificationAction:(NSNotification *)sender {
    _searchTextFieldRightButton.hidden = _searchField.text.length == 0;
    if (_delegateFlags.searchBar_textDidChange_) {
        [_delegate searchBar:self textDidChange:_searchField.text];
    }
}

#pragma mark easy property
- (NSString *)placeholder {
    return _searchField.placeholder;
}
- (void)setPlaceholder:(NSString *)placeholder {
    _searchField.placeholder = placeholder;
}
- (NSString *)text {
    return _searchField.text;
}
- (void)setText:(NSString *)text {
    _searchField.text = text;
    _searchTextFieldRightButton.hidden = text.length == 0;
}
@end
