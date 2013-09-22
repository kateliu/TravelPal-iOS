//
//  TPEvent.m
//  TravelPal
//
//  Created by Kate Liu on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPEvent.h"

#define EVENT_DESCRIPTION @"description"
#define EVENT_EXPENSE @"expense"
#define EVENT_LOCATION @"location"

static NSString *title = @"descriptoin";
static NSString *subtitle = @"expense";
static NSString *coordinate = @"location";

@implementation TPEvent

+(NSString *) eventTitle
{
    return title;
}

+(NSString *) eventSubtitle
{
    return subtitle;
}

+(NSString *) eventCoordinate
{
    return coordinate;
}

@end
