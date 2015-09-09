//
//  XCTestObservationCenter+Swizzling.m
//  Test
//
//  Created by Andrei Raifura on 9/9/15.
//  Copyright © 2015 thelvis. All rights reserved.
//

#import "XCTestObservationCenter+Swizzling.h"
#import <objc/runtime.h>
#import "CleanTestObserver.h"

@implementation XCTestObservationCenter (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(addTestObserver:);
        SEL swizzledSelector = @selector(xxx_addTestObserver:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (void)xxx_addTestObserver:(id <XCTestObservation>)testObserver {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self removeDefaultTestLog];
        
        // Add custom selector
        CleanTestObserver *observer = [[CleanTestObserver alloc] init];
        [self xxx_addTestObserver:observer];
    });
    
    if (![testObserver isKindOfClass:NSClassFromString(@"XCTestLog")]) {
        [self xxx_addTestObserver:testObserver];
    }
}

- (void)removeDefaultTestLog {
    SEL aSelector = NSSelectorFromString(@"observers");
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];

    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    [invocation invoke];
    NSSet *returnValue = [NSSet set];
    [invocation getReturnValue:&returnValue];
    
    NSArray *observers = [returnValue allObjects];
    
    for (id object in observers) {
        if ([object isKindOfClass:NSClassFromString(@"XCTestLog")]) {
            [[XCTestObservationCenter sharedTestObservationCenter] removeTestObserver:object];
        }
    }
}

@end