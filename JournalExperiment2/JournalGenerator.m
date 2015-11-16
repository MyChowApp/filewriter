//
//  JournalGenerator.m
//  journalExperimenter
//
//  Created by Jasmine Mou on 11/11/15.
//  Copyright (c) 2015 Jasmine Mou. All rights reserved.
//

#import "JournalGenerator.h"

@implementation JournalGenerator

CGSize pageSize;


+(void)drawPDF:(NSString*)journalPath
{
    // pageSize = CGSizeMake(612, 792);
    pageSize = CGSizeMake(612, 2000);
    // Create the PDF context using default page size
    UIGraphicsBeginPDFContextToFile(journalPath, CGRectZero, nil);
    
    // Mark the beginning of a page
    //UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(-20, 0, 612, 2000), nil);
    
    [self drawText];
    
    
    UIGraphicsEndPDFContext();
}

+(void)drawText
{
    // context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, pageSize.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect textRect = CGRectMake(0, 0, pageSize.width, pageSize.height);
    CGPathAddRect(path, NULL, textRect);
    
    // text
    NSString *textString = [self getTextBlock];
    
    // set text attributes
    UIFont *font = [UIFont fontWithName:@"Arial" size:20];  /*CHANGE CONTENTS HERE*/
    NSDictionary *attrs = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:textString attributes:attrs];
    
    // frame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)text);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [textString length]), path, NULL);
    
    // draw
    CTFrameDraw(frame, context);
    CFRelease(frame);
    CFRelease(framesetter);
    CFRelease(path);
}


+(NSString*)getTextBlock{
    NSString *textBlock = @"\n";
    
    // TITLE
    NSString *title = @"MY CHOW REPORT \n\n";                 /*CHANGE CONTENTS HERE*/
    textBlock = [textBlock stringByAppendingString:title];
    
    // NAME
    NSString *nameTag = @"Name";
    NSString *nameContent = @"Mr. Chow";                    /*CHANGE CONTENTS HERE*/
    NSString *name= [NSString stringWithFormat:@"%@: %@ \n\n", nameTag, nameContent];
    textBlock = [textBlock stringByAppendingString:name];
    
    // DOB
    NSString *DOBContent = @"2015/11/15";                   /*CHANGE CONTENTS HERE*/
    NSString *DOB = [NSString stringWithFormat:@"DOB: %@ \n\n", DOBContent];
    textBlock = [textBlock stringByAppendingString:DOB];
    
    // ALLERGY
    NSString *allergies = @"Allergies: \n";
    NSArray *allergyArray = @[@"protein", @"gluten", @"pork"]; /*CHANGE CONTENTS HERE*/
    NSUInteger allergyCount = [allergyArray count];
    
    for(int iterator = 0; iterator < allergyCount - 1; iterator ++){
        NSString *algyEntry = [NSString stringWithFormat:@"%@, ", allergyArray[iterator]];
        allergies = [allergies stringByAppendingString:algyEntry];
    }
    NSString *lastAlgyEntry = [NSString stringWithFormat:@"%@ \n\n", allergyArray[allergyCount-1]];
    allergies = [allergies stringByAppendingString:lastAlgyEntry];
    
    textBlock = [textBlock stringByAppendingString:allergies];
    
    // RECIPES HISTORY
    NSString *history = @"Recipe History: \n";

    //// Raw Data Format Translation
    NSArray *recipeNames = @[@"Pumpkin Avocado Tostadas",
                             @"Carrot Soup with Carrot Top Pesto",
                             @"Butternut Squash Breakfast Hash"];
    
    NSArray *recipeIngs = @[@"4 to 6 corn tortillas\n1 cup sliced romaine lettuce\n1 ripe Haas avocado, sliced\n1 radish, thinly sliced\n¼ cup chopped scallions\n2 tablespoons pepitas\n1 lime, sliced into wedges\ncoarse sea salt\nyour favorite tomatillo salsa, optional\nhot sauce, optional",
                            @"1 tablespoon extra-virgin olive oil\n1 cup chopped yellow onions\n3 garlic cloves, smashed\n2 heaping cups chopped carrots (save carrot tops)\n1½ teaspoons grated fresh ginger\n1 tablespoon apple cider vinegar or freshly squeezed orange juice\n3 to 4 cups vegetable broth\n1 teaspoon maple syrup, or to taste (optional)\ncoconut milk for garnish (optional)",
                            @"2 cups cubed butternut squash\n1 tablespoon extra-virgin olive oil, plus more for drizzling\n⅓ cup chopped scallions\n1 small zucchini, cut into 1-inch pieces (1½ cups)\n1½ cups chopped broccolini or broccoli florets\n2 tablespoons minced fresh rosemary or sage\n1 teaspoon balsamic or sherry vinegar, or fresh lemon juice\n1 garlic clove, finely chopped\n3 kale leaves, stemmed and chopped\n3 to 4 fried eggs\nsea salt and freshly ground black pepper\nfew pinches smoked paprika (optional)\nthinly sliced radishes, for garnish (optional)"];
    
    NSArray *dateArray = @[@"2015/11/10", @"2015/11/15"];
    
    //// Data Structure of recipeDict and historyDict
    
    //// recipeDict
    //// key: recipe name
    //// value: recipe ingredients
    
    NSMutableDictionary *recipeDict = [NSMutableDictionary dictionaryWithObjects:recipeIngs forKeys:recipeNames];
    NSLog(@"%@", recipeDict); // test recipeDict
    
        
    //// historyDict
    //// key: date
    //// value: an array of recipe names
    
    NSArray *recipeDay0 = @[recipeNames[0]];
    NSArray *recipeDay1 = @[recipeNames[1], recipeNames[2]];
    
    NSMutableDictionary *historyDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              recipeDay0, dateArray[0],
                              recipeDay1, dateArray[1],
                              nil];
    NSLog(@"%@", historyDict); // test historyDict
    
    //// output
    
    NSUInteger historyCount = [dateArray count];
    
    
    for(int k = 0; k < historyCount; k++){
        NSString *dateContent = dateArray[k];
        NSString *date = [NSString stringWithFormat:@"\n%@ \n", dateContent];
        history = [history stringByAppendingString:date];
        
        NSArray *recipeNamesSingleDay = historyDict[dateContent];
        for(id recipeNameContent in recipeNamesSingleDay){
            NSString *recipeName = [NSString stringWithFormat:@"\n%@: \n", recipeNameContent];
            history = [history stringByAppendingString:recipeName];
            
            NSString *recipeIngSingleDayContent = recipeDict[recipeNameContent];
            NSString *recipeIng = [NSString stringWithFormat:@"%@ \n", recipeIngSingleDayContent];
            history = [history stringByAppendingString:recipeIng];
        }
    }
    
    textBlock = [textBlock stringByAppendingString:history];
    
    // END
    textBlock = [textBlock stringByAppendingString:@"end. \n"];
    return textBlock;
}


@end
