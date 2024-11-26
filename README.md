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

### Create Custom dimension  

Dimension contains a key and a value, and where the key is a custom dimension id created on the Matomo dashboard and the value should be a string, you'll need to ensure that the dimensions array is processed correctly. [create custom dimension](https://matomo.org/faq/reporting-tools/create-track-and-manage-custom-dimensions/)  


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
trackMediaEvent,
trackCampaign
} from '@logicwind/react-native-matomo-tracker';
     
```

### createTracker()

The createTracker function is used to instantiate a tracker object for Matomo analytics within a React Native application .It requires the parameters `matomo-url` and `siteId`, with the optional parameter `auth_token`.

 <!-- If you want to create matomo auth_token refere this link https://matomo.org/faq/general/faq_114/ -->

#### note 
for matomo-url madatory to add `/matomo.php` end of url.

- **Generate Auth Token**  
  [Generate auth token guide here](https://matomo.org/faq/general/faq_114/)

#### Example

```js

 createTracker("https://your-matomo-url/matomo.php","siteId")

```


#### Example with Auth Token

```js

 createTracker("https://your-matomo-url/matomo.php","siteId","auth_token")

```

### startSession()

The MatomoTracker starts a new session whenever the application starts. If you want to start a new session manually, you can use the startSession() function.

#### Example

```js

startSession()

```


### trackScreen()

The trackScreen method is used to track screen views within a React Native application. It will take `screen name`,`title` with the optional parameter `actionDimensions`.

#### Example

```js

trackScreen("HomeScreen","Navigate to home screen")

```

#### Example with Action Custom Dimensions

```js

trackScreen("HomeScreen","Navigate to home screen",{
              "dimension":{
                "action":[
                  {"1":"visit dimension 1"},
                  {"2":"visit dimension 2"}
                ],
                "visit":[
                  {"4":"action dimension 1"},
                  {"5":"action dimension 2"}
                ]
               }
              })

```

### trackEvent()

The trackEvent method is used to track custom events within a React Native application. It will take `category`,`action`,`name` ,`value` with the optional parameter `actionDimensions`.

#### Example

```js

trackEvent("test category","test action"," test name",2);

```

#### Example with Action Custom Dimensions

```js

trackEvent("test category","test action"," test name",2,{
              "dimension":{
                "action":[
                  {"1":"visit dimension 1"},
                  {"2":"visit dimension 2"}
                ],
                "visit":[
                  {"4":"action dimension 1"},
                  {"5":"action dimension 2"}
                ]
               }
              });

```


#### Custom data tracking with track event

```js

trackEvent("basket",JSON.stringify({
id: 3745092,
item: 'mens grey t-shirt',
description: ['round neck', 'long sleeved'],
size: 'L',
}));

```

#### Example with Action Custom Dimensions

```js

trackEvent("basket",JSON.stringify({
id: 3745092,
item: 'mens grey t-shirt',
description: ['round neck', 'long sleeved'],
size: 'L',
}),
'',
0,
{
              "dimension":{
                "action":[
                  {"1":"visit dimension 1"},
                  {"2":"visit dimension 2"}
                ],
                "visit":[
                  {"4":"action dimension 1"},
                  {"5":"action dimension 2"}
                ]
               }
              }
);

```

### trackOutlink()

The trackOutlink method is used to track clicks on outbound links within a React Native application. It will take only `url` with the optional parameter `actionDimensions`.

#### Example

```js

trackOutlink("https://www.google.com/")

```

#### Example with Action Custom Dimensions

```js

trackOutlink("https://www.google.com/",{
              "dimension":{
                "action":[
                  {"1":"visit dimension 1"},
                  {"2":"visit dimension 2"}
                ],
                "visit":[
                  {"4":"action dimension 1"},
                  {"5":"action dimension 2"}
                ]
               }
              })

