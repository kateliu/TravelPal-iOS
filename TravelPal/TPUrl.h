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
+(NSString *) travelInfoUrl: (NSString *)travelId;
+(NSString *) travelEventsUrl: (NSString *)travelId;
+(NSString *) endTravelUrl: (NSString *)travelId;
+(NSString *) createEventUrl: (NSString *)travelId;
+(NSString *) getEventUrl: (NSString *)eventId;
+(NSString *) getOpenTravel: (NSString *)userId;
+(NSString *) updateEventUrl: (NSString *)eventId;
+(NSString *) addExpenseUrl: (NSString *)eventId;
+(NSString *) travelSummaryUrl: (NSString *)travelId;


@end
