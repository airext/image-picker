//
//  ANXImagePickerFacade.m
//  ImagePicker
//
//  Created by Max Rozdobudko on 10/16/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import "ANXImagePicker.h"

#import "ANXImagePickerConversionRoutines.h"

#import "ANXImagePickerFacade.h"

@implementation ANXImagePickerFacade

@end

#pragma mark API

FREObject ANXImagePickerIsSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject supported;
    
    FRENewObjectFromBool([[ANXImagePicker sharedInstance] isSupported], &supported);
    
    return supported;
}

FREObject ANXImagePickerBrowse(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    
    [options setValue:[ANXImagePickerConversionRoutines getBoolFrom:argv[0] forProperty:@"video"] forKey:@"video"];
    
    [options setValue:[ANXImagePickerConversionRoutines getBoolFrom:argv[0] forProperty:@"image"] forKey:@"image"];
    
    [[ANXImagePicker sharedInstance] browse:options];
    
    return NULL;
}

FREObject ANXImagePickerGetAsset(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSString *url = [ANXImagePickerConversionRoutines convertFREObjectToNSString:argv[0]];
    
    ANXImagePickerAsset *asset = [[ANXImagePicker sharedInstance] getAsset:url];
    
    return [asset toFREObject];
}

FREObject ANXImagePickerAssetInputOpen(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSString *url = [ANXImagePickerConversionRoutines convertFREObjectToNSString: argv[0]];
    
    NSLog(@"ANXImagePickerAssetInputOpen: %@", url);
    
    [[ANXImagePicker sharedInstance] openAssetInput: url];
    
    return NULL;
}

FREObject ANXImagePickerAssetInputClose(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSString *url = [ANXImagePickerConversionRoutines convertFREObjectToNSString:argv[0]];
    
    NSLog(@"ANXImagePickerAssetInputClose: %@", url);
    
    [[ANXImagePicker sharedInstance] closeAssetInput: url];
    
    return NULL;
}

FREObject ANXImagePickerAssetInputGetSize(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSString *url = [ANXImagePickerConversionRoutines convertFREObjectToNSString:argv[0]];
    
    NSLog(@"ANXImagePickerAssetInputGetSize: %@", url);
    
    ANXImagePickerAssetInput *input = [[ANXImagePicker sharedInstance] getAssetInput: url];
    
    if (input == nil)
    {
        return NULL;
    }
    
    return [ANXImagePickerConversionRoutines convertLongLongToFREObject:[input getSize]];
}

FREObject ANXImagePickerAssetInputReadBytes(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSString *url = [ANXImagePickerConversionRoutines convertFREObjectToNSString:argv[0]];
    
    NSLog(@"ANXImagePickerAssetInputReadBytes: %@", url);
    
    ANXImagePickerAssetInput *input = [[ANXImagePicker sharedInstance] getAssetInput: url];
    
    if (input == nil)
    {
        return NULL;
    }
    
    NSUInteger offset = [ANXImagePickerConversionRoutines convertFREObjectToNSUInteger:argv[2] withDefault:0];
    
    NSUInteger length = [ANXImagePickerConversionRoutines convertFREObjectToNSUInteger:argv[3] withDefault:0];
    
    [input readBytes:argv[1] fromOffset:offset desiredLength:length];
    
    return NULL;
}

#pragma mark ContextInitializer/ContextFinalizer

void ANXImagePickerContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 7;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &ANXImagePickerIsSupported;
    
    func[1].name = (const uint8_t*) "browse";
    func[1].functionData = NULL;
    func[1].function = &ANXImagePickerBrowse;
    
    func[2].name = (const uint8_t*) "getAsset";
    func[2].functionData = NULL;
    func[2].function = &ANXImagePickerGetAsset;
    
    func[3].name = (const uint8_t*) "assetInputOpen";
    func[3].functionData = NULL;
    func[3].function = &ANXImagePickerAssetInputOpen;
    
    func[4].name = (const uint8_t*) "assetInputClose";
    func[4].functionData = NULL;
    func[4].function = &ANXImagePickerAssetInputClose;
    
    func[5].name = (const uint8_t*) "assetInputGetSize";
    func[5].functionData = NULL;
    func[5].function = &ANXImagePickerAssetInputGetSize;
    
    func[6].name = (const uint8_t*) "assetInputReadBytes";
    func[6].functionData = NULL;
    func[6].function = &ANXImagePickerAssetInputReadBytes;
    
    *functionsToSet = func;
    
    [ANXImagePicker sharedInstance].context = ctx;
}

void ANXImagePickerContextFinalizer(FREContext ctx)
{
    [ANXImagePicker sharedInstance].context = nil;
}

#pragma mark Initializer/Finalizer

void ANXImagePickerInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    NSLog(@"ANXImagePickerInitializer");
    
    *extDataToSet = NULL;
    
    *ctxInitializerToSet = &ANXImagePickerContextInitializer;
    *ctxFinalizerToSet = &ANXImagePickerContextFinalizer;
}

void ANXImagePickerFinalizer(void* extData)
{
    NSLog(@"ANXImagePickerFinalizer");
}