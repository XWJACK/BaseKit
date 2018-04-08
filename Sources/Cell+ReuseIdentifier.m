//
//  Cell+ReuseIdentifier.m
//  BaseKit
//
//  Created by Jack on 2018/4/3.
//  Copyright © 2018 Jack. All rights reserved.
//

#import "Cell+ReuseIdentifier.h"

@implementation UITableViewCell (ReuseIdentifier)
+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}
@end

@implementation UICollectionViewCell (ReuseIdentifier)
+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}
@end
