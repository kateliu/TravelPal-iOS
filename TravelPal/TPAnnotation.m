//
//  TPAnnotation.m
//  TravelPal
//
//  Created by Kate Liu on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPAnnotation.h"
#import "TPEvent.h"

@implementation TPAnnotation

+ (TPAnnotation *)annotationForEvent:(NSDictionary *)event
{
    TPAnnotation *annotation = [[TPAnnotation alloc] init];
    annotation.event = event;
    return annotation;
}


- (NSString *)title
{
    return [self.event objectForKey:EVENT_TITLE];
}

- (NSString *)subtitle
{
    return [self.event objectForKey:EVENT_DESCRIPTION];
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.event objectForKey:EVENT_LATITUDE] doubleValue];
    coordinate.longitude = [[self.event objectForKey:EVENT_LONGITUDE] doubleValue];
    return coordinate;
}

@end
