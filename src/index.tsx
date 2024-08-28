import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package '@logicwind/react-native-matomo-tracker' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const ReactNativeMatomoTracker = NativeModules.ReactNativeMatomoTracker
  ? NativeModules.ReactNativeMatomoTracker
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function createTracker(uri: String="", siteId: Number=0,token:String="") {
    return ReactNativeMatomoTracker.createTracker(uri, Platform.OS=="ios"?siteId?.toString() :siteId,token);
}

export function trackScreen(screenName: String, title: String) {
  return ReactNativeMatomoTracker.trackScreen(screenName, title);
}

export function trackEvent(category:String,action:String,name:String="",value:Number=0) {
  return ReactNativeMatomoTracker.trackEvent(category,action,name,value);
}

export function trackDispatch(){
  return ReactNativeMatomoTracker.trackDispatch();
}

export function trackOutlink(url:String) {
  return ReactNativeMatomoTracker.trackOutlink(url);
}

export function trackSearch(keyword:String) {
  return ReactNativeMatomoTracker.trackSearch(keyword);
}

export function trackImpression(contentName:String){
  return ReactNativeMatomoTracker.trackImpression(contentName);
}

export function trackInteraction(contentName:String,contentInteraction:String) {
  return ReactNativeMatomoTracker.trackInteraction(contentName,contentInteraction);
}

export function trackDownload(category:String,action:String,url:String){
  return ReactNativeMatomoTracker.trackDownload(category,action,url);
}

export function setUserId(id:String) {
  return ReactNativeMatomoTracker.setUserId(id);
}

export function setVisitorId(visitorId:String) {
  return ReactNativeMatomoTracker.setVisitorId(visitorId);
}

export function disableTracking() {
  return ReactNativeMatomoTracker.disableTracking();
}

export function enableTracking() {
  return ReactNativeMatomoTracker.enableTracking();
}


export function setLogger(){
  return ReactNativeMatomoTracker.setLogger();
}

export function startSession() {
  return ReactNativeMatomoTracker.startSession();
}

export function trackCampaign(title:String,campaignUrl:String) {
  return ReactNativeMatomoTracker.trackCampaign(title,campaignUrl);
}

export function trackMediaEvent(
{siteId,mediaId,mediaTitle,playerName,mediaType,mediaResource,mediaStatus,mediaLength="",mediaProgress="",mediaTTP="",mediaWidth="",mediaHeight="",mediaSE="",mediaFullScreen="",dimensions=[]}:{  
  siteId: String,
  mediaId: String,
  mediaTitle: String,
  playerName: String,
  mediaType: String,
  mediaResource: String,
  mediaStatus: String,
  mediaLength?:String,
  mediaProgress?:String,
  mediaTTP?: String,
  mediaWidth?: String,
  mediaHeight?: String,
  mediaSE?: String,
  mediaFullScreen?:String,
  customVariable?:String,
  dimensions?: Array<Object>
}): Promise<number> {
  return ReactNativeMatomoTracker.trackMedia(siteId,mediaId,mediaTitle,playerName,mediaType,mediaResource,mediaStatus,mediaLength,mediaProgress,mediaTTP,mediaWidth,mediaHeight,mediaSE,mediaFullScreen,dimensions);
}

export const MediaType = { VIDEO: 'video',AUDIO:"audio"};



