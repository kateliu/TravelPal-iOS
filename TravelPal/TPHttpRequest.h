//
//  TPHttpRequest.h
//  TravelPal
//
//  Created by Kate Liu on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPHttpRequest : NSObject

-(void) getFromURL:(NSString *)url returningJson:(NSDictionary **)json;

@end
