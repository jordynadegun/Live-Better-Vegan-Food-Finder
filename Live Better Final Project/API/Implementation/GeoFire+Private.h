

#import <GeoFire/GeoFire.h>
#import <CoreLocation/CoreLocation.h>

@interface GeoFire (Private)

- (FIRDatabaseReference *)firebaseRefForLocationKey:(NSString *)key;

+ (CLLocation *)locationFromValue:(id)dict;
+ (NSDictionary *)dictFromLocation:(CLLocation *)location;

@end
