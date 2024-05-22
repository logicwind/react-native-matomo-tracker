import * as React from 'react';

import {
  StyleSheet,
  View,
  Text,
  Pressable,
  ScrollView,
  SafeAreaView,
  Platform,
} from 'react-native';

import {
  createTracker,
  setIsOptedOut,
  setLogger,
  setUserId,
  setVisitorId,
  startSession,
  trackDispatch,
  trackDownload,
  trackEvent,
  trackImpression,
  trackInteraction,
  trackOutlink,
  trackScreen,
  trackSearch,

} from '@logicwind/react-native-matomo-tracker';

export default function App() {
  const [result] = React.useState<number | undefined>();

  const [optedOut,setOptedOut]=React.useState(false)

  React.useEffect(() => {
    createTracker("https://matomo.cappital.co/matomo.php",43) //Replace 1 with your matomo site id
  }, []);

  return (
    <SafeAreaView style={styles.main}>
      <ScrollView showsHorizontalScrollIndicator={false}>
        <View style={styles.container}>
          <Text>Matomo Tracking {result}</Text>
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
              if (Platform.OS === 'ios') {
                setVisitorId('123e4567-e89b-12d3-a456-426614174000');
              } else {
                setVisitorId('2c534f55fba6cf6e');
              }
            }}
          >
            <Text style={styles.buttonText}>Set Visistor Id</Text>
          </Pressable>

          <Pressable
            style={styles.button}
            onPress={() => {
            setIsOptedOut(!optedOut)
            setOptedOut(!optedOut)
            }}
          >
            <Text style={styles.buttonText}>Set Is OptedOut {optedOut?"NO":"OFF"}</Text>
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
              trackDispatch();
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
