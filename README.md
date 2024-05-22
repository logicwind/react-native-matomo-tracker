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

 setIsOptedOut(true)

 setLogger()

trackDispatch()

```

 

## Methods


| Method  | Require Paramter  | Android| ios |  
|-----------------|-----------------|-----------------|-----------------|
| createTracker | |'
| startSession | | 
| trackScreen | | 
| trackEvent |  | 
| trackOutlink |  | 
| trackSearch |  | 
| trackImpression |  | 
| trackInteraction |  | 
| trackDownload | | 
| setUserId | | 
| setVisitorId |   | 
| trackDispatch |  | 
| setIsOptedOut |  | 
| setLogger | | 


<!-- ## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow. -->

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)


## Keywords

React-Native, Android, ios, Android TV, Apple TV, Fire TV