

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "GFGeoHash.h"

@interface GFGeoHashQuery : NSObject<NSCopying>

@property (nonatomic, strong, readonly) NSString *startValue;
@property (nonatomic, strong, readonly) NSString *endValue;

+ (NSSet *)queriesForLocation:(CLLocationCoordinate2D)location radius:(double)radius;
+ (NSSet *)queriesForRegion:(MKCoordinateRegion)region;

- (BOOL)containsGeoHash:(GFGeoHash *)hash;

- (BOOL)canJoinWith:(GFGeoHashQuery *)other;
- (GFGeoHashQuery *)joinWith:(GFGeoHashQuery *)other;

@end
