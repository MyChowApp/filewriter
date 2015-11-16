//
//  JournalViewController.m
//  journalExperimenter
//
//  Created by Jasmine Mou on 11/11/15.
//  Copyright (c) 2015 Jasmine Mou. All rights reserved.
//

#import "JournalViewController.h"
#import "JournalGenerator.h"
#import "JournalPresentor.h"

@interface JournalViewController ()

@end

@implementation JournalViewController

- (void)viewDidLoad {
    NSString* journalPath = [self getJournalPath];
    [JournalGenerator drawPDF:journalPath];
    [JournalPresentor showPDF:journalPath inView:self.view];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Assuming self.webView is our UIWebView
    // We go though all sub views of the UIWebView and set their backgroundColor to white
    UIView *v = self.journalTextViewer;
    while (v) {
        v.backgroundColor = [UIColor whiteColor];
        v = [v.subviews firstObject];
    }
}
*/
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
               
- (NSString*)getJournalPath{
    
    NSString* fileName = @"Journal.pdf";
    NSArray* currentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString* docDirectory = [currentDirectory objectAtIndex:0];
    NSString* journalPath = [docDirectory stringByAppendingPathComponent:fileName];
    
    return journalPath;
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


