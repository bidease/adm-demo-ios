//  RawBid.h
//  AdMarkupDemo
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString* __nullable (^external_impression_id_source_t)(void);

@interface RawBid : NSObject

@property(nonatomic,readonly) NSString* adm;
@property(nonatomic,readonly) CGSize size;
@property(nonatomic,nullable) external_impression_id_source_t getExternalImpressionId;

-(instancetype)initWithADM:(NSString*)adm size:(CGSize)size storeId:(NSNumber* __nullable)storeId;

@end

NS_ASSUME_NONNULL_END
