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
        Timber.plant(Timber.DebugTree())
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
  fun createTracker(uri:String,siteId:Int) {
    setTracker(uri,siteId)
  }

  @ReactMethod
  fun trackScreen(screenName:String,title:String) {
    TrackHelper.track().screen(screenName).title(title).with(tracker)

  }

  @ReactMethod
  fun trackEvent(category:String,action:String,name:String,value:Float) {
    TrackHelper.track().event(category, action).name(name).value(value).with(tracker)

  }
  @ReactMethod
  fun trackDispatch() {
    tracker?.dispatch()
  }


  @ReactMethod
  fun trackOutlink(url:String) {
    val validUrl = URL(url)
    TrackHelper.track()
      .outlink(validUrl)
      .with(tracker)
  }

  @ReactMethod
  fun trackSearch(keyword:String) {
    TrackHelper.track()
      .search(keyword)
      .with(tracker)
  }

  @ReactMethod
  fun trackImpression(contentName:String) {
    TrackHelper.track()
      .impression(contentName)
      .with(tracker)
  }


  @ReactMethod
  fun trackInteraction(contentName:String,contentInteraction:String) {
    TrackHelper.track()
      .interaction(contentName, contentInteraction)
      .with(tracker)
  }

  @ReactMethod
  fun trackDownload(category: String,action: String,url: String) {
    TrackHelper.track().event(category, action).name(url).with(tracker)
//    TrackHelper.track().download().with(tracker);
  }

  @ReactMethod
  fun setUserId(id:String) {
    tracker?.setUserId(id);
  }

  @ReactMethod
  fun trackScreens() {
    TrackHelper.track().screens(Application()).with(tracker);
  }

  @ReactMethod
  fun trackGoal(goalId:Int,revenue:Float) {
    TrackHelper.track().goal(goalId).revenue(revenue).with(tracker);
  }

  @ReactMethod
  fun setVisitorId(visitorId:String) {
    tracker?.setVisitorId(visitorId)
  }


  companion object {
    const val NAME = "ReactNativeMatomoTracker"
  }
}
