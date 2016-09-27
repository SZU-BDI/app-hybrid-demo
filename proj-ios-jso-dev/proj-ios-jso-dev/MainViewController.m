//
//  MainViewController.m
//  proj-ios-jso-dev
//
//  Created by 双虎 on 16/9/23.
//  Copyright © 2016年 Cmptech. All rights reserved.
//

#import "MainViewController.h"
#import "JSO.h"

#define WIDTH    [UIScreen mainScreen].bounds.size.width
#define HEIGHT   [UIScreen mainScreen].bounds.size.height
@interface MainViewController ()
@property (nonatomic, strong) UILabel *jsonLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UITextField *field;
@property (nonatomic, strong) UITextField *keyField;
@property (nonatomic, strong) UITextField *setKeyField;
@property (nonatomic, strong) UITextField *setValueField;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAlert:) name:@"ShowAlert" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setKeyValue:) name:@"SetKeyValue" object:nil];
    
    [self addControls];
    [self serializationAction];
}

- (void)showAlert:(NSNotification*)notification{
    
    [self showAlertMessage:[NSString stringWithFormat:@"%@", notification.object]];
}

- (void)setKeyValue:(NSNotification*)notification{

    NSString *s = [NSString stringWithFormat:@"%@",notification.object];
    JSO *o = [JSO s2o:s];
    NSString *ss = [JSO o2s:o];
    NSLog(@"设置的 key value %@", ss);
    _jsonLabel.text = ss;
}

- (void)serializationAction{
 
    //    $s='true';
    //    $b=new JSO_Boolean;
    //    echo ($b->fromString($s))->toString();
    
    // NSString *s = @"true"; //PASS
    // NSString *s = @"false"; //PASS
    // NSString *s = @"null";//test null //PASS
    // NSString *s = @"\"\"";//empty string test //PASS
    // NSString *s = @"[1,2,3]";//simple array  //PASS
    // NSString *s = @"{\"k1\":\"v1\"}";//simple object//PASS
    // NSString *s = @"{k1:\"v1\"}";//expected null //PASS
    // NSString *s = @"{\"k1\":[1,2,{\"o\":\"haha\"}]}";//PASS
    
    // TODO 后面可以在 s2o 那里定义 【会抛出异常】，这样使用者就要自行处理可能抛出的异常“JSON 格式不标准！”
    
    NSString *s = [NSString stringWithFormat:@"%@", _field.text];
    JSO *o = [JSO s2o:s];
    NSString *ss = [JSO o2s:o];
    NSLog(@"最终的字符串：%@", ss);
    _jsonLabel.text = ss;
}

- (void)showValueForKey{
    
    NSString *key = [NSString stringWithFormat:@"%@", _keyField.text];
    NSString *s = [NSString stringWithFormat:@"%@", _jsonLabel.text];
    
    JSO *o = [JSO s2o:s];
    JSO *o2 =[o getChild:key];
    
    NSString *ss = [JSO o2s:o2];
    NSLog(@"取出 %@ 对应的值：%@", key, ss);
    _valueLabel.text = [NSString stringWithFormat:@"取出 %@ 的值为：%@", key, ss];//test display k1's value
    
}

- (void)setJsoChildForKey{
   
    // 不规范
    // NSString *value = @"\"[1,2,{\"o\":\"haha\"}]";
    // NSString *value = @"123";
    // NSString *key = @"\"k1\"";
    // 规范
    // NSString *value = @"[1,2,{\"o\":\"haha\"}]";
    
    NSString *key = [NSString stringWithFormat:@"%@", _setKeyField.text];
    NSString *value = [NSString stringWithFormat:@"%@", _setValueField.text];
//    NSString *keyValue = [NSString stringWithFormat:@"{%@:%@}", _setKeyField.text, _setValueField.text];
    
    JSO *o = [[JSO alloc] init];
//    NSString *sValue = [JSO o2s:oValue];
//    NSLog(@"---%@", sValue);
    
//    JSO *oKey = [JSO s2o:key];
//    NSString *sKey = [JSO o2s:oKey];
//    NSLog(@"+++%@", sKey);
    
        [o setChild:value forKey:key];
//
//    if ([ss isEqualToString:@"null"] || ss == nil) {
//        NSLog(@"value 不规范");
//    }
//    else{
//        [o setChild:o forKey:@"k8"];
//    }
}

