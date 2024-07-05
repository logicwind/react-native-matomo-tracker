# @logicwind/react-native-matomo-tracker

@logicwind/react-native-matomo-tracker is a React Native library that provides integration with the Matomo analytics platform for tracking user interactions and events in mobile applications and TV applications. This package supported **Android, ios, Android TV, Apple TV, Fire TV**.

With @logicwind/react-native-matomo-tracker, developers can seamlessly integrate Matomo analytics into their React Native applications, allowing them to track various user interactions such as screen views, button clicks, form submissions, and custom events. This integration enables developers to gain insights into how users interact with their mobile apps, monitor app performance, and make data-driven decisions to improve the user experience.


## Installation

Using npm:

```shell
npm install  @logicwind/react-native-matomo-tracker
```

or using yarn:

```shell
yarn add @logicwind/react-native-matomo-tracker
```
Then follow the instructions for your platform to link @logicwind/react-native-matomo-tracker into your project:

### iOS installation

**React Native 0.70 and above**

Run `npx pod-install`. Linking is not required in React Native 0.70 and above.

### tvOS installation

Run `npx pod-install`. Linking is not required in React Native 0.70 and above.


## Usage

```js
import { 
createTracker, 
setUserId,
setVisitorId, 
trackDispatch, 
trackDownload, 
trackEvent, 
trackImpression, 
trackInteraction, 
trackScreen, 
trackSearch, 
disableTracking,
enableTracking, 
startSession,
trackMediaEvent
} from '@logicwind/react-native-matomo-tracker';
     
```

### createTracker()

The createTracker function is used to instantiate a tracker object for Matomo analytics within a React Native application .It will take `matomo-url` and `siteId` parameter and `auth_token` is optional paramter .

 If you want to create matomo auth_token refere this link https://matomo.org/faq/general/faq_114/

#### note 
for matomo-url madatory to add `/matomo.php` end of url.

#### Examples

```js

 createTracker("https://your-matomo-url/matomo.php","siteId")

```


#### Examples with Auth Token

```js

 createTracker("https://your-matomo-url/matomo.php","siteId","auth_token")

```

### startSession()

The MatomoTracker starts a new session whenever the application starts. If you want to start a new session manually, you can use the startSession() function.

#### Examples

```js

startSession()

```


### trackScreen()

The trackScreen method is used to track screen views within a React Native application. It will take `screen name` and `title` parameter.

#### Examples

```js

trackScreen("HomeScreen","Navigate to home screen")

```

### trackEvent()

The trackEvent method is used to track custom events within a React Native application. It will take `category`,`action`,`name` and `value` parameter.

#### Examples

```js

trackEvent("test category","test action"," test name",2);

```


#### Custom data traking with track event

```js

trackEvent("basket",JSON.stringify({
id: 3745092,
item: 'mens grey t-shirt',
description: ['round neck', 'long sleeved'],
size: 'L',
}));

```

### trackOutlink()

The trackOutlink method is used to track clicks on outbound links within a React Native application. It will take only `url` parameter.

#### Examples

```js

trackOutlink("https://www.google.com/")

```

### trackSearch()

The trackSearch method is used to track search keyword within a React Native application. It will take only `keyword` parameter.

#### Examples

```js

trackImpression("Logicwind")

```

### trackImpression()

The trackImpression method is used to track specific content or elements within a React Native application. It will take only `contentName` parameter.

#### Examples

```js

trackImpression("Test Track Impression")

```

### trackInteraction()

The trackInteraction method is used to track  users engage with specific elements or perform actions within a React Native application. It will take `contentName` and `contentInteraction`  parameter.

#### Examples

```js

trackInteraction("Test Track interaction","test inetraction")

```

### trackDownload()

The trackDownload method is used to track  the download of files or resources within a React Native application. It will take  `category`,`action` and `download-url`  parameter.

#### Examples

```js

trackDownload("Download","PDF Download","https://example.com/download.pdf")

```

### setUserId()

The setUserId function is used to assign a unique identifier to a user in a React Native application. It will take `id`  parameter.

#### Examples

```js

setUserId("test@gmail.com")

```


### setVisitorId()

By default matomo generate the unique visitor id but if you want custom vistor id then setVisitorId function allows you to manually set a custom visitor ID for tracking purposes within a React Native application . It will take `visitor-id`  parameter. It must be a 16 character long hex string

#### Examples

```js

setVisitorId("2c534f55fba6cf6e")

```

### trackDispatch()

The MatomoTracker will dispatch events every 30 seconds automatically. If you want to dispatch events manually, you can use the trackDispatch() function.

#### Examples

```js

trackDispatch()

```

### disableTracking()

By default the tracking is enable. If you want to disable traking, you can use the disableTracking() function.

#### Examples

```js

disableTracking()

```

### enableTracking()

The enableTracking function is used for enable traking.

#### Examples

```js

enableTracking()

```

### setLogger()

To enable logging for debugging purposes in the Matomo Android SDK and IOS SDK, you can set a custom logger. This is useful to see detailed logs of the SDK’s operations, which can help during development and troubleshooting.

#### Examples

```js

setLogger()

```

### trackMediaEvent()

