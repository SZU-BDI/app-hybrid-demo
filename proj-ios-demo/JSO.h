//
//  JSO.h
//  AsiaWeiLuy
//
//  Created by 双虎 on 16/8/30.
//  Copyright © 2016年 Megadata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSO : NSObject

- (void)testAction;

@end

@interface JSODictionary : JSO

@end

@interface JSOArray : JSO

@end

@interface JSONumber : JSO

@end

@interface JSOString : JSO

@end

@interface JSONull : JSO

@end

@interface JSOBollean : JSO

@end
