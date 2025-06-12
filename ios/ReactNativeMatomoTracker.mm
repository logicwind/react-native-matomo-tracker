#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ReactNativeMatomoTracker, NSObject)


RCT_EXTERN_METHOD(createTracker:(NSString *)uri withSiteId:(NSString *)siteId withToken:(NSString *)token)

RCT_EXTERN_METHOD(trackScreen:(NSString *)screenName withTitle:(NSString *)title withActionDimensions:(NSArray<NSDictionary *> *)actionDimensions)

RCT_EXTERN_METHOD(trackDispatch)

RCT_EXTERN_METHOD(trackEvent:(NSString *)category withAction:(NSString *)action withName:(NSString *)name withValue:(NSNumber *)value withActionDimensions:(NSArray<NSDictionary *> *)actionDimensions)

RCT_EXTERN_METHOD(trackOutlink:(NSString *)url withActionDimensions:(NSArray<NSDictionary *> *)actionDimensions)

RCT_EXTERN_METHOD(trackSearch:(NSString *)keyword withActionDimensions:(NSArray<NSDictionary *> *)actionDimensions)

RCT_EXTERN_METHOD(trackImpression:(NSString *)contentName withActionDimensions:(NSArray<NSDictionary *> *)actionDimensions)

RCT_EXTERN_METHOD(trackInteraction:(NSString *)contentName withContentInteraction:(NSString *)contentInteraction withActionDimensions:(NSArray<NSDictionary *> *)actionDimensions)

RCT_EXTERN_METHOD(trackDownload:(NSString *)category withAction:(NSString *)action withUrl:(NSString *)url withActionDimensions:(NSArray<NSDictionary *> *)actionDimensions)

RCT_EXTERN_METHOD(setUserId:(NSString *)id)

RCT_EXTERN_METHOD(trackScreens)

RCT_EXTERN_METHOD(trackGoal:(NSInteger)goalId withRevenue:(NSNumber *)revenue withActionDimensions:(NSArray<NSDictionary *> *)actionDimensions)

RCT_EXTERN_METHOD(setVisitorId:(NSString *)id)

// RCT_EXTERN_METHOD(setIsOptedOut:(BOOL)isOptedOut) 

RCT_EXTERN_METHOD(setLogger)

RCT_EXTERN_METHOD(startSession)

RCT_EXTERN_METHOD(disableTracking)

RCT_EXTERN_METHOD(enableTracking)

RCT_EXTERN_METHOD(trackCampaign:(NSString *)title withCampaignUrl:(NSString *)campaignUrl withActionDimensions:(NSArray<NSDictionary *> *)actionDimensions)

RCT_EXTERN_METHOD(trackMedia:(NSString *)siteId withMediaId:(NSString *)mediaId withMediaTitle:(NSString *)mediaTitle withPlayerName:(NSString *)playerName withMediaType:(NSString *)mediaType withMediaResource:(NSString *)mediaResource withMediaStatus:(NSString *)mediaStatus withMediaLength:(NSString *)mediaLength withMediaProgress:(NSString *)mediaProgress withMediaTTP:(NSString *)mediaTTP withMediaWidth:(NSString *)mediaWidth withMediaHeight:(NSString *)mediaHeight withMediaSE:(NSString *)mediaSE withMediaFullScreen:(NSString *)mediaFullScreen  withActionDimensions:(NSArray<NSDictionary *> *)actionDimensions)

RCT_EXTERN_METHOD(trackCustomDimension:(NSArray<NSDictionary *> *)dimensions)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
