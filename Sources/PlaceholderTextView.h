//
//  PlaceholderTextView.h
//  BaseKit
//
//  Created by Jack on 2018/4/3.
//  Copyright © 2018 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

IBInspectable
@interface PlaceholderTextView : UITextView
/**
 Placeholder.
 */
@property(nonatomic, copy) IBInspectable NSString *placeholder;
/**
 Placeholder color.
 */
@property(nonatomic, strong) IBInspectable UIColor *placeholderColor;
/**
 Placeholder font.
 */
@property(nonatomic, strong) IBInspectable UIFont *placeholderFont;

/**
 Custom another property for placeholderLabel;
 */
- (void)setValue:(id)value forPlaceholderLabelWithKey:(NSString *)key;

@end
