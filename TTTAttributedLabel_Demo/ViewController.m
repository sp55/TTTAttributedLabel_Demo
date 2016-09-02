//
//  ViewController.m
//  TTTAttributedLabel_Demo
//
//  Created by admin on 16/6/24.
//  Copyright © 2016年 AlezJi. All rights reserved.

//http://www.jianshu.com/p/7026008c595a
//TTTAttributedLabel简单使用

//http://www.jianshu.com/p/9a192bc8e644

#import "ViewController.h"
#import "TTTAttributedLabel.h"
@interface ViewController ()<TTTAttributedLabelDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //TTTAttributedLabe作为UILabel的替代，可以轻松的渲染可变字符串，文中中加入嵌入链接，手机号，时间都可以得到相对应的处理
    NSString           *text  = @"美国职业篮球联赛百度是由北美三十支队伍组成的男子职业篮球联盟，美国四大职业体育美国职业篮球联赛百度是由北美三十支队伍组成的男子职业篮球联盟，美国四大职业体育美国职业篮球联赛百度是由北美三十支队伍组成的男子职业篮球联盟，美国四大职业体育美国职业篮球联赛百度是由北美三十支队伍组成的男子职业篮球联盟，美国四大职业体育美国职业篮球联赛百度是由北美三十支队伍组成的男子职业篮球联盟，美国四大职业体育";
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(20, 80, 300, 500)];
    label.textColor = [UIColor whiteColor];
    NSMutableAttributedString *atributeStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    //可以传属性字符串
    label.text            = atributeStr;
    label.backgroundColor = [UIColor redColor];
    label.font            = [UIFont systemFontOfSize:14];
    label.numberOfLines   = 0;
    //链接的属性字符串
    label.linkAttributes       = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0f]};
    label.activeLinkAttributes = @{NSForegroundColorAttributeName:[UIColor orangeColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0f]};
    
    
    
    //那个是可以点击的链接
    //    NSRange serviceRange = [text rangeOfString:@"美国"];
    //    label.delegate = self;
    //    [self.view addSubview:label];
    //    [label addLinkToURL:[NSURL URLWithString:@"http://china.nba.com"] withRange:serviceRange];
    
    
    
    NSRange searchRange = NSMakeRange(0, [text length]);
    NSRange range;
    while ((range = [text rangeOfString:@"美国" options:0 range:searchRange]).location != NSNotFound) {
        searchRange = NSMakeRange(NSMaxRange(range), [text length] - NSMaxRange(range));
        [label addLinkToURL:[NSURL URLWithString:@"http://china.nba.com"] withRange:range];
    }
    
    
    
    
    
    NSRange serviceRange2 = [text rangeOfString:@"百度"];
    label.delegate = self;
    [self.view addSubview:label];
    [label addLinkToURL:[NSURL URLWithString:@"http://www.baidu.com"] withRange:serviceRange2];
}
//实现TTTAttributedLabelDelegate协议:
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    NSLog(@"要打开的url是---->%@",url);
    [[UIApplication sharedApplication] openURL:url];
}
//如果加入了其他手势操作，会导致TTTAttributedLabel中的链接无法响应，因此需要在手势的delegate中进行判断:
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[TTTAttributedLabel class]]) {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
