//
//  CustomTestObserver.m
//  Test
//
//  Created by Andrei Raifura on 9/9/15.
//  Copyright © 2015 thelvis. All rights reserved.
//

#import "CleanTestObserver.h"

@interface CleanTestObserver ()
@property (nonatomic, strong) NSMutableArray *caseFailures;
@property (nonatomic, strong) NSMutableArray *suiteFailures;

@property (nonatomic) NSUInteger numberOfTests;
@property (nonatomic) NSDate *startDate;
@end

@implementation CleanTestObserver


- (void)testBundleWillStart:(NSBundle *)testBundle {
    self.caseFailures = [NSMutableArray array];
    self.suiteFailures = [NSMutableArray array];
    
    self.numberOfTests = 0;
    self.startDate = [NSDate date];
}


- (void)testSuiteWillStart:(XCTestSuite *)testSuite {
    if ([testSuite.name hasSuffix:@".xctest"]) return;
    if ([testSuite.name hasSuffix:@".framework"]) return;

    NSArray *defaultSuitNames = @[@"All tests", @"Selected tests"];
    if ([defaultSuitNames containsObject:testSuite.name]) return;
    
    NSString *suiteName = [NSString stringWithFormat:@"%@: ", testSuite.name];
    [self log:suiteName];
}


- (void)testCaseWillStart:(XCTestCase *)testCase {
}


- (void)testCase:(XCTestCase *)testCase didFailWithDescription:(NSString *)description inFile:(NSString *)filePath atLine:(NSUInteger)lineNumber {
    NSString *customDescription = [description stringByReplacingOccurrencesOfString:@"failed - " withString:@""];
    customDescription = [customDescription stringByReplacingOccurrencesOfString:@"failed: " withString:@""];
    customDescription = [customDescription stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[customDescription substringToIndex:1] uppercaseString]];
    
    NSArray *nameComponents = [testCase.name componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *className = [nameComponents[0] stringByReplacingOccurrencesOfString:@"-[" withString:@""];
    
    NSString *testName = [nameComponents[1] stringByReplacingOccurrencesOfString:@"]" withString:@""];
    NSRange range = [testName rangeOfString:@"_Users"];
    if (range.location != NSNotFound) {
        NSInteger numberOfCharactersToDelete = testName.length -  range.location;
        NSRange rangeToDelete = NSMakeRange(range.location, numberOfCharactersToDelete);
        testName = [testName stringByReplacingCharactersInRange:rangeToDelete withString:@""];
    }
    
    if ([testName hasPrefix:@"test"]) {
        testName = [testName stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""];
        testName = [self camelsaseToNormalCaseForString:testName];
    }
    
    testName = [testName stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    testName = [testName stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    
    NSString *failure = [NSString stringWithFormat:@"FAILURE: %@ - %@\n%@\n", className, testName, customDescription];
    
    
    [self.caseFailures addObject:failure];
    [self log:@"F"];
}


- (NSString *)camelsaseToNormalCaseForString:(NSString *)string {
    NSMutableString *str2 = [NSMutableString string];
    [str2 appendString:[string substringToIndex:1]];

    for (NSInteger i=1; i<string.length; i++){
        NSString *ch = [string substringWithRange:NSMakeRange(i, 1)];
        if ([ch rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound) {
            [str2 appendString:@" "];
        }
        [str2 appendString:[ch lowercaseString]];
    }
    
    return [str2 stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str2 substringToIndex:1] uppercaseString]];
}


- (void)testCaseDidFinish:(XCTestCase *)testCase {
    if (testCase.testRun.hasSucceeded) {
        [self log:@"✓"];
    }
    
    self.numberOfTests++;
}


- (void)testSuite:(XCTestSuite *)testSuite didFailWithDescription:(NSString *)description inFile:(NSString *)filePath atLine:(NSUInteger)lineNumber {
    NSString *failure = [NSString stringWithFormat:@"FAILURE Suite %@ %@\n%@: %lu\n", testSuite.name, description, filePath, lineNumber];
    [self.suiteFailures addObject:failure];
}


- (void)testSuiteDidFinish:(XCTestSuite *)testSuite {
    [self log:@"\n"];
}


- (void)testBundleDidFinish:(NSBundle *)testBundle {
    [self printTestCaseFailures];
    [self printSuiteFailures];
    [self printSummary];
}


- (void)printTestCaseFailures {
    if ([self.caseFailures count] > 0) {
        for (NSString *failure in self.caseFailures) {
            [self log:failure];
            [self log:@"\n"];
        }
        [self log:@"\n"];
    }
}


- (void)printSuiteFailures {
    if ([self.suiteFailures count] > 0) {
        for (NSString *failure in self.suiteFailures) {
            [self log:failure];
        }
        [self log:@"\n\n"];
    }
}


- (void)printSummary {
    if ([self.caseFailures count] == 0) {
        NSString *statistics = [NSString stringWithFormat:@"Finished in %f seconds\n%lu examples, All green \n\n\n",[[NSDate date] timeIntervalSinceDate:self.startDate], self.numberOfTests];
        [self log:statistics];
    } else {
        NSString *statistics = [NSString stringWithFormat:@"Finished in %f seconds\n%lu examples, %lu failures \n\n\n",[[NSDate date] timeIntervalSinceDate:self.startDate], self.numberOfTests, [self.caseFailures count]];
        [self log:statistics];
    }
}


- (void)log:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    
    NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:args];
    printf("%s", [formattedString UTF8String]);
    
    va_end(args);
}

@end

