//
//  MHHTMLParserDelegate.m
//  MHHTMLParser
//
//  Created by Matthias Hochgatterer on 13/05/14.
//  Copyright (c) 2014 Matthias Hochgatterer. All rights reserved.
//

#import "AXHTMLParserDelegate.h"

@implementation AXHTMLParserDelegate

- (void)parserDidStartDocument:(AXHTMLParser *)parser
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parserDidEndDocument:(AXHTMLParser *)parser
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(AXHTMLParser *)parser didStartElement:(NSString *)elementName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ %@ %@", NSStringFromSelector(_cmd), elementName, attributeDict);
}

- (void)parser:(AXHTMLParser *)parser didEndElement:(NSString *)elementName
{
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), elementName);
}

- (void)parser:(AXHTMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), string);
}

- (void)parser:(AXHTMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@ %@", NSStringFromSelector(_cmd), parseError);
}

@end
