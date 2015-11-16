//
//  JournalPresentor.m
//  journalExperimenter
//
//  Created by Jasmine Mou on 11/11/15.
//  Copyright (c) 2015 Jasmine Mou. All rights reserved.
//

#import "JournalPresentor.h"

@implementation JournalPresentor

+(void)showPDF: (NSString*)journalPath inView:(UIView *)viewCont
{
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(12, 65, 350, 554)];
    
    NSURL *url = [NSURL fileURLWithPath:journalPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:request];
    
    [viewCont addSubview:webView];
}

@end
