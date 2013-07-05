#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject <MKAnnotation> {
    NSString *_name;
    NSString *_address;
    NSString *_description;
    CLLocationCoordinate2D _coordinate;
    NSString *_venuAddr;
    NSString *_timeVal;
    NSString *_amt;
    int nTag;
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (copy) NSString *description;
@property (copy) NSString *venuAddr;
@property (copy) NSString *timeVal;
@property NSString *amt;
@property int nTag;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address venuAddress:(NSString*)venuAddr timeValue:(NSString*)timeVal ticket:(NSString*)amt coordinate:(CLLocationCoordinate2D)coordinate;

@end