```


### trackSearch()

The trackSearch method is used to track search keyword within a React Native application. It will take only `keyword` with the optional parameter `actionDimensions`.

#### Example

```js

trackImpression("Logicwind")

```
#### Example with Action Custom Dimensions

```js

trackImpression("Logicwind",{
              "dimension":{
                "action":[
                  {"1":"visit dimension 1"},
                  {"2":"visit dimension 2"}
                ],
                "visit":[
                  {"4":"action dimension 1"},
                  {"5":"action dimension 2"}
                ]
               }
              })

```

### trackImpression()

The trackImpression method is used to track specific content or elements within a React Native application. It will take only `contentName` with the optional parameter `actionDimensions`.

#### Example

```js

trackImpression("Test Track Impression")

```

#### Example with Action Custom Dimensions

```js

trackImpression("Test Track Impression",{
              "dimension":{
                "action":[
                  {"1":"visit dimension 1"},
                  {"2":"visit dimension 2"}
                ],
                "visit":[
                  {"4":"action dimension 1"},
                  {"5":"action dimension 2"}
                ]
               }
              })

```

### trackInteraction()

The trackInteraction method is used to track  users engage with specific elements or perform actions within a React Native application. It will take `contentName` and `contentInteraction`  with the optional parameter `actionDimensions`.

#### Example

```js

trackInteraction("Test Track interaction","test inetraction")

```

#### Example with Action Custom Dimensions

```js

trackInteraction("Test Track interaction","test inetraction",{
              "dimension":{
                "action":[
                  {"1":"visit dimension 1"},
                  {"2":"visit dimension 2"}
                ],
                "visit":[
                  {"4":"action dimension 1"},
                  {"5":"action dimension 2"}
                ]
               }
              })

```

### trackDownload()

The trackDownload method is used to track  the download of files or resources within a React Native application. It will take  `category`,`action` and `download-url`  with the optional parameter `actionDimensions`.

#### Example

```js

trackDownload("Download","PDF Download","https://example.com/download.pdf")

```

#### Example with Action Custom Dimensions

```js

trackDownload("Download","PDF Download","https://example.com/download.pdf",{
              "dimension":{
                "action":[
                  {"1":"visit dimension 1"},
                  {"2":"visit dimension 2"}
                ],
                "visit":[
                  {"4":"action dimension 1"},
                  {"5":"action dimension 2"}
                ]
               }
              })

```

### setUserId()

The setUserId function is used to assign a unique identifier to a user in a React Native application. It will take `id`  parameter.

#### Example

```js

setUserId("test@gmail.com")

```


### setVisitorId()

By default matomo generate the unique visitor id but if you want custom vistor id then setVisitorId function allows you to manually set a custom visitor ID for tracking purposes within a React Native application . It will take `visitor-id`  parameter. It must be a 16 character long hex string

#### Example

```js

setVisitorId("2c534f55fba6cf6e")

```

### trackDispatch()

The MatomoTracker will dispatch events every 30 seconds automatically. If you want to dispatch events manually, you can use the trackDispatch() function.

#### Example

```js

trackDispatch()

```

### disableTracking()

By default the tracking is enable. If you want to disable traking, you can use the disableTracking() function.

#### Example

```js

disableTracking()

```

### enableTracking()

The enableTracking function is used for enable traking.

#### Example

```js

enableTracking()

```

### setLogger()

To enable logging for debugging purposes in the Matomo Android SDK and IOS SDK, you can set a custom logger. This is useful to see detailed logs of the SDK’s operations, which can help during development and troubleshooting.

#### Example

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
| dimensions| Dimension contains a key and a value, and where the key is a custom dimension id created on the Matomo dashboard and the value should be a string, you'll need to ensure that the dimensions array is processed correctly. [create custom dimension](https://matomo.org/faq/reporting-tools/create-track-and-manage-custom-dimensions/)    


#### Example

```js

