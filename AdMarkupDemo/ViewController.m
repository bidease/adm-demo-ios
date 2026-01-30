//  ViewController.m
//  AdMarkupDemo
//

#import "ViewController.h"
#import <Bidease/Bidease.h>
#import "ADMs.h"
#import "RawBid.h"
#import "MyAuctionBid.h"

@interface ViewController()<BideaseShowDelegate,BideaseBannerViewDelegate,BideaseBannerDisplayDelegate>
{
    BideaseInterstitial* interstitial;
    BideaseRewarded* rewarded;
    BDEStickyBannerView* banner;
}

@property(nonatomic) IBOutlet UILabel* statusLabel;

@end

@implementation ViewController

static BOOL startCalled = NO;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!startCalled)
    {
        startCalled = YES;
        
        __weak typeof(self) weakSelf = self;
        [BideaseSDK startWithCompletion:^(BOOL success, NSError * _Nullable error, BOOL isConnectionError) {
            
            if (!success)
            {
                weakSelf.statusLabel.text = [NSString stringWithFormat:@"Bidease SDK start failed. Restart the app. %@", error];
                return;
            }
            
            weakSelf.statusLabel.text = @"Bidease SDK started successfully.";
        }];
    }
}

-(IBAction)showInterstitial:(UIButton*)b
{
    b.enabled = NO;
    interstitial = [[BideaseInterstitial alloc]initWithPlacementId:@"Hello_inter"];
    
    NSString* adm = adm_mraid2_vungle_sample1();
    MyAuctionBid* auctionBid = [[MyAuctionBid alloc]initWithRawBid:[[RawBid alloc]initWithADM:adm size:CGSizeMake(320,480)]];
    
    __weak typeof(self)weakSelf = self;
    [interstitial loadWithBid:auctionBid
                   completion:^(id<BideaseAd> _Nullable ad, NSError * _Nullable error) {
        
        b.enabled = YES;
        if (nil == ad)
        {
            return;
        }
        
        [weakSelf showLoadedInterstitial];
    }];
}

-(void)showLoadedInterstitial
{
    [interstitial showWithDelegate:self];
}

-(IBAction)showRewarded:(UIButton*)b
{
    b.enabled = NO;
    rewarded = [[BideaseRewarded alloc]initWithPlacementId:@"Hello_rewarded"];
    
    NSString* adm = adm_mraid2_vungle_sample1();
    MyAuctionBid* auctionBid = [[MyAuctionBid alloc]initWithRawBid:[[RawBid alloc]initWithADM:adm size:CGSizeMake(320,480)]];
    
    __weak typeof(self)weakSelf = self;
    [rewarded loadWithBid:auctionBid
               completion:^(id<BideaseAd> _Nullable ad, NSError * _Nullable error) {
        
        b.enabled = YES;
        if (nil == ad)
        {
            return;
        }
        
        [weakSelf showLoadedRewarded];
    }];
}

-(void)showLoadedRewarded
{
    [rewarded showWithDelegate:self];
}

-(IBAction)showBanner:(UIButton*)b
{
    b.enabled = NO;
    
    [banner removeFromSuperview];
    banner = [BDEStickyBannerView attachToView:self.view position:BIDEASEADS_BANNER_POSITION_BOTTOM edgeInsets:UIEdgeInsetsZero bannerFormat:BIDEASE_BANNER_320x50 placementId:@"Hello_banner" delegate:self];

    NSString* adm = adm_bidease_320x50_banner_mraid();
    MyAuctionBid* auctionBid = [[MyAuctionBid alloc]initWithRawBid:[[RawBid alloc]initWithADM:adm size:CGSizeMake(320,50)]];
    
    __weak typeof(self) weakSelf = self;
    [banner loadAd:auctionBid
        completion:^(UIView<BideaseAd> * _Nullable ad, NSError * _Nullable error) {
        
        b.enabled = YES;
        if (nil != error)
        {
            return;
        }
        
        [weakSelf showLoadedBanner:ad];
    }];
}

-(void)showLoadedBanner:(UIView<BideaseAd>*)ad
{
    [banner displayAd:ad];
}

- (void)onAdDidDisappear:(nonnull id<BideaseAd>)ad sender:(nonnull BideaseAdvertising *)sender
{
}

- (void)onAdWillAppear:(nonnull id<BideaseAd>)ad sender:(nonnull BideaseAdvertising *)sender
{
}

-(void)onAdDidReceiveReward:(id<BideaseAd>)ad sender:(BideaseAdvertising*)sender
{
}

- (void)bideaseBannerView:(nonnull BideaseBannerView *)view failedToLoadAdWithError:(nonnull NSError *)error isConnectionError:(BOOL)isConnectionError
{
}

- (void)bideaseBannerViewDidLoadAd:(nonnull BideaseBannerView *)view
{
}

- (void)bideaseBannerViewOnClick:(nonnull BDEBaseBannerView *)view error:(NSError * _Nullable)error
{
}

- (nonnull UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

@end
