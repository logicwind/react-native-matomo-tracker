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
} from '@logicwind/react-native-matomo-tracker';
     
```

### createTracker()

The createTracker function is used to instantiate a tracker object for Matomo analytics within a React Native application .It will take `matomo-url` and `siteId` parameter.

#### Examples

```js

 createTracker("your-matomo-url","siteId")

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

By default matomo generate the unique visitor id but if you want custom vistor id then setVisitorId function allows you to manually set a custom visitor ID for tracking purposes within a React Native application . It will take `visitor-id`  parameter.

#### Examples

#### ios

```js

setVisitorId("123e4567-e89b-12d3-a456-426614174000")

```
#### Android

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

 

## Methods


| Method                               | Require Paramter                                          | Android | ios | Android TV | Apple TV |
|--------------------------------------|-----------------------------------------------------------|:-------:|:---:|:----------:|:--------:|
| [createTracker](#createtracker)      | uri: String, siteId: Number                               |    ✅   |  ✅  |    ✅      |   ✅     |
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


<!-- ## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow. -->

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)


## Keywords

React-Native, Android, ios, Android TV, Apple TV, Fire TV