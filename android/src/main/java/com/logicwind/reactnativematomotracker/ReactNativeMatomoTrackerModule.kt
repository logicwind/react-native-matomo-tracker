package com.logicwind.reactnativematomotracker

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import timber.log.Timber
import org.matomo.sdk.Matomo
import org.matomo.sdk.Tracker
import org.matomo.sdk.TrackerBuilder
import org.matomo.sdk.extra.TrackHelper
import java.net.URL
import android.content.ContentValues.TAG
import android.util.Log
import android.app.Application


class ReactNativeMatomoTrackerModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  private val mMatomoTracker: Matomo? = Matomo.getInstance(reactContext)

  private var tracker: Tracker? = null

  override fun getName(): String {
    return NAME
  }

  @Synchronized
  fun setTracker(uri:String,siteId: Int) {
    if (tracker == null) {
      try {

        tracker = TrackerBuilder.createDefault(uri, siteId)
          .build(mMatomoTracker)
          Log.e(TAG, "initialized successfully! ${tracker}")

      } catch (e: Exception) {
        Log.e(TAG, "An error occurred: ${e.message}")
      }

    }
  }




  // Example method
  // See https://reactnative.dev/docs/native-modules-android

  @ReactMethod
  fun startSession() {
    tracker?.startNewSession()
  }

  @ReactMethod
  fun createTracker(uri:String,siteId:Int) {
    setTracker(uri,siteId)
  }

  @ReactMethod
  fun trackScreen(screenName:String,title:String) {
    if (tracker != null) {
      TrackHelper.track().screen(screenName).title(title).with(tracker)
    }
  }

  @ReactMethod
  fun trackEvent(category:String,action:String,name:String,value:Float) {
    if (tracker != null) {
      TrackHelper.track().event(category, action).name(name).value(value).with(tracker)
    }
  }
  @ReactMethod
  fun trackDispatch() {
    if (tracker != null) {
      tracker?.dispatch()
    }
  }


  @ReactMethod
  fun trackOutlink(url:String) {
    val validUrl = URL(url)
    if (tracker != null) {
      TrackHelper.track()
        .outlink(validUrl)
        .with(tracker);
    }
  }

  @ReactMethod
  fun trackSearch(keyword:String) {
    if (tracker != null) {
    TrackHelper.track()
      .search(keyword)
      .with(tracker);
    }
  }

  @ReactMethod
  fun trackImpression(contentName:String) {
    if (tracker != null) {
      TrackHelper.track()
        .impression(contentName)
        .with(tracker);
    }
  }


  @ReactMethod
  fun trackInteraction(contentName:String,contentInteraction:String) {
    if (tracker != null) {
      TrackHelper.track()
        .interaction(contentName, contentInteraction)
        .with(tracker)
    }
  }

  @ReactMethod
  fun trackDownload(category: String,action: String,url: String) {
    if (tracker != null) {
      TrackHelper.track().event(category, action).name(url).with(tracker);
//    TrackHelper.track().download().with(tracker);
    }
  }

  @ReactMethod
  fun setUserId(id:String) {
    if (tracker != null) {
      tracker?.setUserId(id);
    }
  }

  @ReactMethod
  fun trackScreens() {
    if (tracker != null) {
      TrackHelper.track().screens(Application()).with(tracker);
    }
  }

  @ReactMethod
  fun trackGoal(goalId:Int,revenue:Float) {
    if (tracker != null) {
      TrackHelper.track().goal(goalId).revenue(revenue).with(tracker);
    }
  }

  @ReactMethod
  fun setVisitorId(visitorId:String) {
    if (tracker != null) {
      tracker?.setVisitorId(visitorId);
    }
  }

  @ReactMethod
  fun setLogger() {
    Timber.plant(Timber.DebugTree())
  }


  @ReactMethod
  fun setIsOptedOut(isOptedOut:Boolean) {
    Log.e(TAG, "An error occurred: ${isOptedOut}")
    if (tracker != null) {
      tracker?.setOptOut(isOptedOut);
    }
  }


  companion object {
    const val NAME = "ReactNativeMatomoTracker"
  }
}
