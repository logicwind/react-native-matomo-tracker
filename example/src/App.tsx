import * as React from 'react';

import {
  StyleSheet,
  View,
  Text,
  Pressable,
  ScrollView,
  SafeAreaView,
} from 'react-native';

import {
  MediaType,
  createTracker,
  disableTracking,
  enableTracking,
  setLogger,
  setUserId,
  setVisitorId,
  startSession,
  trackCampaign,
  trackCustomDimension,
  trackDispatch,
  trackDownload,
  trackEvent,
  trackImpression,
  trackInteraction,
  trackMediaEvent,
  trackOutlink,
  trackScreen,
  trackSearch,
} from '@logicwind/react-native-matomo-tracker';

export default function App() {
  const [result] = React.useState<number | undefined>();

  React.useEffect(() => {
    createTracker("https://your-domain-url/matomo.php", 1) //Replace 1 with your matomo site id
    setLogger()
  }, []);

  return (
    <SafeAreaView style={styles.main}>
      <ScrollView showsHorizontalScrollIndicator={false}>
        <View style={styles.container}>
          <Text>Matomo Tracking {result}</Text>

          <Pressable
            style={styles.button}
            onPress={() => {
              trackCampaign("Home screen","rntestApp://home?mtm_campaign=2020_august_promo&mtm_source=google&mtm_medium=email&mtm_keyword=2020 august promo&mtm_content=primary-cta")
            }}
          >
            <Text style={styles.buttonText}>Track Campaign</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              startSession()
            }}
          >
            <Text style={styles.buttonText}>Start Session</Text>
          </Pressable>
          <Pressable
            style={styles.button}
            onPress={() => {
              trackScreen('HomeScreen', 'This is test home screen');

            }}
          >
            <Text style={styles.buttonText}>Track Screen</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              trackEvent('test category', 'test action', ' test name', 2);
              trackEvent(
                'basket',
                JSON.stringify({
                  id: 3745092,
                  item: 'mens grey t-shirt',
                  description: ['round neck', 'long sleeved'],
                  size: 'L',
                })
              );
            }}
          >
            <Text style={styles.buttonText}>Track Event</Text>
          </Pressable>
          <Pressable
            style={styles.button}
            onPress={() => {
              trackOutlink('https://www.google.com/');
            }}
          >
            <Text style={styles.buttonText}>Track OutLink</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              trackSearch('Logicwind');
            }}
          >
            <Text style={styles.buttonText}>Track Search</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              trackImpression('Test Track Impression');
            }}
          >
            <Text style={styles.buttonText}>Track Impression</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              trackInteraction('Test Track interaction', 'test inetraction');
            }}
          >
            <Text style={styles.buttonText}>Track Interaction</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              trackDownload(
                'Download',
                'PDF Download',
                'https://example.com/download.pdf'
              );
            }}
          >
            <Text style={styles.buttonText}>Track Download</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              setUserId('jondoe@example.com');
            }}
          >
            <Text style={styles.buttonText}>Set User Id</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              setVisitorId('0123456789abcdef');
            }}
          >
            <Text style={styles.buttonText}>Set Visistor Id</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              disableTracking()
            }}
          >
            <Text style={styles.buttonText}>Disable Tracking</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              enableTracking()
            }}
          >
            <Text style={styles.buttonText}>Enable Tracking</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              setLogger()
            }}
          >
            <Text style={styles.buttonText}>Set Logger</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              trackMediaEvent({ siteId: "siteId", mediaId: Date.now.toString(), mediaTitle: "video media play track", playerName: "test 08", mediaType: MediaType.VIDEO, mediaResource: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", mediaStatus: "100", mediaLength: "100", mediaFullScreen: "1", mediaHeight: "720", mediaWidth: "1080", mediaProgress: "100",
              dimensions:[{key:"1",value: "cf7fad2e-fae4-4c49-9924-ad9a2a7c50de"}]
            });
            }}
          >
            <Text style={styles.buttonText}>Video Play Stop</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              trackCustomDimension({ 
              dimensions:[{key:"1",value: "cf7fad2e-fae4-4c49-9924-ad9a2a7c50de"},{key:"2",value: "cf7fad2e-fae4-4c49-9924-ad9a2a7c50de"}]
            });
            }}
          >
            <Text style={styles.buttonText}>Track Custom Dimension</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
              trackDispatch()

            }}
          >
            <Text style={styles.buttonText}>Track Dispatch</Text>
          </Pressable>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
  button: {
    width: '90%',
    marginVertical: 10,
    borderRadius: 10,
    paddingVertical: 10,
    alignItems: 'center',
    backgroundColor: 'green',
  },
  buttonText: {
    color: 'white',
    fontWeight: '700',
  },
  main: {
    flex: 1,
    paddingTop: 20,
  },
});
