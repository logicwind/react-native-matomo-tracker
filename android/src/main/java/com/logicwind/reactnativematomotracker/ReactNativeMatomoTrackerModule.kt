package com.logicwind.reactnativematomotracker

import android.annotation.SuppressLint
import android.app.Application
import android.content.ContentValues.TAG
import android.content.Context
import android.content.pm.PackageInfo
import android.os.Build
import android.util.Log
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.bridge.ReadableMap
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import org.json.JSONObject
import org.matomo.sdk.Matomo
import org.matomo.sdk.Tracker
import org.matomo.sdk.TrackerBuilder
import org.matomo.sdk.extra.TrackHelper
import timber.log.Timber
import java.net.URL
import java.net.URLEncoder
import java.util.Objects


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

    if (uri.isEmpty() &&  siteId <= 0) {
      Log.e("createTracker", "baseURL and siteId is empty or undefined");
    }
    else if(uri.isEmpty()){
      Log.e("createTracker", "baseURL is empty or undefined");
    }
    else if(siteId <= 0){
      Log.e("createTracker", "siteId is empty or undefined");
    }
    else{
      site_Id = siteId.toString();
      setTracker(uri,siteId)
    }
  }

  @ReactMethod
  fun trackScreen(screenName:String,title:String,dimensions:ReadableMap) {
    if (tracker != null) {
      val trackBuilder = TrackHelper.track()
      trackActionCustomDimension(dimensions,trackBuilder)
      trackBuilder.screen(screenName).title(title).with(tracker)
    }
  }

  @ReactMethod
  fun trackEvent(category:String,action:String,name:String,value:Float,dimensions:ReadableMap) {
    if (tracker != null) {
      val trackBuilder = TrackHelper.track()
      trackActionCustomDimension(dimensions,trackBuilder)
      trackBuilder.event(category, action).name(name).value(value).with(tracker)
    }
  }
  @ReactMethod
  fun trackDispatch() {
    if (tracker != null) {
      tracker?.dispatch()
    }
  }


  @ReactMethod
  fun trackOutlink(url:String,dimensions: ReadableMap) {
    val validUrl = URL(url)
    if (tracker != null) {
      val trackBuilder = TrackHelper.track()
      trackActionCustomDimension(dimensions,trackBuilder)
      trackBuilder
        .outlink(validUrl)
        .with(tracker);
    }
  }

  @ReactMethod
  fun trackSearch(keyword:String,dimensions: ReadableMap) {
    if (tracker != null) {
      val trackBuilder = TrackHelper.track()
      trackActionCustomDimension(dimensions,trackBuilder)
      trackBuilder
      .search(keyword)
      .with(tracker);
    }
  }

  @ReactMethod
  fun trackImpression(contentName:String,dimensions: ReadableMap) {
    if (tracker != null) {
      val trackBuilder = TrackHelper.track()
      trackActionCustomDimension(dimensions,trackBuilder)
      trackBuilder
        .impression(contentName)
        .with(tracker);
    }
  }


  @ReactMethod
  fun trackInteraction(contentName:String,contentInteraction:String,dimensions: ReadableMap) {
    if (tracker != null) {
      val trackBuilder = TrackHelper.track()
      trackActionCustomDimension(dimensions,trackBuilder)
      trackBuilder
        .interaction(contentName, contentInteraction)
        .with(tracker)
    }
  }

  @ReactMethod
  fun trackDownload(category: String,action: String,url: String,dimensions: ReadableMap) {
    if (tracker != null) {
      val trackBuilder = TrackHelper.track()
      trackActionCustomDimension(dimensions,trackBuilder)
      trackBuilder.event(category, action).name(url).with(tracker);
      trackBuilder.download().with(tracker);
    }
  }

  @ReactMethod
  fun setUserId(id:String) {
    if (tracker != null) {
      tracker?.setUserId(id);
    }
  }

  @ReactMethod
  fun trackScreens(dimensions: ReadableMap) {
    if (tracker != null) {
      val trackBuilder = TrackHelper.track()
      trackActionCustomDimension(dimensions,trackBuilder)
      trackBuilder.screens(Application()).with(tracker);
    }
  }

  @ReactMethod
  fun trackGoal(goalId:Int,revenue:Float,dimensions: ReadableMap) {
    if (tracker != null) {
      val trackBuilder = TrackHelper.track()
      trackActionCustomDimension(dimensions,trackBuilder)
      trackBuilder.goal(goalId).revenue(revenue).with(tracker);
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
  fun trackCampaign(title:String, campaignUrl: String,dimensions:ReadableMap) {

    val action = dimensions.getMap("dimension")?.getArray("action")?.toArrayList()
      ?.map { it as Map<String, String> } ?: emptyList()

    val visit = dimensions.getMap("dimension")?.getArray("visit")?.toArrayList()
      ?.map { it as Map<String, String> } ?: emptyList()


    if (tracker != null) {
      val userAgent = getUserAgent(context)
      val baseUrl = tracker?.apiUrl

      var query = "idsite=${encode(site_Id)}" +
        "&rec=1" +
        "&url=${encode(campaignUrl)}" +
        "&action_name=${title}"

        if(action.isNotEmpty()){
          action.forEach { map ->
            map.forEach { (key, value) ->
              query=query+"&dimension${key}=${value}"
            }
          }
        }

      visit.forEach { map ->
        map.forEach { (key, value) ->
          query=query+"&dimension${key}=${value}"
        }
      }

      query=query+ "&_id=${encode(tracker?.visitorId.toString())}"

        try {
          val urlString = "$baseUrl?$query"
          val jsonBody = """
                {
                    "auth_token": "$authToken"
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
  fun trackCustomDimension(
    dimensions: ReadableArray
  ) {
    if (dimensions.size() > 0) {
      for (i in 0 until dimensions.size()) {
        val dimension = dimensions.getMap(i)
        val key = dimension?.getString("key")
        val value = dimension?.getString("value")
        if (key != null && value != null) {

          val id = key.toIntOrNull()
          if (id != null) {
            TrackHelper.track().screen("/customDimension").dimension(id,value).with(tracker)
            trackDispatch();
          } else {
            println("Key could not be converted to an Int")
          }
        }
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
    mediaFullScreen:String,
    actionDimensions: ReadableMap
  ) {

    if(siteId.isNotEmpty() && tracker!=null){
      if(mediaStatus=="0") {
        TrackHelper.track().event(mediaType, "play").name(mediaTitle).with(tracker)
        trackDispatch()
      }
      if(mediaStatus==mediaLength && mediaStatus==mediaProgress) {
        TrackHelper.track().event(mediaType, "stop").name(mediaTitle).with(tracker)
        trackDispatch()
      }

      fun convertJsonString(jsonString: String): JSONObject? {
        return try {
          JSONObject(jsonString)
        } catch (e: Exception) {
          e.printStackTrace()
          null
        }
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
        "&ma_st=${encode(mediaStatus)}"


      val action = actionDimensions.getMap("dimension")?.getArray("action")?.toArrayList()
        ?.map { it as Map<String, String> } ?: emptyList()

      val visit = actionDimensions.getMap("dimension")?.getArray("visit")?.toArrayList()
        ?.map { it as Map<String, String> } ?: emptyList()

      if(action.isNotEmpty()){
        action.forEach { map ->
          map.forEach { (key, value) ->
            query=query+"&dimension${key}=${value}"
          }
        }
      }

      visit.forEach { map ->
        map.forEach { (key, value) ->
          query=query+"&dimension${key}=${value}"
        }
      }

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
          println("responseCode : $responseCode")
        }
      }catch (e:Exception){
        Log.e(TAG, "error : ${e.message}")
      }
    }
  }

  fun trackActionCustomDimension(
    dimensions: ReadableMap,
    matomoTracker: TrackHelper
  ): TrackHelper {
    val action = dimensions.getMap("dimension")?.getArray("action")?.toArrayList()
      ?.map { it as Map<String, String> } ?: emptyList()

    val visit = dimensions.getMap("dimension")?.getArray("visit")?.toArrayList()
      ?.map { it as Map<String, String> } ?: emptyList()

    if(action.isNotEmpty()){
      action.forEach { map ->
        map.forEach { (key, value) ->
          val id = key.toIntOrNull() ?: 0
          matomoTracker.dimension(id,value)
        }
      }
    }

    if(visit.isNotEmpty()) {
      visit.forEach { map ->
        map.forEach { (key, value) ->
          val id = key.toIntOrNull() ?: 0
          matomoTracker.dimension(id, value)
        }
      }
    }

    return matomoTracker;
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
