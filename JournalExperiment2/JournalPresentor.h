//
//  JournalPresentor.h
//  journalExperimenter
//
//  Created by Jasmine Mou on 11/11/15.
//  Copyright (c) 2015 Jasmine Mou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
#import "JournalViewController.h"

@interface JournalPresentor : NSObject

+(void)showPDF: (NSString*)journalPath inView:(UIView *)viewCont;

@end
