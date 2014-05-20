//
//  AXPartialHTMLTests.m
//  Axt
//
//  Created by Matthias Hochgatterer on 20/05/14.
//  Copyright (c) 2014 Matthias Hochgatterer. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Axt.h"
#import "OCMock.h"

@interface AXPartialHTMLTests : XCTestCase

@property (nonatomic, strong) AXHTMLParser *parser;

@end

@implementation AXPartialHTMLTests

- (void)setUp
{
    [super setUp];
    _parser = [[AXHTMLParser alloc] initWithHTMLString:@"<h1>header<p>paragraph<br></p>"];
}

- (void)testParseSuccess
{
    BOOL result = [_parser parse];
    XCTAssertTrue(result, @"Parsing failed");
}

- (void)testStartDocument
{
    OCMockObject *delegateMock = [OCMockObject niceMockForProtocol:@protocol(AXHTMLParserDelegate)];
    [delegateMock setExpectationOrderMatters:YES];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parserDidStartDocument:_parser];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parserDidEndDocument:_parser];;
    
    _parser.delegate = (id<AXHTMLParserDelegate>)delegateMock;
    BOOL result = [_parser parse];
    XCTAssertTrue(result, @"Parsing failed");
    [delegateMock verify];
}

- (void)testMissingClosingLineBreak
{
    OCMockObject *delegateMock = [OCMockObject niceMockForProtocol:@protocol(AXHTMLParserDelegate)];
    [delegateMock setExpectationOrderMatters:YES];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser didStartElement:@"br" attributes:@{}];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser didEndElement:@"br"];
    
    _parser.delegate = (id<AXHTMLParserDelegate>)delegateMock;
    [_parser parse];
    [delegateMock verify];
}

- (void)testMissingClosingHeader
{
    OCMockObject *delegateMock = [OCMockObject niceMockForProtocol:@protocol(AXHTMLParserDelegate)];
    [delegateMock setExpectationOrderMatters:YES];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser didStartElement:@"h1" attributes:@{}];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser foundCharacters:@"header"];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser didEndElement:@"h1"];
    
    _parser.delegate = (id<AXHTMLParserDelegate>)delegateMock;
    [_parser parse];
    [delegateMock verify];
}

@end
