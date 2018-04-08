//
//  Cell+ReuseIdentifier.h
//  BaseKit
//
//  Created by Jack on 2018/4/3.
//  Copyright © 2018 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ReuseIdentifier)
+ (NSString *)reuseIdentifier;
@end


@interface UICollectionViewCell (ReuseIdentifier)
+ (NSString *)reuseIdentifier;
@end
