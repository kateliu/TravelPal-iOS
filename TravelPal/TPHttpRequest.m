//
//  TPHttpRequest.m
//  TravelPal
//
//  Created by Kate Liu on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPHttpRequest.h"

@interface TPHttpRequest ()

@property (strong, nonatomic) NSMutableURLRequest *request;

@end


@implementation TPHttpRequest

-(id) init
{
    self = [super init];
    if (self) {
        _request = [[NSMutableURLRequest alloc] init];
    }
    return self;
}

-(void) requestForJson:(NSDictionary **)json
{
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:self.request returningResponse:&response error:&err];
    if (err) {
        NSLog(@"Http connection failed (error code: %d)", err.code);
        return;
    }
    *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
}

-(void) getFromURL:(NSString *)url returningJson:(NSDictionary **)json
{
    [self.request setURL:[NSURL URLWithString:url]];
    [self.request setHTTPMethod:@"GET"];
    [self.request setValue:0 forHTTPHeaderField:@"Content-Length"];
    [self.request setHTTPBody:nil];
    [self requestForJson:json];
}

-(void) getFromURLArray:(NSString *)url returningJson:(NSArray **)json
{
    [self.request setURL:[NSURL URLWithString:url]];
    [self.request setHTTPMethod:@"GET"];
    [self.request setValue:0 forHTTPHeaderField:@"Content-Length"];
    [self.request setHTTPBody:nil];
    [self requestForJsonArray:json];
}

-(void) requestForJsonArray:(NSArray **)json
{
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:self.request returningResponse:&response error:&err];
    if (err) {
        NSLog(@"Http connection failed (error code: %d)", err.code);
        return;
    }
    *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
}

@end
