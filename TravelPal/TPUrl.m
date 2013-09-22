//
//  TPUrl.m
//  TravelPal
//
//  Created by Kate Liu on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPUrl.h"

@implementation TPUrl

static NSString *travelPalUrl = @"http://travelpal.herokuapp.com";
static NSString *travelsPath = @"/travels/";
static NSString *eventsPath = @"/events/";
static NSString *usersPath = @"/users/";

+(NSString *) travelsUrl
{
    return [travelPalUrl stringByAppendingString: travelsPath];
}

+(NSString *) eventsUrl
{
    return [travelPalUrl stringByAppendingString: eventsPath];
}

+(NSString *) usersUrl
{
    return [travelPalUrl stringByAppendingString: usersPath];
}

+(NSString *) travelEventsUrl: (NSString *)travelId
{
    return [travelPalUrl stringByAppendingString: [NSString stringWithFormat:@"/travels/%@/events", travelId]];
}

+(NSString *) endTravelUrl: (NSString *)travelId
{
    return [travelPalUrl stringByAppendingString: [NSString stringWithFormat:@"/travels/%@/end", travelId]];
}

+(NSString *) createEventUrl: (NSString *)travelId
{
    return [travelPalUrl stringByAppendingString: [NSString stringWithFormat:@"/travels/%@/events", travelId]];
}

+(NSString *) updateEventUrl: (NSString *)eventId
{
    return [travelPalUrl stringByAppendingString: [NSString stringWithFormat:@"/events/%@/update", eventId]];
}

+(NSString *) getEventUrl: (NSString *)eventId
{
    return [travelPalUrl stringByAppendingString: [NSString stringWithFormat:@"/events/%@", eventId]];
}

+(NSString *) getOpenTravel: (NSString *)userId
{
    return [travelPalUrl stringByAppendingString: [NSString stringWithFormat:@"/users/%@/open", userId]];
}

+(NSString *) addExpenseUrl: (NSString *)eventId
{
    return [travelPalUrl stringByAppendingString: [NSString stringWithFormat:@"/events/%@/expenses", eventId]];
}

@end
