//
//  TPUrl.h
//  TravelPal
//
//  Created by Kate Liu on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPUrl : NSObject

+(NSString *) travelsUrl;
+(NSString *) eventsUrl;
+(NSString *) usersUrl;
+(NSString *) travelEventsUrl: (NSString *)travelId;
+(NSString *) endTravelUrl: (NSString *)travelId;
+(NSString *) createEventUrl: (NSString *)travelId;

@end