- (void)showAlertMessage:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)addControls{
    
    _jsonLabel = [[UILabel alloc] init];
    _jsonLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    _jsonLabel.frame = CGRectMake(0, 20, WIDTH, 200);
    _jsonLabel.textAlignment = NSTextAlignmentCenter;
    // multiline:
    _jsonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _jsonLabel.numberOfLines = 20;
    [self.view addSubview:_jsonLabel];
    
    _valueLabel = [[UILabel alloc] init];
    _valueLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    _valueLabel.frame = CGRectMake(0, 240, WIDTH, 50);
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    // multiline:
    _valueLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _valueLabel.numberOfLines = 20;
    [self.view addSubview:_valueLabel];
    
    
    // TODO (@shuanghua): get s from a input box;
    _field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    _field.center = CGPointMake(WIDTH/2, CGRectGetMaxY(_valueLabel.frame)+20);
    _field.borderStyle = UITextBorderStyleRoundedRect;
    _field.clearButtonMode = UITextFieldViewModeAlways;
    _field.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _field.backgroundColor = [UIColor whiteColor];
    _field.placeholder = @"Input json string";
    
    // 默认json
    _field.text = @"{\"k1\":[1,2,{\"o\":\"haha\"}]}";
    [self.view addSubview:_field];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.backgroundColor = [UIColor grayColor];
    btn.center = CGPointMake(WIDTH/2, CGRectGetMaxY(_field.frame)+20);
    [btn setTitle:@"show" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(serializationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _keyField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)+10, WIDTH, 30)];
    _keyField.borderStyle = UITextBorderStyleRoundedRect;
    _keyField.clearButtonMode = UITextFieldViewModeAlways;
    _keyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _keyField.backgroundColor = [UIColor whiteColor];
    _keyField.placeholder = @"Input key";
    
    // 默认key值
    _keyField.text = @"k1";
    [self.view addSubview:_keyField];
    
    UIButton *keyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keyBtn.frame = CGRectMake(0, 0, 100, 30);
    keyBtn.center = CGPointMake(WIDTH/2, CGRectGetMaxY(_keyField.frame)+20);
    keyBtn.backgroundColor = [UIColor grayColor];
    [keyBtn setTitle:@"show" forState:UIControlStateNormal];
    [keyBtn addTarget:self action:@selector(showValueForKey) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keyBtn];
    
    
    _setKeyField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(keyBtn.frame)+10, WIDTH/2, 30)];
    _setKeyField.borderStyle = UITextBorderStyleRoundedRect;
    _setKeyField.clearButtonMode = UITextFieldViewModeAlways;
    _setKeyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _setKeyField.backgroundColor = [UIColor whiteColor];
    _setKeyField.placeholder = @"set key";
    [self.view addSubview:_setKeyField];
    
    _setValueField = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH/2, CGRectGetMaxY(keyBtn.frame)+10, WIDTH/2, 30)];
    _setValueField.borderStyle = UITextBorderStyleRoundedRect;
    _setValueField.clearButtonMode = UITextFieldViewModeAlways;
    _setValueField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _setValueField.backgroundColor = [UIColor whiteColor];
    _setValueField.placeholder = @"set value";
    [self.view addSubview:_setValueField];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 100, 30);
    btn2.center = CGPointMake(WIDTH/2, CGRectGetMaxY(_setKeyField.frame)+20);
    btn2.backgroundColor = [UIColor grayColor];
    [btn2 setTitle:@"ok" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(setJsoChildForKey) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
