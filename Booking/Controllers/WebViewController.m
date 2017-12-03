//
//  WebViewController.m
//  Booking
//
//  Created by Cau Ca on 12/3/17.
//  Copyright © 2017 Cau Ca. All rights reserved.
//

@import SVProgressHUD;

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [SVProgressHUD show];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView {
    if(!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
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
