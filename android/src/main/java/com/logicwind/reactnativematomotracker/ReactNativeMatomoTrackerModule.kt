package com.logicwind.reactnativematomotracker

import android.app.Application
import android.content.ContentValues.TAG
import android.content.Context
import android.content.pm.PackageInfo
import android.os.Build
import android.util.Log
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import org.matomo.sdk.Matomo
import org.matomo.sdk.Tracker
import org.matomo.sdk.TrackerBuilder
import org.matomo.sdk.extra.TrackHelper
import timber.log.Timber
import java.net.URL
import java.net.URLEncoder


class ReactNativeMatomoTrackerModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  private val mMatomoTracker: Matomo? = Matomo.getInstance(reactContext)

  private var tracker: Tracker? = null
  private val client = OkHttpClient()
  private var authToken: String? = null
  private var site_Id: String = ""
  private var context:ReactApplicationContext  = reactContext

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

  @ReactMethod
  fun startSession() {
    tracker?.startNewSession()
  }

  @ReactMethod
  fun createTracker(uri:String,siteId:Int,token:String) {
    authToken = token;
    site_Id = siteId.toString();
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

      TrackHelper.track().download().with(tracker);

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
  fun disableTracking() {

    if (tracker != null) {
      tracker?.setOptOut(true);
    }
  }

  @ReactMethod
  fun enableTracking() {

    if (tracker != null) {
      tracker?.setOptOut(false);
    }
  }

  fun getUserAgent(context: ReactApplicationContext): String {
    val packageInfo: PackageInfo = context.packageManager.getPackageInfo(context.packageName, 0)
    val appName = context.applicationInfo.loadLabel(context.packageManager).toString()
    val appVersion = packageInfo.versionName
    val userAgent = "Android/${Build.VERSION.RELEASE} (${Build.MODEL}; ${Build.MANUFACTURER}), MatomoTrackerSDK/4.2 $appName/$appVersion"

    return userAgent
  }

  @ReactMethod
  fun trackCampaign(title:String, campaignUrl: String) {

    if (tracker != null) {
      val userAgent = getUserAgent(context)
      val baseUrl = tracker?.apiUrl
      var query = "idsite=${encode(site_Id)}" +
        "&rec=1" +
        "&url=${encode(campaignUrl)}" +
        "&action_name=${title}" +
        "&_id=${encode(tracker?.visitorId.toString())}"
        try {
          val urlString = "$baseUrl?$query"
          val jsonBody = """
          {
              "auth_token": "$authToken",
          }
        """.trimIndent()

          val requestBody = jsonBody.toRequestBody("application/json; charset=utf-8".toMediaType())

          val request = Request.Builder()
            .url(urlString)
            .header("User-Agent",userAgent)
            .post(requestBody)
            .build()

          client.newCall(request).execute().use { response ->
            val responseCode = response.code
            println(" responseCode : "+ responseCode)
          }
        }catch (e:Exception){
          Log.e(TAG, "error : ${e.message}")
        }
    }
  }


  @ReactMethod
  fun trackMedia(
    siteId: String,
    mediaId: String,
    mediaTitle: String,
    playerName: String,
    mediaType: String,
    mediaResource: String,
    mediaStatus: String,
    mediaLength:String,
    mediaProgress:String,
    mediaTTP: String,
    mediaWidth: String,
    mediaHeight: String,
    mediaSE: String,
    mediaFullScreen:String

  ) {

    if(mediaStatus=="0") {
      TrackHelper.track().event(mediaType, "play").name(mediaTitle).with(tracker)
      trackDispatch()
    }
    if(mediaStatus==mediaLength && mediaStatus==mediaProgress) {
      TrackHelper.track().event(mediaType, "stop").name(mediaTitle).with(tracker)
      trackDispatch()
    }

    val baseUrl = tracker?.apiUrl
     val userAgent = getUserAgent(context)
    var query = "idsite=${encode(siteId)}" +
      "&rec=1" +
      "&r=${generateRandomNumber()}" +
      "&ma_id=${encode(mediaId)}" +
      "&ma_ti=${encode(mediaTitle)}" +
      "&ma_pn=${encode(playerName)}" +
      "&ma_mt=${encode(mediaType)}" +
      "&ma_re=${encode(mediaResource)}"+
      "&ma_st=${encode(mediaStatus)}"+
      "&_id=${encode(tracker?.visitorId.toString())}"

    if(mediaLength.isNotEmpty()){
      query=query+ "&ma_le=${encode(mediaLength)}";
    }

    if(mediaProgress.isNotEmpty()){
      query=query+  "&ma_ps=${encode(mediaProgress)}";
    }

    if(mediaWidth.isNotEmpty()){
      query=query+ "&ma_w=${encode(mediaWidth)}";
    }

    if(mediaHeight.isNotEmpty()){
      query=query+  "&ma_h=${encode(mediaHeight)}";
    }

    if(mediaFullScreen.isNotEmpty()){
      query=query+ "&ma_fs=${encode(mediaFullScreen)}";
    }

    if(mediaSE.isNotEmpty()){
      query=query+  "&ma_se=${encode(mediaSE)}";
    }

    if(mediaTTP.isNotEmpty()){
      query=query+ "&ma_ttp=${encode(mediaTTP)}";
    }
    try {
      val urlString = "$baseUrl?$query"
      val jsonBody = """
        {
            "auth_token": "$authToken",
        }
      """.trimIndent()

      val requestBody = jsonBody.toRequestBody("application/json; charset=utf-8".toMediaType())

      val request = Request.Builder()
        .url(urlString)
        .header("User-Agent",userAgent)
        .post(requestBody)
        .build()

      client.newCall(request).execute().use { response ->
        val responseCode = response.code
      }
    }catch (e:Exception){
      Log.e(TAG, "error : ${e.message}")
    }
  }

  private fun generateRandomNumber(): Long {
    return (Math.random() * Long.MAX_VALUE).toLong()
  }

  private fun encode(value: String): String {
    return URLEncoder.encode(value, "UTF-8")
  }


    companion object {
    const val NAME = "ReactNativeMatomoTracker"
  }
}
