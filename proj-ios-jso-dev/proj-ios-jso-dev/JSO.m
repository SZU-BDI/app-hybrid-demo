//  JSO.m
//  a string-object wrapper class
//
//  Created by 双虎 @cmpTech on 16/8/30.
//

#import "JSO.h"

@implementation JSO

+ (id)s2id:(NSString *)s
{
    NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    
    //$idid = NSJSONSerialization::JSONObjectWithData($data, $optinos=NSJSONReadingAllowFragments, &$error);
    id idid = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (!idid) {
        
        NSLog(@"s2id -> %@", error.description);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowAlert" object:@"json string 为空或者格式错误"];
    }
    
    return idid;
}

//TODO 增加一个参数 flagThrowEx【是否抛出异常， 默认值是 false】
+ (NSString *)id2s:(id)idid FlagThrowEx:(BOOL)flagThrowEx
{
    if (!idid) return @"null";
    
    if ([idid isKindOfClass:[NSString class]]){
        return (NSString *)idid;
    }
    
    NSError *error;
    @try
    {
        //$result = NSJSONSerialization::dataWithJSONObject( $idid, $options=0, &$error);//don't use NSJSONWritingPrettyPrinted
        NSData *result = [NSJSONSerialization dataWithJSONObject:idid options:0 error:&error];
        
        if (!result) {
            
            //TODO if (flagThrowEx) { 抛出异常 }
            if (flagThrowEx) {
                // ？
                NSLog(@"json 转 data 失败");
            }
            
            NSLog(@"id2s -> %@", error.description);
            return @"null";
        }
        
        //$rt= (new String())->initWithData($result, NSUTF8StringEncoding);
        NSString *rt = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        return rt;
    }
    @catch (NSException *theException)
    {
        // TODO 判断如果是 字符串就直接返回，如果不是再看看怎么处理，下面强制转换是临时占位的，应该不够正确。。。
        
        /* 
            运行到这一步的时候，idid 带入，已经造成崩溃 - idid的类型出错
            NSData *result = [NSJSONSerialization dataWithJSONObject:idid options:0 error:&error];
            所以这里直接返回null，或者抛出一个异常
         */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowAlert" object:@"不兼容的 json string 类型"];
        
        NSLog(@"Exception: %@", theException);
        
        return @"null";
        // return [NSString stringWithFormat:@"Exception: %@", idid];
        // return (NSString *)idid;
    }
    
}

+ (JSO *)s2o:(NSString *)s
{
    // $idid=$this->s2id($s);
    id idid = [self s2id:s];
    
    //$o=new JSO;
    JSO *o = [[JSO alloc] init];
    
    //$o->setValue("innerid",$idid);
    [o setValue:idid forKey:@"innerid"];
    
    return o;
}

+ (NSString *)o2s:(JSO *)o
{
    id idid = [o valueForKey:@"innerid"];
    
    //$s=$this->id2s($idid);
    NSString *s = [self id2s:idid FlagThrowEx:false];
    
    return s;
}

- (NSString *)toString
{
    //return JSO::o2s($this);
    return [JSO o2s:self];
}

- (void)fromString:(NSString *)s
{
    //$idid=JSO::s2id($s);
    id idid = [JSO s2id:s];
    
    //$this->setValue("innerid", $idid);
    [self setValue:idid forKey:@"innerid"];
}

//TODO 临时实现的，还要优化！！！
- (JSO *)getChild:(NSString *)key
{
    NSLog(@"+%@", key);
    if (key == nil || [key isEqualToString:@""]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowAlert" object:@"key 为空，请输入"];
        return nil;
    }
    
    id idid = [self valueForKey:@"innerid"];
    
    if ([idid isKindOfClass:[NSDictionary class]]) {
        
        id subid = [idid valueForKey:key];
        if(subid != nil){
            
            //$o=new JSO;
            JSO *o =[[JSO alloc] init];
            
            //$o->setValue("innerid",$idid);
            [o setValue:subid forKey:@"innerid"];
            
            return o;
        }
    }
    else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowAlert" object:@"JSO 不是键值对"];
    }
    return nil;
   
//    if(subid != nil){
//        //$o=new JSO;
//        JSO *o =[[JSO alloc] init];
//        
//        //$o->setValue("innerid",$idid);
//        [o setValue:subid forKey:@"innerid"];
//        return o;
//    }
//    else{
//        return nil;
//    }
    
}

////TODO
//- (void)setChild:(JSO *)jso forKey:(NSString *)key{
//    
//    //    id idid = [self valueForKey:@"innerid"];
//    //    [self setValue:idid forKey:key];
//    //    //$o=new JSO;
//    //    JSO *o =[[JSO alloc] init];
//    //    $o->setValue("innerid",$idid);
//    //    [o setValue:@"1" forKey:@"innerid"];
//    
//    NSString *value = [JSO o2s:jso];
//    
//    NSString *keyValue = [NSString stringWithFormat:@"{%@:%@}", key, value];
//    
//    NSLog(@"==_== %@", keyValue);
//    
//    
//    //    NSLog(@"key:%@  value:%@", key, jso);
//    [self setValue:keyValue forKey:@"innerid"];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetOK" object:nil];
//    
//    //$o=new JSO;
//    //    JSO *o = [[JSO alloc] init];
//    
//    //$o->setValue("innerid",$idid);
//    //    [o setValue:@"11" forKey:@"innerid"];
//    
//    
//    //    [o setValue:@"1111" forKey:key];
//    
//    
//}

- (void)setChild:(NSString *)child forKey:(NSString *)key{

    NSString *keyValue = [NSString stringWithFormat:@"{%@:%@}", key, child];
    NSLog(@"--%@", keyValue);

    JSO *o = [JSO s2o:keyValue];
    NSString *s = [JSO o2s:o];
    id idid = [JSO s2id:s];
    [o setValue:idid forKey:@"innerid"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetKeyValue" object:s];
}


@end
