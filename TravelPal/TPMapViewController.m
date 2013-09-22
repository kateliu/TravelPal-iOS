//
//  TPMapViewController.m
//  TravelPal
//
//  Created by Kate Liu on 9/21/13.
//  Copyright (c) 2013 ok. All rights reserved.
//

#import "TPMapViewController.h"

#import "TPHttpRequest.h"
#import "TPUrl.h"

@interface TPMapViewController () <MKMapViewDelegate>

@end

@implementation TPMapViewController

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
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
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

- (NSDictionary *)detailInTravel
{
//    NSString *travelUrl = [[TPUrl travelsUrl] stringByAppendingString:self.travelID];
//    NSDictionary *json = [NSDictionary dictionary];
//    [self.httpRequest getFromURL:url returningJson:&json];
//    if (!json) {
//        return NO;
//    }
//
    return nil;
}

- (NSDictionary *)detailInEvent:(NSString *)eventId
{
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.travelID = @"-J42aiKDIcGz24EDoif3";

//    MKCoordinateRegion mapRegion;
//    CLLocationCoordinate2D coordinate;
//    coordinate.latitude = 37.111;
//    coordinate.longitude = 121.111;
//    mapRegion.center = coordinate;
//    mapRegion.span.latitudeDelta = 10.0;
//    mapRegion.span.longitudeDelta = 10.0;
//    [self.mapView setRegion:mapRegion animated: YES];
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

@end
