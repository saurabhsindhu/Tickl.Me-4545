#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject <MKAnnotation> {
    NSString *_name;
    NSString *_address;
    NSString *_description;
    CLLocationCoordinate2D _coordinate;
    int nTag;
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (copy) NSString *description;
@property int nTag;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
