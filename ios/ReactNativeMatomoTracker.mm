#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ReactNativeMatomoTracker, NSObject)


RCT_EXTERN_METHOD(createTracker:(NSString *)uri withSiteId:(NSString *)siteId)

RCT_EXTERN_METHOD(trackScreen:(NSString *)screenName withTitle:(NSString *)title)

RCT_EXTERN_METHOD(trackDispatch)

RCT_EXTERN_METHOD(trackEvent:(NSString *)category withAction:(NSString *)action withName:(NSString *)name withValue:(NSNumber *)value)

RCT_EXTERN_METHOD(trackOutlink:(NSString *)url)

RCT_EXTERN_METHOD(trackSearch:(NSString *)keyword)

RCT_EXTERN_METHOD(trackImpression:(NSString *)contentName)

RCT_EXTERN_METHOD(trackInteraction:(NSString *)contentName withContentInteraction:(NSString *)contentInteraction)

RCT_EXTERN_METHOD(trackDownload:(NSString *)category withAction:(NSString *)action withUrl:(NSString *)url)

RCT_EXTERN_METHOD(setUserId:(NSString *)id)

RCT_EXTERN_METHOD(trackScreens)

RCT_EXTERN_METHOD(trackGoal:(NSInteger)goalId withRevenue:(float *)revenue)

RCT_EXTERN_METHOD(setVisitorId:(NSString *)id)

RCT_EXTERN_METHOD(setIsOptedOut:(BOOL)isOptedOut)

RCT_EXTERN_METHOD(setLogger)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
