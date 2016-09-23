//
//  MainViewController.m
//  proj-ios-jso-dev
//
//  Created by 双虎 on 16/9/23.
//  Copyright © 2016年 Cmptech. All rights reserved.
//

#import "MainViewController.h"
#import "JSO.h"
#import "JSO_Boolean.h"

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
    lbl.frame = CGRectMake(0, 0, WIDTH, 25);
    lbl.center = CGPointMake(WIDTH/2, HEIGHT/2);
    lbl.textAlignment = NSTextAlignmentCenter;
//    lable.text = [NSString stringWithFormat:@"%@", str];
    [self.view addSubview:lbl];
    
//    $s='true';
//    $b=new JSO_Boolean;
//    echo ($b->fromString($s))->toString();
    
    NSString *s = @"true";
    
    //$o=JSO::s2o(s);
    JSO *o = [JSO o2s:s];
    
    //$lbl->text = JSO::o2s(o);
    lbl.text= [JSO s2o:o];
    
//    JSO_Boolean *b = [[JSO_Boolean alloc] init];
//    [b fromString:s];
//    [b toString];
//
//    lbl.text = b.jsoString;
    
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
