import Foundation
import MatomoTracker

@objc(ReactNativeMatomoTracker)
class ReactNativeMatomoTracker: NSObject {

    var matomoTracker: MatomoTracker?
    var baseURL = "";
    var site_id = "";
    var authToken = "";
    var _id = "";
    override init() {
            super.init()
       
            // Initialize matomoTracker here or in createTracker method
        _id = newVisitorID()
        matomoTracker?.forcedVisitorId = _id;
       
    }
  
    @objc(createTracker:withSiteId:withToken:)
    func createTracker(uri:String,siteId:String,token:String) {
            authToken = token
            let queue = UserDefaultsQueue(UserDefaults.standard, autoSave: true)
            
             baseURL =  uri
             site_id = siteId
            if(baseURL.isEmpty && siteId.isEmpty){
                print("createTracker : baseURL and siteId is empty or undefined")
            }
            else if(baseURL.isEmpty){
                print("createTracker : baseURL is empty or undefined")
            }
            else if(siteId.isEmpty){
                print("createTracker : siteId is empty or undefined")
            }
            else if(!baseURL.isEmpty && !siteId.isEmpty){
                let dispatcher = URLSessionDispatcher(baseURL: URL(string:baseURL)!)
                matomoTracker = MatomoTracker(siteId: siteId, queue: queue, dispatcher: dispatcher)
                matomoTracker?.userId = _id;
            }
    }
    
    
    @objc(startSession)
    func startSession() {
        matomoTracker?.startNewSession()
     }

    
    @objc(trackScreen:withTitle:withActionDimensions:)
    func trackScreen(screenName: String, title: String,actionDimensions:[NSDictionary]) {
      let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
       matomoTracker?.track(view: [screenName,title],dimensions:dimensions)
    }

    @objc(trackDispatch)
    func trackDispatch() {
          matomoTracker?.dispatch()
    }
    
    @objc(trackEvent:withAction:withName:withValue:withActionDimensions:)
    func trackEvent(category:String,action:String,name:String,value:Float,actionDimensions:[NSDictionary]) {
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        matomoTracker?.track(eventWithCategory:category, action:action,name: name,value:value,dimensions:dimensions)
    }
    
    @objc(trackOutlink:withActionDimensions:)
    func trackOutlink(url:String,actionDimensions:[NSDictionary]) {
        if(matomoTracker != nil){
            let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
            setActionCustomDimension(dimensions: dimensions, matomoTracker: matomoTracker)
            let event = Event(tracker: matomoTracker!, action: ["link"],customTrackingParameters: ["link" : url],isCustomAction: true)
            matomoTracker?.track(event)
        }
    }
    
    @objc(trackSearch:withActionDimensions:)
    func trackSearch(keyword:String,actionDimensions:[NSDictionary]) {
         let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        setActionCustomDimension(dimensions: dimensions, matomoTracker: matomoTracker)
        matomoTracker?.trackSearch(query:keyword,category: "",resultCount: 0,dimensions: dimensions)
    }
    

    @objc(trackImpression:withActionDimensions:)
    func trackImpression(contentName:String,actionDimensions:[NSDictionary]) {
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        setActionCustomDimension(dimensions: dimensions, matomoTracker: matomoTracker)
        matomoTracker?.trackContentImpression(name: contentName, piece:"", target:"")
    }
    
    @objc(trackInteraction:withContentInteraction:withActionDimensions:)
    func trackInteraction(contentName:String,contentInteraction:String,actionDimensions:[NSDictionary]) {
        matomoTracker?.trackContentInteraction(name:contentName, interaction:contentInteraction,piece: "",target: "")
    }
    
    @objc(trackDownload:withAction:withUrl:withActionDimensions:)
    func trackDownload(category:String,action:String,url:String,actionDimensions:[NSDictionary]) {
        if(matomoTracker != nil){
            let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
            setActionCustomDimension(dimensions: dimensions, matomoTracker: matomoTracker)
            let event = Event(tracker: matomoTracker!, action: ["download"],customTrackingParameters: ["download" : url],isCustomAction: true)
            matomoTracker?.track(event)
        }
    }
    
    @objc(setUserId:)
    func setUserId(id:String) {
        matomoTracker?.userId=id
    }
    
    @objc(trackScreens)
    func trackScreens() {
      
    }
    
    @objc(trackGoal:withRevenue:withActionDimensions:)
    func trackGoal(goalId:Int,revenue:Float,actionDimensions:[NSDictionary]) {
        let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
        setActionCustomDimension(dimensions: dimensions, matomoTracker: matomoTracker)
        matomoTracker?.trackGoal(id: goalId, revenue: revenue)
    }
    
    @objc(setVisitorId:)
    func setVisitorId(id:String) {
        matomoTracker?.forcedVisitorId=id
        _id=id
    }
    
    @objc(disableTracking)
    func disableTracking() {
        matomoTracker?.isOptedOut = true;
    }
    
    @objc(enableTracking)
    func enableTracking() {
        matomoTracker?.isOptedOut = false;
    }
    
    @objc(setLogger)
    func setLogger() {
        matomoTracker?.logger = DefaultLogger(minLevel: .verbose)

    }
    
    @objc(trackCampaign:withCampaignUrl:withActionDimensions:)
    func trackCampaign(title:String,campaignUrl:String,actionDimensions:[NSDictionary]) {

        if let campaignUrl = URL(string: campaignUrl) {
            if let components = URLComponents(url: campaignUrl, resolvingAgainstBaseURL: false),
               let queryItems = components.queryItems {
                var campaignParameters = [String: String]()
                for queryItem in queryItems {
                    if let value = queryItem.value {
                        campaignParameters[queryItem.name] = value
                    }
                }
                let dimensions: [CustomDimension] = trackActionCustomDimension(dimensions: actionDimensions)
                matomoTracker?.track(view: ["campaign"], url: campaignUrl,dimensions:dimensions)
                matomoTracker?.dispatch()
            }
        } else {
           print("Invalid URL string")
        }
    }
  
    
    @objc(trackCustomDimension:)
    func trackCustomDimension(
        dimensions:[NSDictionary]
    ) {
        if(!dimensions.isEmpty){
            matomoTracker?.track(view: ["customDimension"])
          for dimension in dimensions {
            if let key = dimension["key"] as? String, let value = dimension["value"] as? String {
                if let id = Int(key) {
                    matomoTracker?.setDimension(value, forIndex: id)
                    matomoTracker?.dispatch()
                } else {
                    print("Key could not be converted to an Int")
                }
            }
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
        if(!siteId.isEmpty && matomoTracker != nil)
        {
            if(mediaStatus=="0"){
                matomoTracker?.track(eventWithCategory:mediaType, action:"play",name: mediaTitle)
            }
            if(mediaStatus==mediaLength){
                matomoTracker?.track(eventWithCategory:mediaType, action:"stop",name: mediaTitle)
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
            matomoTracker?.dispatch()
        }
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
  
    var actionCustomDimension: [CustomDimension]  = []
    if(!dimensions.isEmpty){
        for dimension in dimensions {
        if let key = dimension["key"] as? String, let value = dimension["value"] as? String {
            let intKey = Int(key) ?? 0
                actionCustomDimension.append(CustomDimension(index: intKey, value: value))
            }
        }
    }
    
    return actionCustomDimension
}

func setActionCustomDimension(dimensions: [CustomDimension],matomoTracker: MatomoTracker?){
   
    if(!dimensions.isEmpty){
        for dimension in dimensions {
            matomoTracker?.set(dimension:dimension )
        }
    }
}
