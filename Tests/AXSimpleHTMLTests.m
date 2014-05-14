//
//  AXHTMLParserTests.m
//  Axt
//
//  Created by Matthias Hochgatterer on 14/05/14.
//  Copyright (c) 2014 Matthias Hochgatterer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "Axt.h"

@interface AXSimpleHTMLTests : XCTestCase

@property (nonatomic, strong) AXHTMLParser *parser;

@end

@implementation AXSimpleHTMLTests

- (void)setUp
{
    [super setUp];
    _parser = [[AXHTMLParser alloc] initWithHTMLString:@"<html><head></head><body><p>This is the first paragraph</p></body></html>"];
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
    [_parser parse];
    [delegateMock verify];
}

- (void)testHeadAndBodyFound
{
    OCMockObject *delegateMock = [OCMockObject niceMockForProtocol:@protocol(AXHTMLParserDelegate)];
    [delegateMock setExpectationOrderMatters:YES];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser didStartElement:@"head" attributes:@{}];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser didEndElement:@"head"];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser didStartElement:@"body" attributes:@{}];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser didEndElement:@"body"];
    
    _parser.delegate = (id<AXHTMLParserDelegate>)delegateMock;
    [_parser parse];
    [delegateMock verify];
}

- (void)testFoundCharacters
{
    OCMockObject *delegateMock = [OCMockObject niceMockForProtocol:@protocol(AXHTMLParserDelegate)];
    [delegateMock setExpectationOrderMatters:YES];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser didStartElement:@"p" attributes:@{}];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser foundCharacters:@"This is the first paragraph"];
    [(id<AXHTMLParserDelegate>)[delegateMock expect] parser:_parser didEndElement:@"p"];
    
    _parser.delegate = (id<AXHTMLParserDelegate>)delegateMock;
    [_parser parse];
    [delegateMock verify];
}

@end
