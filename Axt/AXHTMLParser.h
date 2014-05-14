//
//  AXHTMLParser.h
//  AXHTMLParser
//
//  Created by Matthias Hochgatterer on 13/05/14.
//  Copyright (c) 2014 Matthias Hochgatterer. All rights reserved.
//

#import <Foundation/Foundation.h>

// http://www.jamesh.id.au/articles/libxml-sax/libxml-sax.html

@protocol AXHTMLParserDelegate;
@interface AXHTMLParser : NSObject

@property (nonatomic, strong) NSError *parserError;
@property (nonatomic, weak) id<AXHTMLParserDelegate> delegate;

- (instancetype)initWithHTMLString:(NSString *)string;
- (instancetype)initWithStream:(NSInputStream *)stream;

- (BOOL)parse;
- (void)abortParsing;

@end

@protocol AXHTMLParserDelegate <NSObject>

- (void)parserDidStartDocument:(AXHTMLParser *)parser;
- (void)parserDidEndDocument:(AXHTMLParser *)parser;
- (void)parser:(AXHTMLParser *)parser didStartElement:(NSString *)elementName attributes:(NSDictionary *)attributeDict;
- (void)parser:(AXHTMLParser *)parser didEndElement:(NSString *)elementName;
- (void)parser:(AXHTMLParser *)parser foundCharacters:(NSString *)string;
- (void)parser:(AXHTMLParser *)parser parseErrorOccurred:(NSError *)parseError;

@end

static NSString *const AXHTMLErrorDomain = @"at.mah.axhtmlparser";

typedef NS_ENUM(NSInteger, AXHTMLError) {
    AXHTMLErrorUndefined = -1,
    AXHTMLErrorAborted = 1
};