trackMediaEvent({siteId:"siteid",mediaId:"unique id",mediaTitle:"video media play track",playerName:"test 08",mediaType:MediaType.VIDEO,mediaResource:"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",mediaStatus:"100",mediaLength:"100",mediaFullScreen:"1",mediaHeight:"720",mediaWidth:"1080",mediaProgress:"100", dimensions:{
              "dimension":{
                "action":[
                  {"1":"visit dimension 1"},
                  {"2":"visit dimension 2"}
                ],
                "visit":[
                  {"4":"action dimension 1"},
                  {"5":"action dimension 2"}
                ]
               }
              }});

```


 ### trackCampaign()

 Tracking campaigns usually involves recording information about user interactions that can be tied to specific marketing efforts, such as UTM parameters.It requires the parameters `title`,`campaignUrl` with the optional parameter `actionDimensions`

 - #### Default Campaign Tracking Values
* Campaign (Required): mtm_campaign
<br>A descriptive name for the campaign, e.g. a blog post title or email campaign name.</br>

* Keyword (Recommended): mtm_keyword
<br>The specific keyword that someone searched for, or category of interest.</br>

- #### Additional Campaign Tracking Values
(Available with Matomo Cloud or Marketing Campaigns Reporting Plugin)

* Source (Recommended): `mtm_source`
<br>The actual source of the traffic, e.g. newsletter, twitter, ebay, etc.</br>

* Medium (Recommended): `mtm_medium`
<br>The type of marketing channel, e.g. email, social, paid, etc.</br>

* Content (Optional): `mtm_content`
<br>This is a specific link or content that somebody clicked. e.g. banner, big-green-button</br>

* ID (Optional): `mtm_cid`
<br>A unique identifier for your specific ad. This parameter is often used with the numeric IDs automatically generated by advertising platforms.</br>

* Group (Requires Matomo 4 or above): `mtm_group`
<br>The audience your campaign is targeting e.g. customers, retargeting, etc</br>


* Placement (Requires Matomo 4 or above): `mtm_placement`
<br>The placement on an advertising network e.g. newsfeed, sidebar, home-banner, etc.</br>


If you already have URLs tagged with Google Analytics parameters these are also supported:

* utm_campaign,
* utm_source,
* utm_medium,
* utm_term,
* utm_content,
* utm_id.

#### Example

```js

trackCampaign("Home screen","https://example.com/?mtm_campaign=2020_august_promo&mtm_source=google&mtm_medium=email&mtm_keyword=august promo&mtm_content=primary-cta")

```

#### Example with Action Custom Dimensions

```js

trackCampaign("Home screen","https://example.com/?mtm_campaign=2020_august_promo&mtm_source=google&mtm_medium=email&mtm_keyword=august promo&mtm_content=primary-cta",{
              "dimension":{
                "action":[
                  {"1":"visit dimension 1"},
                  {"2":"visit dimension 2"}
                ],
                "visit":[
                  {"4":"action dimension 1"},
                  {"5":"action dimension 2"}
                ]
               }
              })

```

### trackCustomDimension()

With Custom Dimensions you can assign any custom data to your visitors or actions (like pages, events, site search, ...) and then visualize the reports of how many visits, conversions, pageviews, etc. there were for each Custom Dimension.

Dimension contains a key and a value, and where the key is a custom dimension id created on the Matomo dashboard and the value should be a string, you'll need to ensure that the dimensions array is processed correctly. [create custom dimension](https://matomo.org/faq/reporting-tools/create-track-and-manage-custom-dimensions/)  

#### Example

```js

trackCustomDimension({ 
  dimensions:[{key:"1",value: "cf7fad2e-fae4-4c49-9924-ad9a2a7c50de"},{key:"2",value: "cf7fad2e-fae4-4c49-9924-ad9a2a7c50de"}]
});

