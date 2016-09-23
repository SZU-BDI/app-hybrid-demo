//
//  JSO.m
//  AsiaWeiLuy
//
//  Created by 双虎 on 16/8/30.
//  Copyright © 2016年 Megadata. All rights reserved.
//

#import "JSO.h"

// 抽象类
@implementation JSO

//class static method o2s
+ (JSO *)o2s:(NSString *)str{
    // subclass doing 该方法必须有返回值
    return nil;
}

+ (NSString *)s2o:(JSO *)jso{
    // subclass doing 该方法必须有返回值
    return @"null";
}

- (void)toString{
    // subclass doing
}

- (void)fromString:(NSString *)str{
    // subclass doing
}

- (JSO *)getChild:(NSString *)key{
    // subclass doing  该方法必须有返回值
    return nil;
}
- (void)setChild:(JSO *)jso forKey:(NSString *)key{
    // subclass doing
}

@end
