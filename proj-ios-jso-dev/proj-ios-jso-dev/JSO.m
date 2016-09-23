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

- (void)testAction{
    
    NSLog(@"JSO test");
}

@end

// JSODictionary
@implementation JSODictionary

- (void)testAction{
    
    NSLog(@"修改父类方法 JSODictionary test");
}

@end

// JSOArray
@implementation JSOArray

- (void)testAction{
    
    NSLog(@"修改父类方法 JSOArray test");
}

@end

// JSONumber
@implementation JSONumber

- (void)testAction{
    
    NSLog(@"修改父类方法 JSONumber test");
}

@end

// JSOString
@implementation JSOString

- (instancetype)init{
    
    self = [super init];
    if (self) {
     
        NSLog(@"JSOString init");
    }
    return self;
}

- (void)testAction{
    
    NSLog(@"修改父类方法 JSOString test");
}

@end

// JSONull
@implementation JSONull

- (void)testAction{
    
    NSLog(@"修改父类方法 JSONull test");
}

@end

@implementation JSOBollean

- (void)testAction{
    
    NSLog(@"修改父类方法 JSOBollean test");
}

@end
