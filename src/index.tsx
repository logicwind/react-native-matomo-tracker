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
  export interface DimensionData {
    dimension: {
        action?: { [key: string]: string }[]; 
        visit?: { [key: string]: string }[]; 
      };
  }

export function createTracker(uri: String="", siteId: Number=0,token:String="") {
    return ReactNativeMatomoTracker.createTracker(uri, Platform.OS=="ios"?siteId?.toString() :siteId,token);
}

export function trackScreen(screenName: String, title: String,actionDimensions?:DimensionData) {
  return ReactNativeMatomoTracker.trackScreen(screenName, title,actionDimensions??{});
}

export function trackEvent(category:String,action:String,name:String="",value:Number=0,actionDimensions?:DimensionData) {
  return ReactNativeMatomoTracker.trackEvent(category,action,name,value,actionDimensions??{});
}

export function trackDispatch(){
  return ReactNativeMatomoTracker.trackDispatch();
}

export function trackOutlink(url:String,actionDimensions?:DimensionData) {
  return ReactNativeMatomoTracker.trackOutlink(url,actionDimensions??{});
}

export function trackSearch(keyword:String,actionDimensions?:DimensionData) {
  return ReactNativeMatomoTracker.trackSearch(keyword,actionDimensions??{});
}

export function trackImpression(contentName:String,actionDimensions?:DimensionData){
  return ReactNativeMatomoTracker.trackImpression(contentName,actionDimensions??{});
}

export function trackInteraction(contentName:String,contentInteraction:String,actionDimensions?:DimensionData) {
  return ReactNativeMatomoTracker.trackInteraction(contentName,contentInteraction,actionDimensions??{});
}

export function trackDownload(category:String,action:String,url:String,actionDimensions?:DimensionData){
  return ReactNativeMatomoTracker.trackDownload(category,action,url,actionDimensions??{});
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

export function trackCampaign(title:String,campaignUrl:String,actionDimensions?:DimensionData) {
  return ReactNativeMatomoTracker.trackCampaign(title,campaignUrl,actionDimensions??{});
}

export function trackMediaEvent(
{siteId,mediaId,mediaTitle,playerName,mediaType,mediaResource,mediaStatus,mediaLength="",mediaProgress="",mediaTTP="",mediaWidth="",mediaHeight="",mediaSE="",mediaFullScreen="",actionDimensions}:{  
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
  actionDimensions?: DimensionData
}): Promise<number> {
  return ReactNativeMatomoTracker.trackMedia(siteId,mediaId,mediaTitle,playerName,mediaType,mediaResource,mediaStatus,mediaLength,mediaProgress,mediaTTP,mediaWidth,mediaHeight,mediaSE,mediaFullScreen,actionDimensions);
}

export function trackCustomDimension(
  {dimensions=[]}:{  
    dimensions?: Array<Object>
  }): Promise<number> {
    return ReactNativeMatomoTracker.trackCustomDimension(dimensions);
  }


export const MediaType = { VIDEO: 'video',AUDIO:"audio"};



