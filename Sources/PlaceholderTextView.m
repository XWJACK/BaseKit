//
//  PlaceholderTextView.m
//  BaseKit
//
//  Created by Jack on 2018/4/3.
//  Copyright © 2018 Jack. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView()
@property(nonatomic, strong) UILabel *placeholderLabel;
@end

@implementation PlaceholderTextView

@dynamic placeholder;
@dynamic placeholderColor;
@dynamic placeholderFont;

- (void)awakeFromNib {
    [super awakeFromNib];
    [self customInit];
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - override

- (void)layoutSubviews {
    UIEdgeInsets inset = self.textContainerInset;
    if (self.placeholder && !self.placeholderLabel.isHidden) {
        [self.placeholderLabel sizeToFit];
        CGRect newFrame = self.placeholderLabel.frame;
        /// Make 5px offset.
        newFrame.origin = CGPointMake(inset.left + 5, inset.top);
        self.placeholderLabel.frame = newFrame;
    }
    [super layoutSubviews];
}

//- (void)setFont:(UIFont *)font {
//    [super setFont:font];
//    self.placeholderFont = font;
//}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    self.placeholderLabel.textAlignment = textAlignment;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self textDidChange];
}

#pragma mark - Action

- (void)setPlaceholder:(NSString *)placeholder {
    self.placeholderLabel.text = placeholder;
}
- (NSString *)placeholder {
    return self.placeholderLabel.text;
}


- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    self.placeholderLabel.textColor = placeholderColor;
}
- (UIColor *)placeholderColor {
    return self.placeholderLabel.textColor;
}


- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    self.placeholderLabel.font = placeholderFont;
}
- (UIFont *)placeholderFont {
    return self.placeholderLabel.font;
}

- (void)setValue:(id)value forPlaceholderLabelWithKey:(NSString *)key {
    [self.placeholderLabel setValue:value forKey:key];
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [UILabel new];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (void)textDidChange {
    self.placeholderLabel.hidden = self.hasText;
}

@end
