#import "MyLocation.h"

@implementation MyLocation
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;
@synthesize description = _description;
@synthesize venuAddr = _venuAddr;
@synthesize timeVal = _timeVal;
@synthesize amt = _amt;
@synthesize nTag;

- (id)initWithName:(NSString*)name address:(NSString*)address venuAddress:(NSString*)venuAddr timeValue:(NSString*)timeVal ticket:(NSString*)amt coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _venuAddr = [venuAddr copy];
        _coordinate = coordinate;
        _timeVal = [timeVal copy];
        _amt = [amt copy];
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]]) 
        return @"Unknown charge";
    else
        return _name;
}

- (NSString *)subtitle {
    return _address;
}





@end