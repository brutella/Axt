//
//  AXURLHTMLTest.m
//  Axt
//
//  Created by Matthias Hochgatterer on 14/05/14.
//  Copyright (c) 2014 Matthias Hochgatterer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Axt.h"
#import "OCMock.h"
#import "AXHTMLParserDelegate.h"

@interface AXRealWorldHTMLTest : XCTestCase

@end

@implementation AXRealWorldHTMLTest

- (void)testLoadFromURL
{
    NSString *filePath = [[NSBundle bundleForClass:self.class] pathForResource:@"test" ofType:@"html"];
    NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:filePath];
    AXHTMLParser *parser = [[AXHTMLParser alloc] initWithStream:stream];
    
    OCMockObject *delegateMock = [OCMockObject niceMockForProtocol:@protocol(AXHTMLParserDelegate)];
    [delegateMock setExpectationOrderMatters:YES];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parserDidStartDocument:parser];
    
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:parser didStartElement:@"head" attributes:[OCMArg any]];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:parser didEndElement:@"head"];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:parser didStartElement:@"body" attributes:[OCMArg any]];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:parser didEndElement:@"body"];
    
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parserDidEndDocument:parser];
    
    parser.delegate = (id<AXHTMLParserDelegate>)delegateMock;
    [parser parse];
    [delegateMock verify];
}

- (void)_testLoggingDelegateMethods
{
    NSString *htmlString = @"<html>"
    "<head></head>"
    "<body>"
    "<h1>Axt</h1>"
    "<p>A forgiving HTML SAX Parser for iOS<br></p>"
    "</body>"
    "</html>";
    AXHTMLParser *parser = [[AXHTMLParser alloc] initWithHTMLString:htmlString];
    AXHTMLParserDelegate *delegate = [[AXHTMLParserDelegate alloc] init];
    parser.delegate = delegate;
    [parser parse];
}

@end