trackMediaEvent function use to monitor user interactions with media content, such as audio or video files. It allows you to track various events related to media playback, such as play, pause, stop, seek, and complete, providing insights into user engagement with your media assets.

| Parameter      | Description                                               |
|----------------|-----------------------------------------------------------|
| mediaId        | (required) A unique id that is always the same while playing a media. As soon as the played media changes.                            |
| mediaResource  | (required) The URL of the media resource.                            |
| mediaType      | (required) video or audio depending on the type of the media. You can used MediaType.VIDEO or MediaType.AUDIO                         |
| mediaTitle     | The name / title of the media.                           |
| playerName     | The name of the media player, for example html5.                            |
| mediaStatus    | The time in seconds for how long a user has been playing this media. This number should typically increase when you send a media tracking request. It should be 0 if the media was only visible/impressed but not played. Do not increase this number when a media is paused.                            |
| mediaLength    | The duration (the length) of the media in seconds. For example if a video is 90 seconds long, the value should be 90.                           |
| mediaProgress  | The progress / current position within the media. Defines basically at which position within the total length the user is currently playing.                            |
| mediaTTP       | Defines after how many seconds the user has started playing this media. For example a user might have seen the poster of the video for 30 seconds before a user actually pressed the play button.                            |
| mediaWidth     | The resolution width of the media in pixels. Only recommended being set for videos.                            |
| mediaHeight    | The resolution height of the media in pixels. Only recommended being set for videos.                            |
| mediaFullScreen| Should be 0 or 1 and defines whether the media is currently viewed in full screen. Only recommended being set for videos.                            |
| mediaSE        | An optional comma separated list of which positions within a media a user has played. For example if the user has viewed position 5s, 10s, 15s and 35s, then you would need to send 5,10,15,35. We recommend to round to the next 5 seconds and not send a value for each second. Internally, Matomo may round to the next 15 or 30 seconds. For performance optimisation we recommend not sending the same position twice. Meaning if you have sent ma_se=10 there is no need to send later ma_se=10,20 but instead only ma_se=20.                             |



#### Examples

```js

trackMediaEvent({siteId:"siteid",mediaId:"unique id",mediaTitle:"video media play track",playerName:"test 08",mediaType:MediaType.VIDEO,mediaResource:"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",mediaStatus:"100",mediaLength:"100",mediaFullScreen:"1",mediaHeight:"720",mediaWidth:"1080",mediaProgress:"100"});

```
 

## Methods


| Method                               | Required Parameter                                          | Android | ios | Android TV | Apple TV |
|--------------------------------------|-----------------------------------------------------------|:-------:|:---:|:----------:|:--------:|
| [createTracker](#createtracker)      | uri: String, siteId: Number, token: String           |    ✅   |  ✅  |    ✅      |   ✅     |
| [startSession](#startsession)        | -                                                         |    ✅   |  ✅  |    ✅      |   ✅     |
| [trackScreen](#trackscreen)          | screenName: String, title: String                         |    ✅   |  ✅  |    ✅      |   ✅     |
| [trackEvent](#trackevent)            | category:String, action:String, name:String, value:Number |    ✅   |  ✅  |    ✅      |   ✅     |
| [trackOutlink](#trackoutlink)        | url:String                                                |    ✅   |  ✅  |    ✅      |   ✅     |
| [trackSearch](#tracksearch)          | keyword:String                                            |    ✅   |  ✅  |    ✅      |   ✅     |
| [trackImpression](#trackimpression)  | contentName:String                                        |    ✅   |  ✅  |    ✅      |   ✅     |
| [trackInteraction](#trackinteraction)| contentName:String, contentInteraction:String             |    ✅   |  ✅  |    ✅      |   ✅     | 
| [trackDownload](#trackdownload)      | category:String, action:String, url:String                |    ✅   |  ✅  |    ✅      |   ✅     | 
| [setUserId](#setuserid)              | id:String                                                 |    ✅   |  ✅  |    ✅      |   ✅     |
| [setVisitorId](#setvisitorid)        | visitorId:String                                          |    ✅   |  ✅  |    ✅      |   ✅     |
| [trackDispatch](#trackdispatch)      | -                                                         |    ✅   |  ✅  |    ✅      |   ✅     |
| [disableTracking](#disabletracking)  | -                                                         |    ✅   |  ✅  |    ✅      |   ✅     |
| [enableTracking](#enabletracking)    | -                                                         |    ✅   |  ✅  |    ✅      |   ✅     |
| [setLogger](#setlogger)              | -                                                         |    ✅   |  ✅  |    ✅      |   ✅     |
| [trackMediaEvent](#trackmediaevent)  |  siteId: String, mediaId: String, mediaTitle: String, playerName: String, mediaType: String, mediaResource: String, mediaStatus: String,mediaLength?:String, mediaProgress?:String, mediaTTP?: String, mediaWidth?: String, mediaHeight?: String, mediaSE?: String, mediaFullScreen?:String                                            |    ✅   |  ✅  |    ✅      |   ✅     |


<!-- ## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow. -->

## Troubleshoot

[How do I fix the tracking failure “Request was not authenticated but should have.”](https://matomo.org/faq/how-to/faq_30835/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)


