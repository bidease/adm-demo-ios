//  MyAuctionBid.m
//  AdMarkupDemo
//

#import "MyAuctionBid.h"
#import <Bidease/Bidease.h>

@implementation MyAuctionBid

-(instancetype)initWithRawBid:(RawBid*)rawBid
{
    if (self = [super init])
    {
        _rawBid = rawBid;
    }
    
    return self;
}

- (nonnull NSNumber *)biddingPrice
{
    return @0.01;
}

- (nonnull NSString *)name
{
    return @"Bidease";
}

//Stub
- (nonnull lose_block_t)onLose
{
    return ^(id<BDEAuctionBid> _Nullable theWinner, id<BDEAuctionBid> _Nullable nextBidAfterWinner) {};
}

//Stub
- (void)onWin:(id<BDEAuctionBid> _Nullable)firstLoser
{
}

@end
