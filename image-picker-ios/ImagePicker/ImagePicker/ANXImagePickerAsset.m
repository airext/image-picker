//
//  ANXImagePickerAsset.m
//  ImagePicker
//
//  Created by Maxim on 10/16/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import "ANXImagePickerConversionRoutines.h"

#import "ANXImagePickerAsset.h"

@implementation ANXImagePickerAsset

#pragma mark Constructor

-(id)initWithAsset:(ALAsset *)asset andURL: (NSURL*) url
{
    self = [super init];
    
    if (self)
    {
        assetURL = [url absoluteString];
        
        assetName = [[asset defaultRepresentation] filename];
        
        if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypePhoto)
        {
            assetType = @"photo";
        }
        else if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypeVideo)
        {
            assetType = @"video";
        }
    }
    
    return self;
}

#pragma mark properties

NSString *assetURL;

NSString *assetName;

NSString *assetType;

#pragma mark methods

-(FREObject) toFREObject
{
    FREResult result;
    
    FREObject asset;
    result = FRENewObject((const uint8_t *) "com.github.airext.data.Asset", 0, NULL, &asset, NULL);
    
    if (result != FRE_OK)
        return NULL;
    
    FREObject url = [ANXImagePickerConversionRoutines convertNSStringToFREObject: assetURL];
    
    result = FRESetObjectProperty(asset, (const uint8_t *) "url", url, NULL);
    
    if (result != FRE_OK)
        return NULL;
    
    FREObject name = [ANXImagePickerConversionRoutines convertNSStringToFREObject: assetName];
    
    result = FRESetObjectProperty(asset, (const uint8_t *) "name", name, NULL);
    
    if (result != FRE_OK)
        return NULL;
    
    FREObject type = [ANXImagePickerConversionRoutines convertNSStringToFREObject: assetType];
    
    result = FRESetObjectProperty(asset, (const uint8_t *) "type", type, NULL);
    
    if (result != FRE_OK)
        return NULL;
    
    return asset;
}

@end
