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

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    NSString *str = @"{\"name\":\"Twotigers\"}";
    
    UILabel *lbl = [[UILabel alloc] init];
    
    //multiline:
    lbl.lineBreakMode = NSLineBreakByWordWrapping;
    lbl.numberOfLines = 20;
    
    lbl.frame = CGRectMake(0, 0, WIDTH, 200);
    lbl.center = CGPointMake(WIDTH/2, HEIGHT/2);
    lbl.textAlignment = NSTextAlignmentCenter;
    //    lable.text = [NSString stringWithFormat:@"%@", str];
    [self.view addSubview:lbl];
    
    //    $s='true';
    //    $b=new JSO_Boolean;
    //    echo ($b->fromString($s))->toString();
    
    //TODO (@shuanghua): get s from a input box;
    //NSString *s = @"true"; //PASS
    //NSString *s = @"false"; //PASS
    //NSString *s = @"null";//test null //PASS
    //NSString *s = @"\"\"";//empty string test //PASS
    //NSString *s = @"[1,2,3]";//simple array  //PASS
    //NSString *s = @"{\"k1\":\"v1\"}";//simple object//PASS
    
    //NSString *s = @"{k1:\"v1\"}";//expected null //PASS
    //TODO 后面可以在 s2o 那里定义 【会抛出异常】，这样使用者就要自行处理可能抛出的异常“JSON 格式不标准！”
    
    NSString *s=@"{\"k1\":[1,2,{\"o\":\"haha\"}]}";//PASS
    
    //lbl.text= [JSO id2s:[JSO s2id:s]];
    JSO *o=[JSO s2o:s];
    
    JSO *o2=[o getChild:@"k1"];
    NSString *s2=[JSO o2s:o2];
    //    NSLog(@"%@", s2);
    
    NSString *ss=[JSO o2s:o];
    
    NSLog(@"%@", ss);
    
    lbl.text= ss;
    lbl.text= s2;//test display k1's value
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
