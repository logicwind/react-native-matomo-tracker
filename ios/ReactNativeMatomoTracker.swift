import Foundation
import MatomoTracker

@objc(ReactNativeMatomoTracker)
class ReactNativeMatomoTracker: NSObject {

    var matomoTracker: MatomoTracker?
    var baseURL = "";
    var site_id = "";
    var authToken = "";
    var _id = "";
    enum Logger {
        static func debug(_ message: @autoclosure () -> Any) {
            #if DEBUG
            print("ℹ️ [MATOMO][DEBUG] \(message())")
            #endif
        }

        static func error(_ message: @autoclosure () -> Any) {
            #if DEBUG
            print("❌ [MATOMO][ERROR] \(message())")
            #endif
        }

        static func info(_ message: @autoclosure () -> Any) {
            #if DEBUG
            print("ℹ️ [MATOMO][INFO] \(message())")
            #endif
        }
    }
    override init() {
        super.init()
       
            // Initialize matomoTracker here or in createTracker method
        _id = newVisitorID()
        matomoTracker?.forcedVisitorId = _id;
        Logger.debug("ReactNativeMatomoTracker init: Generated visitor ID = \(_id)")
    }
  
    @objc(createTracker:withSiteId:withToken:)
    func createTracker(uri: String, siteId: String, token: String) {
        Logger.debug("=== createTracker START ===")
        Logger.debug("URI: '\(uri)'")
        Logger.debug("SiteId: '\(siteId)'")
        Logger.debug("Token: '\(token)'")
        
        // Basic validation
        guard !uri.isEmpty else {
            Logger.error("ERROR: URI is empty")
            return
        }
        
        guard !siteId.isEmpty else {
            Logger.error("ERROR: SiteId is empty")
            return
        }
        
        // Store values
        authToken = token
        baseURL = uri
        site_id = siteId
        
        do {
            Logger.debug("Creating UserDefaultsQueue...")
            let queue = UserDefaultsQueue(UserDefaults.standard, autoSave: true)
            Logger.debug("UserDefaultsQueue created successfully")
            
            Logger.debug("Creating URL from: '\(baseURL)'")
            guard let url = URL(string: baseURL) else {
                Logger.error("ERROR: Invalid URL")
                return
            }
            Logger.debug("URL created successfully")
            
            Logger.debug("Creating URLSessionDispatcher...")
            let dispatcher = URLSessionDispatcher(baseURL: url)
            Logger.debug("URLSessionDispatcher created successfully")
            
            Logger.debug("Creating MatomoTracker...")
            matomoTracker = MatomoTracker(siteId: siteId, queue: queue, dispatcher: dispatcher)
            Logger.info("MatomoTracker created successfully")
            
            Logger.debug("Setting visitor ID...")
            matomoTracker?.forcedVisitorId = _id
            matomoTracker?.userId = _id
            Logger.debug("Visitor ID set successfully")
            
            Logger.info("=== createTracker SUCCESS ===")
        } catch {
            Logger.error("ERROR in createTracker: \(error)")
        }
    }
    
    @objc(startSession)
    func startSession() {
        Logger.info("startSession called")
        matomoTracker?.startNewSession()
    }

    @objc(trackScreen:withTitle:withActionDimensions:)
    func trackScreen(screenName: String, title: String, actionDimensions: [NSDictionary]) {
        Logger.debug("trackScreen called: \(screenName)")
        guard let tracker = matomoTracker else {
            Logger.error("ERROR: matomoTracker is nil")
            return
        }
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        tracker.track(view: [screenName, title], dimensions: dimensions)
    }

    @objc(trackDispatch)
    func trackDispatch() {
        Logger.debug("trackDispatch called")
        matomoTracker?.dispatch()
    }
    
    @objc(trackEvent:withAction:withName:withValue:withActionDimensions:)
    func trackEvent(category:String,action:String,name:String,value:NSNumber,actionDimensions:[NSDictionary]) {
        Logger.debug("trackEvent called: \(category)/\(action)")
        guard let tracker = matomoTracker else {
            Logger.error("ERROR: matomoTracker is nil")
            return
        }
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        tracker.track(eventWithCategory:category, action:action,name: name,value:value.floatValue,dimensions:dimensions)
    }
    
    @objc(trackOutlink:withActionDimensions:)
    func trackOutlink(url: String, actionDimensions: [NSDictionary]) {
        Logger.debug("trackOutlink called: \(url)")
        guard let tracker = matomoTracker else {
            Logger.error("ERROR: matomoTracker is nil")
            return
        }
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        setActionCustomDimension(dimensions: dimensions, matomoTracker: tracker)
        let event = Event(tracker: tracker, action: ["link"], customTrackingParameters: ["link": url], isCustomAction: true)
        tracker.track(event)
    }
    
