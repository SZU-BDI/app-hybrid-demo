//
//  JSO_Boolean.m
//  proj-ios-jso-dev
//
//  Created by 双虎 on 16/9/23.
//  Copyright © 2016年 Cmptech. All rights reserved.
//

#import "JSO_Boolean.h"


@implementation JSO_Boolean

- (void)toString
{
    NSLog(@"%@", [NSString stringWithFormat:@"%@", _jsoString]);
}

- (void)fromString:(NSString *)str
{
    _jsoString = str;
}

@end
