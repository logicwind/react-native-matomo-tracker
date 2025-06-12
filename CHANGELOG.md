## 0.3.11

- Fixed Apple TVOS crash issue.
- Enhanced Debug Logging
- Added trackGoal method. With trackGoal, you can track when a visitor completes a specific objective.

## 0.3.10

- Fixed crash issue related to not passing dimention parameter.

## 0.3.9

- Fixed the crash issue on trackMedia function while pass dimension option.

## 0.3.8

- Refined dimensions data passing

## 0.3.7

- Added trackCustomDimension method for track individual custom dimension tracking

## 0.3.6

- Fixed issue in custom dimension tracking.

## 0.3.5

- Added custom dimension property in media tracking

## 0.3.4

- Added trackCampaign method. Using which you can track generic and matomo UTM attribution

## 0.3.3

- Added support to pass matomo auth-token.
- Sometime facing issue related to authentication for older events. More info [Here](https://matomo.org/faq/how-to/faq_30835/)

## 0.3.2

- Media tracking progress's attribute typo fix.

## 0.3.1

- Media tracking added.
- Use trackMediaEvent method to track audio and video related details

## 0.3.0

- Added enableTracking & disableTracking methods to opt in or opt out of tracking. Replacement of setIsOptedOut method.
- Updated readme.
**~~~~~ BREAKING CHANGES ~~~~~**
- Removed setIsOptedOut and added 2 separate methods (enableTracking, disableTracking) to work independently

## 0.2.2

- Crash fixes. case: when trying to track event before initialising of tracker.
- Can start new session now using startSession method.
- Can enable logs using setLogger method.

## 0.2.1

- Compilation error fixed on android platform

## 0.2.0

- React-native plugin for Matomo Analytics. Developed based on `matomo-sdk-android` and `matomo-sdk-ios`.
- The plugin should allow you to track screens, events, searches, impressions, users, visitors, etc.

## 0.1.0

- React-native plugin for Matomo Analytics. Developed based on `matomo-sdk-android` and `matomo-sdk-ios`.
- The plugin should allow you to track screens, events, searches, impressions, users, visitors, etc.
