//  MyAuctionBid.h
//  AdMarkupDemo
//

#import <Foundation/Foundation.h>
#import <Bidease/BDEAuctionBid.h>

@class RawBid;

NS_ASSUME_NONNULL_BEGIN

@interface MyAuctionBid : NSObject<BDEAuctionBid>

@property(nonatomic,readonly) RawBid* rawBid;

-(instancetype)initWithRawBid:(RawBid*)rawBid;

@end

NS_ASSUME_NONNULL_END
