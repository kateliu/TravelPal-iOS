//
//  TPAnnotation.h
//  TravelPal
//
//  Created by Kate Liu on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TPAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong) NSDictionary *event;

+ (TPAnnotation *)annotationForEvent:(NSDictionary *)event;

@end
