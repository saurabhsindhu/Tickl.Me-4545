//
//  CSMapAnnotation.h
//  mapLines
//
//  Created by Craig on 5/15/09.
//  Copyright 2009 Craig Spitzkoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

// types of annotations for which we will provide annotation views. 
typedef enum {
	CSMapAnnotationTypeStart = 0,
	CSMapAnnotationTypeEnd   = 1,
	CSMapAnnotationTypeImage = 2
} CSMapAnnotationType;

@interface CSMapAnnotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D _coordinate;
    NSString*              _title;
    NSString*              _subtitle;

    CSMapAnnotationType    _annotationType;
	NSObject*              _userData;
	NSURL*                 _url;
}

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate 
		  annotationType:(CSMapAnnotationType) annotationType
				   title:(NSString*)title
                subtitle:(NSString*)subtitle;

@property CSMapAnnotationType annotationType;
@property (nonatomic, strong) NSObject* userData;
@property (nonatomic, strong) NSURL* url;


@end
