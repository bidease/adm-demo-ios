//  ViewController.m
//  AdMarkupDemo
//

#import "ViewController.h"
#import <Bidease/Bidease.h>
#import "ADMs.h"
#import "RawBid.h"
#import "MyAuctionBid.h"

@interface ViewController()<BideaseShowDelegate,BideaseBannerViewDelegate,BideaseBannerDisplayDelegate,UITextFieldDelegate>
{
    IBOutlet UITextView* textView;
    IBOutlet UITextField* storeIdTextField;
}

@property(nonatomic) IBOutlet UILabel* statusLabel;

@property(nonatomic) BideaseInterstitial* interstitial;
@property(nonatomic) BideaseRewarded* rewarded;
@property(nonatomic) BDEStickyBannerView* banner;

@end

@implementation ViewController

@synthesize interstitial,rewarded,banner;

- (BOOL)textView:(UITextView *)textView
 shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {

    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

static BOOL startCalled = NO;

extern BOOL BideaseSDK_ignoreTmax;//Ignore timeouts

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!startCalled)
    {
        startCalled = YES;
        
        BideaseSDK_ignoreTmax = YES;
        
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

-(NSString*)adm
{
    NSString* txt = [textView.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (txt.length == 0)
    {
        return nil;
    }
    
    return txt;
}

-(NSNumber*)storeId
{
    NSInteger i = storeIdTextField.text.integerValue;
    if (i == 0)
    {
        return nil;
    }
    
    return @(i);
}

typedef void(^get_adm_completion_t)(NSString* __nullable adm, NSNumber* __nullable storeId);
-(void)get_ADM_format:(NSString*)format completion:(get_adm_completion_t)completion
{
    NSString* adm = self.adm;
    NSNumber* storeId = self.storeId;
    if (nil == adm)
    {
        if ([format containsString:@"x"])//Banner
        {
            adm = adm_bidease_320x50_banner_mraid();
            storeId = nil;
        }
        else
        {
            adm = adm_mraid2_vungle_sample1();
            storeId = storeId_mraid2_vungle_sample1();
        }
        
        return completion(adm,storeId);
    }
    
    if ([adm hasPrefix:@"http"])
    {
        return dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURL* url = [NSURL URLWithString:adm];
            if (nil == url)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil,nil);
                });
            }
            
            NSData* d = [NSData dataWithContentsOfURL:url];
            if (nil == d)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil,nil);
                });
            }
            
            NSString* s = [[NSString alloc]initWithData:d encoding:NSUTF8StringEncoding];
            if (nil == s)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil,nil);
                });
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(s,storeId);
            });
        });
    }
    
    return completion(adm,storeId);
}

-(IBAction)showInterstitial:(UIButton*)b
{
    b.enabled = NO;
    interstitial = [[BideaseInterstitial alloc]initWithPlacementId:@"Hello_inter"];
    
    __weak typeof(self)weakSelf = self;
    [self get_ADM_format:BIDEASE_INTERSTITIAL
              completion:^(NSString * _Nullable adm, NSNumber * _Nullable storeId) {
        
        if (nil == adm)
        {
            return;
        }
        
        MyAuctionBid* auctionBid = [[MyAuctionBid alloc]initWithRawBid:[[RawBid alloc]initWithADM:adm size:CGSizeMake(320,480) storeId:storeId]];
        
        
        [weakSelf.interstitial loadWithBid:auctionBid
                                completion:^(id<BideaseAd> _Nullable ad, NSError * _Nullable error) {
            
            b.enabled = YES;
            if (nil == ad)
            {
                return;
            }
            
            [weakSelf showLoadedInterstitial];
        }];
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
    
    __weak typeof(self)weakSelf = self;
    [self get_ADM_format:BIDEASE_REWARDED_INTERSTITIAL
              completion:^(NSString * _Nullable adm, NSNumber * _Nullable storeId) {
        
        if (nil == adm)
        {
            return;
        }
        
        MyAuctionBid* auctionBid = [[MyAuctionBid alloc]initWithRawBid:[[RawBid alloc]initWithADM:adm size:CGSizeMake(320,480) storeId:storeId]];
        
        [weakSelf.rewarded loadWithBid:auctionBid
                            completion:^(id<BideaseAd> _Nullable ad, NSError * _Nullable error) {
            
            b.enabled = YES;
            if (nil == ad)
            {
                return;
            }
            
            [weakSelf showLoadedRewarded];
        }];
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
    
    __weak typeof(self)weakSelf = self;
    [self get_ADM_format:BIDEASE_BANNER_320x50
              completion:^(NSString * _Nullable adm, NSNumber * _Nullable storeId) {
        
        MyAuctionBid* auctionBid = [[MyAuctionBid alloc]initWithRawBid:[[RawBid alloc]initWithADM:adm size:CGSizeMake(320,50) storeId:nil]];
        [weakSelf.banner loadAd:auctionBid
                     completion:^(UIView<BideaseAd> * _Nullable ad, NSError * _Nullable error) {
            
            b.enabled = YES;
            if (nil != error)
            {
                return;
            }
            
            [weakSelf showLoadedBanner:ad];
        }];
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
