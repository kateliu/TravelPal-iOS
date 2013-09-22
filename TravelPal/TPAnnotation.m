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
    return [self.event objectForKey:[TPEvent eventTitle]];
}

- (NSString *)subtitle
{
    return @"";
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    NSArray *coordinateValues = [self.event objectForKey:[TPEvent eventCoordinate]];
    coordinate.latitude = [coordinateValues[0] doubleValue];
    coordinate.longitude = [coordinateValues[1] doubleValue];
    return coordinate;
}

@end
