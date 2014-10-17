//
//  ANXImagePickerRoutines.m
//  ImagePicker
//
//  Created by Max Rozdobudko on 10/16/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import "ANXImagePickerConversionRoutines.h"

@implementation ANXImagePickerConversionRoutines

+(NSNumber*) getBoolFrom: (FREObject) object forProperty: (NSString*) property
{
    FREResult result;
    
    FREObject propertyValue;
    
    result = FREGetObjectProperty(object, (const uint8_t*) [property UTF8String], &propertyValue, NULL);
    
    if (result != FRE_OK)
        return [NSNumber numberWithBool:NO];
    
    uint32_t tempValue;
    
    result = FREGetObjectAsBool(propertyValue, &tempValue);
    
    if (result != FRE_OK)
        return [NSNumber numberWithBool:NO];;
    
    return [NSNumber numberWithBool:tempValue];
}

+(NSNumber*) getNumberFrom: (FREObject) object forProperty: (NSString*) property
{
    FREResult result;
    
    FREObject propertyValue;
    
    result = FREGetObjectProperty(object, (const uint8_t*) [property UTF8String], &propertyValue, NULL);
    
    if (result != FRE_OK)
        return nil;
    
    double tempValue;
    
    result = FREGetObjectAsDouble(object, &tempValue);
    
    if (result != FRE_OK)
        return nil;
    
    return [NSNumber numberWithDouble:tempValue];
}

+(NSString*) getStringFrom: (FREObject) object forProperty: (NSString*) property
{
    FREResult result;
    
    FREObject propertyValue;
    
    result = FREGetObjectProperty(object, (const uint8_t*) [property UTF8String], &propertyValue, NULL);
    
    if (result != FRE_OK)
        return nil;
    
    return [self convertFREObjectToNSString:propertyValue];
}

+(NSDate*) getDateFrom: (FREObject) object forProperty: (NSString*) property
{
    FREResult result;
    
    FREObject propertyValue;
    
    result = FREGetObjectProperty(object, (const uint8_t*) [property UTF8String], &propertyValue, NULL);
    
    if (result != FRE_OK)
        return nil;
    
    return [self convertFREObjectToNSDate:propertyValue];
}

+(FREObject) convertNSStringToFREObject:(NSString*) string
{
    if (string == nil) return NULL;
    
    const char* utf8String = string.UTF8String;
    
    unsigned long length = strlen( utf8String );
    
    FREObject result;
    FRENewObjectFromUTF8((uint32_t) length + 1, (const uint8_t*) utf8String, &result);
    
    return result;
}

+(NSString*) convertFREObjectToNSString: (FREObject) string
{
    FREResult result;
    
    uint32_t length = 0;
    const uint8_t* tempValue = NULL;
    
    result = FREGetObjectAsUTF8(string, &length, &tempValue);
    
    if (result != FRE_OK)
        return nil;
    
    return [NSString stringWithUTF8String: (char*) tempValue];
}


+(NSDate*) convertFREObjectToNSDate: (FREObject) date
{
    FREResult result;
    
    FREObject time;
    result = FREGetObjectProperty(date, (const uint8_t*) "time", &time, NULL);
    
    if (result != FRE_OK)
        return nil;
    
    NSTimeInterval interval;
    
    result = FREGetObjectAsDouble(time, &interval);
    
    if (result != FRE_OK)
        return nil;
    
    interval = interval / 1000;
    
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

+(NSUInteger) convertFREObjectToNSUInteger: (FREObject) integer withDefault: (NSUInteger) defaultValue;
{
    FREResult result;
    
    uint32_t tempValue;
    
    result = FREGetObjectAsUint32(integer, &tempValue);
    
    if (result != FRE_OK)
        return defaultValue;
    
    return (NSUInteger) tempValue;
}

+(FREObject) convertLongLongToFREObject: (long long) number
{
    FREObject result;
    FRENewObjectFromUint32((uint32_t) number, &result);
    
    return result;
}

@end