    @objc(trackSearch:withActionDimensions:)
    func trackSearch(keyword: String, actionDimensions: [NSDictionary]) {
        Logger.debug("trackSearch called: \(keyword)")
        guard let tracker = matomoTracker else {
            Logger.error("ERROR: matomoTracker is nil")
            return
        }
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        setActionCustomDimension(dimensions: dimensions, matomoTracker: tracker)
        tracker.trackSearch(query: keyword, category: "", resultCount: 0, dimensions: dimensions)
    }
    
    @objc(trackImpression:withActionDimensions:)
    func trackImpression(contentName: String, actionDimensions: [NSDictionary]) {
        Logger.debug("trackImpression called: \(contentName)")
        guard let tracker = matomoTracker else {
            Logger.error("ERROR: matomoTracker is nil")
            return
        }
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        setActionCustomDimension(dimensions: dimensions, matomoTracker: tracker)
        tracker.trackContentImpression(name: contentName, piece: "", target: "")
    }
    
    @objc(trackInteraction:withContentInteraction:withActionDimensions:)
    func trackInteraction(contentName: String, contentInteraction: String, actionDimensions: [NSDictionary]) {
        Logger.debug("trackInteraction called: \(contentName)")
        matomoTracker?.trackContentInteraction(name: contentName, interaction: contentInteraction, piece: "", target: "")
    }
    
    @objc(trackDownload:withAction:withUrl:withActionDimensions:)
    func trackDownload(category: String, action: String, url: String, actionDimensions: [NSDictionary]) {
        Logger.debug("trackDownload called: \(url)")
        guard let tracker = matomoTracker else {
            Logger.error("ERROR: matomoTracker is nil")
            return
        }
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        setActionCustomDimension(dimensions: dimensions, matomoTracker: tracker)
        let event = Event(tracker: tracker, action: ["download"], customTrackingParameters: ["download": url], isCustomAction: true)
        tracker.track(event)
    }
    
    @objc(setUserId:)
    func setUserId(id: String) {
        Logger.debug("setUserId called: \(id)")
        matomoTracker?.userId = id
    }
    
    @objc(trackScreens)
    func trackScreens() {
        Logger.debug("trackScreens called")
    }
    
    @objc(trackGoal:withRevenue:withActionDimensions:)
    func trackGoal(goalId: Int, revenue: NSNumber, actionDimensions: [NSDictionary]) {
        Logger.debug("trackGoal called: \(goalId)")
        guard let tracker = matomoTracker else {
            Logger.error("ERROR: matomoTracker is nil")
            return
        }
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        setActionCustomDimension(dimensions: dimensions, matomoTracker: tracker)
        tracker.trackGoal(id: goalId, revenue: revenue.floatValue)
    }
    
    @objc(setVisitorId:)
    func setVisitorId(id: String) {
        Logger.debug("setVisitorId called: \(id)")
        matomoTracker?.forcedVisitorId = id
        _id = id
    }
    
    @objc(disableTracking)
    func disableTracking() {
        Logger.debug("disableTracking called")
        matomoTracker?.isOptedOut = true
    }
    
    @objc(enableTracking)
    func enableTracking() {
        Logger.debug("enableTracking called")
        matomoTracker?.isOptedOut = false
    }
    
    @objc(setLogger)
    func setLogger() {
        Logger.debug("setLogger called")
        matomoTracker?.logger = DefaultLogger(minLevel: .verbose)
    }
    
    @objc(trackCampaign:withCampaignUrl:withActionDimensions:)
    func trackCampaign(title: String, campaignUrl: String, actionDimensions: [NSDictionary]) {
        Logger.debug("trackCampaign called: \(title)")
        guard let campaignURL = URL(string: campaignUrl),
              let components = URLComponents(url: campaignURL, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            Logger.error("ERROR: Invalid campaign URL")
            return
        }
        
        var campaignParameters = [String: String]()
        for queryItem in queryItems {
            if let value = queryItem.value {
                campaignParameters[queryItem.name] = value
            }
        }
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        matomoTracker?.track(view: ["campaign"], url: campaignURL, dimensions: dimensions)
        matomoTracker?.dispatch()
    }
    
    @objc(trackCustomDimension:)
    func trackCustomDimension(dimensions: [NSDictionary]) {
        Logger.debug("trackCustomDimension called")
        guard !dimensions.isEmpty else { return }
        
        matomoTracker?.track(view: ["customDimension"])
        for dimension in dimensions {
            if let key = dimension["key"] as? String,
               let value = dimension["value"] as? String,
               let id = Int(key) {
                matomoTracker?.setDimension(value, forIndex: id)
                matomoTracker?.dispatch()
            } else {
                Logger.error("Error: Key could not be converted to an Int")
            }
        }
    }
    