```

Dimensions  {
      "dimension":{
          "action":[
              {"id":String}
          ],
          "visit":[
             {"id":String}
          ]
      }
}

## Methods


| Method                               | Required Parameter                                          | Android | ios | Android TV | Apple TV | Fire TV |
|--------------------------------------|-----------------------------------------------------------|:-------:|:---:|:----------:|:--------:|:--------:|
| [createTracker](#createtracker)      | uri: String, siteId: Number, token: String           |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [startSession](#startsession)        | -                                                         |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [trackScreen](#trackscreen)          | screenName: String, title: String, dimensions:Dimensions                          |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [trackEvent](#trackevent)            | category:String, action:String, name:String, value:Number, dimensions:Dimensions  |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [trackOutlink](#trackoutlink)        | url:String, dimensions:Dimensions                                                |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [trackSearch](#tracksearch)          | keyword:String, dimensions:Dimensions                                            |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [trackImpression](#trackimpression)  | contentName:String, dimensions:Dimensions                                        |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [trackInteraction](#trackinteraction)| contentName:String, contentInteraction:String, dimensions:Dimensions              |    ✅   |  ✅  |    ✅      |   ✅     |    ✅     |
| [trackDownload](#trackdownload)      | category:String, action:String, url:String                |    ✅   |  ✅  |    ✅      |   ✅     |    ✅     |
| [setUserId](#setuserid)              | id:String                                                 |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [setVisitorId](#setvisitorid)        | visitorId:String                                          |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [trackDispatch](#trackdispatch)      | -                                                         |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [disableTracking](#disabletracking)  | -                                                         |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [enableTracking](#enabletracking)    | -                                                         |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [setLogger](#setlogger)              | -                                                         |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [trackMediaEvent](#trackmediaevent)  |  siteId: String, mediaId: String, mediaTitle: String, playerName: String, mediaType: String, mediaResource: String, mediaStatus: String,mediaLength?:String, mediaProgress?:String, mediaTTP?: String, mediaWidth?: String, mediaHeight?: String, mediaSE?: String, mediaFullScreen?:String, dimensions:Dimensions                                           |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [trackCampaign](#trackcampaign)      | title: String, campaignUrl: String, dimensions                         |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |
| [trackCustomDimension](#trackcustomdimension)      | dimensions:Dimensions                        |    ✅   |  ✅  |    ✅      |   ✅     |   ✅     |


<!-- ## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow. -->

## Troubleshooting

<details>
  <summary>How do I fix the tracking failure “Request was not authenticated but should have</summary>
<br>You see a failed tracking request with this error message when you use specific tracking parameters as part of the <a href="https://developer.matomo.org/api-reference/tracking-api">HTTP tracking API</a> without authenticating the request correctly</br>
<br>When such an error occurred, you need to make sure to set a token_auth of a user with at least write permission. If you have set a token, check the set token to make sure it is still the same and no copy/paste error has happened.</br>

<br>To generate a token_auth follow these steps:</br>

* Log in to Matomo 
* Go to the Matomo Admin through the top menu
* Click on Personal -> Security
* At the bottom of the page click on “Create new token”
* Confirm your account password
* Enter the purpose for this token
* Choose if the token should only be valid for secure requests (Matomo 5 and newer)

Click on “Create new token”
 You will now see the newly created token. Save it somewhere safe as you won’t be able to see it anymore once you leave that screen. For example, save it in a password manager. If you lose it, you will need to generate a new token.

</details>

<details>
  <summary>How do I fix the tracking not work after successfully inetgration</summary>
<br> if you have install matomo successfully but it will not track the event on matomo dashbaord then you have to check your project's bundle name in Matomo's bot detector list to validate if the starting characters match in their list or not. if it is match with your bundle name then you need to chnage your bundle name in ios.
</br>
<br>Here's the bot list of Matomo's bot detector: <a href="https://github.com/matomo-org/device-detector?tab=readme-ov-file#what-device-detector-is-able-to-detect">click here</a></br>

</details>

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)


