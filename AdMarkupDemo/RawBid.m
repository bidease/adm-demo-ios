//  RawBid.m
//  AdMarkupDemo
//

#import "RawBid.h"
#import <StoreKit/StoreKit.h>

@implementation RawBid
{
    NSNumber* _storeId;
}

-(instancetype)initWithADM:(NSString*)adm_ size:(CGSize)size storeId:(NSNumber*)storeId
{
    if (self = [super init])
    {
        _adm = adm_;
        _size = size;
        _storeId = storeId;
    }
    
    return self;
}

#pragma mark - BideaseRawBid informal protocol

-(NSString*)requestId
{
    return @"E621E1F8-C36C-495A-93FC-0C247A3E6E5F";
}

-(NSString*)requestIdOfResponse
{
    return self.requestId;
}

-(NSString*)bidId
{
    return @"A310A9A9-E66E-121B-11EC-19947E3A6AAE";
}

-(NSString*)iurl
{
    return nil;
}

-(NSString*)bid_bundle
{
    return nil;
}

-(NSNumber*)maxVideoDurationFromConfig
{
    return nil;
}

-(NSNumber*)embeddedAdDurationInSeconds
{
    return nil;
}

-(NSString*)erid
{
    return nil;
}

-(BOOL)supports_bideaseclick_scheme
{
    return nil != self.skadnProductParameters && nil != self.click_target && nil != self.click_tracking;
}

-(NSString*)crid
{
    return @"00000000000";
}

-(id)skadnProductParameters
{
    if (nil == _storeId)
    {
        return nil;
    }
    
    return @{SKStoreProductParameterITunesItemIdentifier : _storeId};
}

typedef NSString* __nullable (^external_impression_id_source_t)(void);
-(external_impression_id_source_t)getExternalImpressionId
{
    return nil;
}

-(id)click_target
{
    if (nil == _storeId)
    {
        return nil;
    }
    
    return [@"https://apps.apple.com/app/id" stringByAppendingString:_storeId.stringValue];
}

-(id)click_tracking
{
    return @"about:blank";
}

@end

