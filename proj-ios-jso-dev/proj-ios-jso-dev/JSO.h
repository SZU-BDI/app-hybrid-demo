//
//  JSO.h
//  AsiaWeiLuy
//
//  Created by 双虎 on 16/8/30.
//  Copyright © 2016年 Megadata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSO : NSObject{
 id innerid;//store the obj here
}

+ (id)s2id:(NSString *)s;
+ (NSString *)id2s:(id)id;

+ (JSO *)s2o:(NSString *)str;
+ (NSString *)o2s:(JSO *)jso;


- (NSString *)toString;
- (void)fromString:(NSString *)str;

//TODO:
- (JSO *)getChild:(NSString *)key;
- (void)setChild:(JSO *)jso forKey:(NSString *)key;

@end
