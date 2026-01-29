//  RawBid.m
//  AdMarkupDemo
//

#import "RawBid.h"

@implementation RawBid

-(instancetype)initWithADM:(NSString*)adm_ size:(CGSize)size
{
    if (self = [super init])
    {
        _adm = adm_;
        _size = size;
    }
    
    return self;
}

#pragma mark - Stubs for BideaseRawBid informal protocol

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
    return NO;
}

-(NSString*)crid
{
    return @"00000000000";
}

-(id)skadnProductParameters
{
    return nil;
}

typedef NSString* __nullable (^external_impression_id_source_t)(void);
-(external_impression_id_source_t)getExternalImpressionId
{
    return nil;
}

-(id)click_target
{
    return nil;
}

-(id)click_tracking
{
    return nil;
}

@end

