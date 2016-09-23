//
//  JSO.m
//  AsiaWeiLuy
//
//  Created by 双虎 on 16/8/30.
//  Copyright © 2016年 Megadata. All rights reserved.
//

#import "JSO.h"

@implementation JSO

//@ref https://danielsaidi.wordpress.com/2012/07/04/handling-json-in-ios/

+ (id)s2id:(NSString *)s
{
    NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (!result) {
        NSLog(@"%@", error.description);
    }
    return result;
}

//TODO 增加一个参数 “是否抛出异常" 默认值是 否
+ (NSString *)id2s:(id)idid
{
    NSError *error;

//    NSData *result = [NSJSONSerialization dataWithJSONObject:idid options:NSJSONWritingPrettyPrinted error:&error];
    if (idid==nil) return @"null";
    
    NSData *result = [NSJSONSerialization dataWithJSONObject:idid options:0 error:&error];
    if (!result) {
        NSLog(@"%@", error.description);
        //TODO 抛出异常
    }
   
    NSString *rt= [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    return rt;
}

+ (JSO *)s2o:(NSString *)s{
    id idid=[self s2id:s];
    JSO *jso=[[JSO alloc] init];
    [jso setValue:idid forKey:@"innerid"];
    return jso;
}

+ (NSString *)o2s:(JSO *)jso{
    id idid=[jso valueForKey:@"innerid"];
    NSString *s=[self id2s:idid];
    return s;
}

- (NSString *)toString{
    return [JSO o2s:self];
}

- (void)fromString:(NSString *)s{
    id idid=[JSO s2id:s];
    [self setValue:idid forKey:@"innerid"];
}

//TODO
- (JSO *)getChild:(NSString *)key{
    // subclass doing  该方法必须有返回值
    return nil;
}
//TODO
- (void)setChild:(JSO *)jso forKey:(NSString *)key{
    // subclass doing
}

@end
