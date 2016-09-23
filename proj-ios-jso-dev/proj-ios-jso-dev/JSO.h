//
//  JSO.h
//  AsiaWeiLuy
//
//  Created by 双虎 on 16/8/30.
//  Copyright © 2016年 Megadata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSO : NSObject

+ (JSO *)o2s:(NSString *)str;
+ (NSString *)s2o:(JSO *)jso;

- (void)toString;
- (void)fromString:(NSString *)str;

- (JSO *)getChild:(NSString *)key;
- (void)setChild:(JSO *)jso forKey:(NSString *)key;

@end
