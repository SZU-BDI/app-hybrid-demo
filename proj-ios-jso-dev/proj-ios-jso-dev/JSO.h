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
    id k8;
}

+ (id)s2id:(NSString *)s;
+ (NSString *)id2s:(id)idid FlagThrowEx:(BOOL)flag;

+ (JSO *)s2o:(NSString *)s;
+ (NSString *)o2s:(JSO *)o;


- (NSString *)toString;
- (void)fromString:(NSString *)s;

//TODO:
- (JSO *)getChild:(NSString *)key;
//- (void)setChild:(JSO *)jso forKey:(NSString *)key;
- (void)setChild:(NSString *)child forKey:(NSString *)key;

@end
