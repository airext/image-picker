//
//  ANXImagePickerRoutines.h
//  ImagePicker
//
//  Created by Max Rozdobudko on 10/16/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreGraphics/CoreGraphics.h>

#import "FlashRuntimeExtensions.h"

@interface ANXImagePickerConversionRoutines : NSObject

+(BOOL) isNull: (FREObject) object;

+(NSNumber*) getBoolFrom: (FREObject) object forProperty: (NSString*) property;

+(NSNumber*) getNumberFrom: (FREObject) object forProperty: (NSString*) property;

+(NSString*) getStringFrom: (FREObject) object forProperty: (NSString*) property;

+(NSDate*) getDateFrom: (FREObject) object forProperty: (NSString*) property;

+(double) getDoubleFrom: (FREObject) object forProperty: (NSString*) property;

+(CGRect) getRectFrom: (FREObject) object forProperty: (NSString*) property;

+(FREObject) convertNSStringToFREObject:(NSString*) string;
+(NSString*) convertFREObjectToNSString: (FREObject) string;

+(NSDate*) convertFREObjectToNSDate: (FREObject) date;

+(NSUInteger) convertFREObjectToNSUInteger: (FREObject) integer withDefault: (NSUInteger) defaultValue;

+(FREObject) convertLongLongToFREObject: (long long) number;

+(double) convertFREObjectToDouble: (FREObject) number;

+(CGRect) convertFREObjectToCGRect: (FREObject) rectangle;

@end
