# @logicwind/react-native-matomo-tracker

@logicwind/react-native-matomo-tracker is a React Native library that provides integration with the Matomo analytics platform for tracking user interactions and events in mobile applications and TV applications.

With @logicwind/react-native-matomo-tracker, developers can seamlessly integrate Matomo analytics into their React Native applications, allowing them to track various user interactions such as screen views, button clicks, form submissions, and custom events. This integration enables developers to gain insights into how users interact with their mobile apps, monitor app performance, and make data-driven decisions to improve the user experience.

## Installation

```sh
npm install @logicwind/react-native-matomo-tracker
```

## Usage

```js
import { createTracker, setUserId, setVisitorId, trackDispatch, trackDownload, trackEvent, trackImpression, trackInteraction, trackOutlink, trackScreen, trackSearch } from '@logicwind/react-native-matomo-tracker';
     
```

```js
  useEffect(()=>{
    createTracker("your-matomo-url","siteid")
  },[])

```

```js
trackScreen("HomeScreen","This is test home screen")

trackEvent("test category","test action"," test name",2);

trackEvent("basket",JSON.stringify({
id: 3745092,
item: 'mens grey t-shirt',
description: ['round neck', 'long sleeved'],
size: 'L',
}));

trackOutlink("https://www.google.com/")

trackSearch("Logicwind")

trackImpression("Test Track Impression")

trackInteraction("Test Track interaction","test inetraction")

trackDownload("Download","PDF Download","https://example.com/download.pdf")

setUserId("test@gmail.com")

if(Platform.OS=="ios"){
setVisitorId("123e4567-e89b-12d3-a456-426614174000")
} 
else{
setVisitorId("2c534f55fba6cf6e")
}

trackDispatch()

```

 

## Methods


| Name  | Description  |
|-----------------|-----------------|
| createTracker | The createTracker function is used to instantiate a tracker object for Matomo analytics within a React Native application. This tracker instance allows developers to track various user interactions and events within their mobile app. |
| trackScreen | The trackScreen method is used to track screen views within a React Native application. Screen tracking allows developers to monitor user navigation and engagement by recording when users view specific screens or pages within the app.| 
| trackEvent | The trackEvent method is used to track custom events within a React Native application. Event tracking allows developers to monitor and analyze user interactions, such as button clicks, form submissions, or any other custom actions performed by users within the app. | 
| trackOutlink | The trackOutlink method is used to track clicks on outbound links within a React Native application. Outbound link tracking allows developers to monitor when users click on links that navigate them away from the app to external websites or resources. | 
| trackSearch | Tracking user searches in a React Native application involves capturing search queries entered by users and sending this data to your analytics platform. This enables you to understand what users are searching for within your app and how they interact with search results. | 
| trackImpression | Tracking impressions in a React Native application involves capturing instances where users are exposed to specific content or elements within the app's interface. This could include advertisements, product listings, promotional banners, or any other items that are displayed to users. | 
| trackInteraction | Tracking user interactions in a React Native application involves capturing instances where users engage with specific elements or perform actions within the app's interface. These interactions could include clicks on buttons, taps on links, form submissions, or any other user actions that you want to monitor. | 
| trackDownload | Tracking downloads in a React Native application involves capturing instances where users initiate and complete the download of files or resources. These downloads could include documents, media files, app updates, or any other downloadable content provided within the app.| 
| setUserId | The setUserId function is used to assign a unique identifier to a user in a React Native application. This identifier can be used to track user-specific actions, behavior, and engagement within the app. | 
| setVisitorId | The setVisitorId function allows you to manually set a custom visitor ID for tracking purposes within a React Native application.  | 
| trackDispatch | The trackDispatch methods for tracking events, interactions, and other analytics-related functionalities within a React Native application. However, there isn't a standard trackDispatch method in Matomo tracking libraries, including the one provided by this package | 

<!-- ## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow. -->

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)


## Keywords

React-Native, Android, ios, Android TV, Apple TV, Fire TV