    @objc(trackMedia:withMediaId:withMediaTitle:withPlayerName:withMediaType:withMediaResource:withMediaStatus:withMediaLength:withMediaProgress:withMediaTTP:withMediaWidth:withMediaHeight:withMediaSE:withMediaFullScreen:withActionDimensions:)
    func trackMediaEvent(
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
        actionDimensions:[NSDictionary]
    ) {
        Logger.debug("trackMediaEvent called: \(mediaTitle)")
        // Simplified implementation for now
        guard !siteId.isEmpty, let tracker = matomoTracker else {
            Logger.error("ERROR: Invalid siteId or matomoTracker is nil")
            return
        }
        
        if mediaStatus == "0" {
            tracker.track(eventWithCategory: mediaType, action: "play", name: mediaTitle)
        }
        if mediaStatus == mediaLength {
            tracker.track(eventWithCategory: mediaType, action: "stop", name: mediaTitle)
        }
        var uid =  ""
        if var userId = matomoTracker?.userId {
            uid = userId
        } else {
            uid = ""
        }
        
        
        let baseUrl = baseURL
            var query = "idsite=\(encodeParameter(value: siteId))" +
                        "&rec=1" +
                        "&r=\(generateRandomNumber())" +
                        "&ma_id=\(encodeParameter(value: mediaId))" +
                        "&ma_ti=\(encodeParameter(value: mediaTitle))" +
                        "&ma_pn=\(encodeParameter(value: playerName))" +
                        "&ma_mt=\(encodeParameter(value: mediaType))" +
                        "&ma_re=\(encodeParameter(value: mediaResource))" +
                        "&ma_st=\(encodeParameter(value: mediaStatus))"
        
        if(!actionDimensions.isEmpty){
                          for dimension in actionDimensions {
                            if let key = dimension["key"] as? String, let value = dimension["value"] as? String {
                                let intKey = Int(key) ?? 0
                                query=query+"&dimension\(intKey)=\(encodeParameter(value: value))";
                            }
                          }
                        }
        
            
            query=query+"&cid=\(encodeParameter(value: _id))" +
            "&uid=\(encodeParameter(value: uid))"


        if(!mediaLength.isEmpty){
                query=query+"&ma_le=\(encodeParameter(value: mediaLength))";
            }
            
            if(!mediaProgress.isEmpty){
                query=query+"&ma_ps=\(encodeParameter(value: mediaProgress))";
            }

            if(!mediaWidth.isEmpty){
                query=query+"&ma_w=\(encodeParameter(value: mediaWidth))";
            }

            if(!mediaHeight.isEmpty){
                query=query+"&ma_h=\(encodeParameter(value: mediaHeight))";
            }

            if(!mediaFullScreen.isEmpty){
                query=query+"&ma_fs=\(encodeParameter(value: mediaFullScreen))";
            }
            
            if(!mediaSE.isEmpty){
                query=query+"&ma_se=\(encodeParameter(value: mediaSE))";
            }
            
            if(!mediaTTP.isEmpty){
                query=query+"&ma_ttp=\(encodeParameter(value: mediaTTP))";
            }


            let urlString = "\(baseUrl)?\(query)"
            
            if let url = URL(string: urlString) {
                    var request = URLRequest(url: url)
                   let device = Device.makeCurrentDevice();
                   let application = Application.makeCurrentApplication()
                   let userAgent = "Darwin/\(device.darwinVersion ?? "Unknown-Version") (\(device.platform); \(device.operatingSystem) \(device.osVersion)), MatomoTrackerSDK/\(MatomoTracker.sdkVersion)\(application.bundleName ?? "Unknown-App")/\(application.bundleShortVersion ?? "Unknown-Version")";
                    request.httpMethod = "POST"
                    request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
                    request.setValue("\(authToken)", forHTTPHeaderField: "token_auth")
                    let task = URLSession.shared.dataTask(with:  request) { data, response, error in
                        if let httpResponse = response as? HTTPURLResponse {
                            let statusCode = httpResponse.statusCode
                        }
                }
                task.resume()
            }    
        tracker.dispatch()
    }

     private func generateRandomNumber() -> UInt64 {
           return UInt64(arc4random_uniform(UInt32.max))
       }

    private func encodeParameter(value: String) -> String {
          return value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
      }
    

    func newVisitorID() -> String {
        let uuid = UUID().uuidString
        let sanitizedUUID = uuid.replacingOccurrences(of: "-", with: "")
        let start = sanitizedUUID.startIndex
        let end = sanitizedUUID.index(start, offsetBy: 16)
        return String(sanitizedUUID[start..<end])
    }
}

func trackActionCustomDimension(dimensions: [NSDictionary]) -> [CustomDimension] {

    var actionCustomDimension: [CustomDimension] = []

    for dimension in dimensions {
        if let key = dimension["key"] as? String,
           let value = dimension["value"] as? String,
           let intKey = Int(key) {
            actionCustomDimension.append(CustomDimension(index: intKey, value: value))
        }
    }
    return actionCustomDimension
}

func setActionCustomDimension(dimensions: [CustomDimension], matomoTracker: MatomoTracker?) {
    
    for dimension in dimensions {
        matomoTracker?.set(dimension: dimension)
    }
}
