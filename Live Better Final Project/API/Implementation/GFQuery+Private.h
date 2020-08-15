

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "GFQuery.h"
#import "GFRegionQuery.h"
#import "GFCircleQuery.h"

@class GeoFire;

@interface GFQuery (Private)

- (id)initWithGeoFire:(GeoFire *)geoFire;
- (BOOL)locationIsInQuery:(CLLocation *)location;
- (void)searchCriteriaDidChange;
- (NSSet *)queriesForCurrentCriteria;

@end

@interface GFCircleQuery (Private)

- (id)initWithGeoFire:(GeoFire *)geoFire
             location:(CLLocation *)location
               radius:(double)radius;

@end

@interface GFRegionQuery (Private)

- (id)initWithGeoFire:(GeoFire *)geoFire region:(MKCoordinateRegion)region;

@end
