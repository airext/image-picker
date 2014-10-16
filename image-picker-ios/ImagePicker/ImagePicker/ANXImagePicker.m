//
//  ImagePicker.m
//  ImagePicker
//
//  Created by Maxim on 10/16/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import <MobileCoreServices/UTCoreTypes.h>

#import "ANXImagePicker.h"

@implementation ANXImagePicker

#pragma mark Shared Instance

static ANXImagePicker* _sharedInstance = nil;

+(ANXImagePicker*) sharedInstance
{
    if (_sharedInstance == nil)
    {
        _sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return _sharedInstance;
}

#pragma mark Constructor

- (id)init
{
    self = [super init];
    
    if (self)
    {
        assets = [NSMutableDictionary dictionary];
        inputs = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark Properties

@synthesize context;

#pragma mark Variables

ALAssetsLibrary *acquiredLibrary;

NSMutableDictionary *assets;

NSMutableDictionary *inputs;

#pragma mark Methods: Library

-(ALAssetsLibrary*) acquireLibrary
{
    if (acquiredLibrary == nil)
    {
        acquiredLibrary = [[ALAssetsLibrary alloc] init];
    }
    
    return acquiredLibrary;
}

-(void) releaseLibrary
{
    if (acquiredLibrary != nil)
    {
        if ([assets count] == 0 && [inputs count] == 0)
        {
            acquiredLibrary = nil;
        }
    }
}

#pragma mark Methods: API Funcitons

-(BOOL) isSupported
{
    return true;
}

-(BOOL) browse:(NSDictionary *)options
{
    NSMutableArray *mediaTypes = [NSMutableArray array];
    
    NSArray *availableTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    if ([[options valueForKey:@"image"] boolValue] == YES)
    {
        if ([availableTypes containsObject:(NSString *)kUTTypeImage])
        {
            [mediaTypes addObject:(NSString *)kUTTypeImage];
        }
    }
    
    if ([[options valueForKey:@"video"] boolValue] == YES)
    {
        if ([availableTypes containsObject:(NSString *)kUTTypeMovie])
        {
            [mediaTypes addObject:(NSString *)kUTTypeMovie];
        }
    }
    
    if ([mediaTypes count] == 0)
    {
        [self dispatch:@"ImagePicker.Browse.Failed" withLevel:@"The selected media type is not available."];
        
        return false;
    }
    
    UIViewController *currentRootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    UIImagePickerController *currentImagePickerController = [[UIImagePickerController alloc] init];
    
    currentImagePickerController.delegate = self;
    currentImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    currentImagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    currentImagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    currentImagePickerController.mediaTypes = mediaTypes;
    currentImagePickerController.allowsEditing = NO;
    
    [currentRootViewController presentViewController: currentImagePickerController animated:YES completion:^{
        [self dispatchStatus:@"ImagePicker.Open"];
    }];
    
    return false;
}

#pragma mark Methods: API Funcitons Assets

-(ANXImagePickerAsset*) getAsset: (NSString*) url
{
    ANXImagePickerAsset *asset = [assets objectForKey:url];
    
    [assets removeObjectForKey:url];
    
    [self releaseLibrary];
    
    return asset;
}

#pragma mark Methods: API Funcitons AssetsInput

-(void) openAssetInput: (NSString*) url
{
    ALAssetsLibrary *library = [self acquireLibrary];
    
    [library assetForURL: [NSURL URLWithString: url]
        resultBlock: ^(ALAsset *asset)
        {
            if ([inputs objectForKey: url] == nil)
            {
                ANXImagePickerAssetInput *input =  [[ANXImagePickerAssetInput alloc] initWithAsset: asset];
             
                [inputs setValue:input forKey:url];
            }
         
            [self dispatch:@"ImagePicker.AssetInput.Open.Success" withLevel: url];
        }
        failureBlock: ^(NSError *error)
        {
            [self dispatch:@"ImagePicker.AssetInput.Open.Failed" withLevel: url];
         
            [self releaseLibrary];
        }];
}

-(ANXImagePickerAssetInput*) getAssetInput: (NSString*) url
{
    ANXImagePickerAssetInput *input = [inputs objectForKey: url];
    
    if (input == nil)
    {
        [self dispatch:@"ImagePicker.AssetInput.NotAvailable" withLevel: url];
    }
    
    return input;
}

-(void) closeAssetInput: (NSString*) url
{
    [inputs removeObjectForKey: url];
    
    [self releaseLibrary];
}

#pragma mark Callbacks

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    NSURL *assetURL = info[UIImagePickerControllerReferenceURL];
    
    ALAssetsLibrary *library = [self acquireLibrary];
    
    [library assetForURL: assetURL
        resultBlock: ^(ALAsset *asset)
        {
            if ([assets objectForKey: assetURL.absoluteString] == nil)
            {
                ANXImagePickerAsset *promise = [[ANXImagePickerAsset alloc] initWithAsset: asset andURL: assetURL];
             
                [assets setValue:promise forKey:assetURL.absoluteString];
            }
         
            [self dispatch:@"ImagePicker.Browse.Select" withLevel:assetURL.absoluteString];
        }
        failureBlock: ^(NSError *error)
        {
            [self dispatch:@"ImagePicker.Browse.Failed" withLevel:error.localizedDescription];
        }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dispatchStatus:@"ImagePicker.Browse.Cancel"];

    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Dispatch events

-(void) dispatch: (NSString *) code withLevel: (NSString *) level
{
    FREDispatchStatusEventAsync(context, (const uint8_t*) [code UTF8String], (const uint8_t*) [level UTF8String]);
}

-(void) dispatchError: (NSString *)code
{
    [self dispatch:code withLevel:@"error"];
}

-(void) dispatchStatus: (NSString *)code
{
    [self dispatch:code withLevel:@"status"];
}

@end
