//
//  TPMapViewController.m
//  TravelPal
//
//  Created by Kate Liu on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPMapViewController.h"

#import "TPSummaryViewController.h"
#import "TPAnnotation.h"
#import "TPHttpRequest.h"
#import "TPUrl.h"

@interface TPMapViewController () <MKMapViewDelegate>

@property (nonatomic, strong) TPHttpRequest *httpRequest;

@end

@implementation TPMapViewController

-(id) init
{
    self = [super init];
    if (self) {
        _httpRequest = [[TPHttpRequest alloc] init];
    }
    return self;
}


- (void)updateMapView
{
    if (self.mapView.annotations) {
        [self.mapView removeAnnotations:self.mapView.annotations];
    }
    if (self.annotations) {
        [self.mapView addAnnotations:self.annotations];
    }
}

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    [self updateMapView];
}

- (void)setAnnotations:(NSArray *)annotations
{
    _annotations = annotations;
    [self updateMapView];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if (!aView) {
#ifndef APPORTABLE
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
#endif
    }
    aView.annotation = annotation;
    return aView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aView
{
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"callout accessory tapped for annotation %@", [view.annotation title]);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (NSArray *)travelList
//{
//    NSString *userUrl = [[TPUrl usersUrl] stringByAppendingString:self.userId];
//    
//}

//- (NSDictionary *)detailsInTravel
//{
//    NSString *travelUrl = [[TPUrl travelsUrl] stringByAppendingString:self.travelID];
//    NSDictionary *json = [NSDictionary dictionary];
//    [self.httpRequest getFromURL:travelUrl returningJson:&json];
//    if (!json) {
//        return NO;
//    }
//    NSLog(@"travel json: %@", json);
//    return nil;
//}
//
//- (NSDictionary *)detailsInEvent:(NSString *)eventId
//{
//    return nil;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

    MKCoordinateRegion mapRegion;
    CLLocationDegrees latitudeSum = 0.0;
    CLLocationDegrees longitudeSum = 0.0;

    for (TPAnnotation *annotation in self.annotations) {
        latitudeSum += annotation.coordinate.latitude;
        longitudeSum += annotation.coordinate.longitude;
    }

    CLLocationCoordinate2D center;
    center.latitude = [self.annotations count] == 0 ? 0 : (latitudeSum / [self.annotations count]);
    center.longitude = [self.annotations count] == 0 ? 0: (longitudeSum / [self.annotations count]);

    mapRegion.center = center;
    mapRegion.span.latitudeDelta = 0.5;
    mapRegion.span.longitudeDelta = 0.5;
    [self.mapView setRegion:mapRegion animated: YES];
    
    self.mapView.delegate = self;
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)toSummary:(id)sender
{
    TPSummaryViewController* controller = [[TPSummaryViewController alloc] initWithNibName:@"TPSummaryViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
