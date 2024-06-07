import Foundation
import MatomoTracker

@objc(ReactNativeMatomoTracker)
class ReactNativeMatomoTracker: NSObject {

    var matomoTracker: MatomoTracker?
    var baseURL = "";
    var _id = "";
    override init() {
            super.init()
       
            // Initialize matomoTracker here or in createTracker method
        _id = newVisitorID()
        matomoTracker?.forcedVisitorId = _id;
       
    }
  
    @objc(createTracker:withSiteId:)
    func createTracker(uri:String,siteId:String) {
        let queue = UserDefaultsQueue(UserDefaults.standard, autoSave: true)
         baseURL =  uri
    
        let dispatcher = URLSessionDispatcher(baseURL: URL(string:baseURL)!)
        matomoTracker = MatomoTracker(siteId: siteId, queue: queue, dispatcher: dispatcher)
        matomoTracker?.userId = _id;
    }
    
    
    @objc(startSession)
    func startSession() {
        matomoTracker?.startNewSession()
     }

    
   @objc(trackScreen:withTitle:)
   func trackScreen(screenName: String, title: String) {
       matomoTracker?.track(view: [screenName,title])
    }

    @objc(trackDispatch)
    func trackDispatch() {
          matomoTracker?.dispatch()
    }
    
    @objc(trackEvent:withAction:withName:withValue:)
    func trackEvent(category:String,action:String,name:String,value:Float) {
        matomoTracker?.track(eventWithCategory:category, action:action,name: name,value:value)
    }
    
    @objc(trackOutlink:)
    func trackOutlink(url:String) {
        let event = Event(tracker: matomoTracker!, action: ["link"],customTrackingParameters: ["link" : url],isCustomAction: true)
             matomoTracker?.track(event)
    }
    
    @objc(trackSearch:)
    func trackSearch(keyword:String) {
        matomoTracker?.trackSearch(query:keyword,category: "",resultCount: 0)
    }
    

    @objc(trackImpression:)
    func trackImpression(contentName:String) {
        matomoTracker?.trackContentImpression(name: contentName, piece:"", target:"")
    }
    
    @objc(trackInteraction:withContentInteraction:)
    func trackInteraction(contentName:String,contentInteraction:String) {
        matomoTracker?.trackContentInteraction(name:contentName, interaction:contentInteraction,piece: "",target: "")
    }
    
    @objc(trackDownload:withAction:withUrl:)
    func trackDownload(category:String,action:String,url:String) {
        let event = Event(tracker: matomoTracker!, action: ["download"],customTrackingParameters: ["download" : url],isCustomAction: true)
             matomoTracker?.track(event)
    }
    
    @objc(setUserId:)
    func setUserId(id:String) {
        matomoTracker?.userId=id
    }
    
    @objc(trackScreens)
    func trackScreens() {
      
    }
    
    @objc(trackGoal:withRevenue:)
    func trackGoal(goalId:Int,revenue:Float) {
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
    

    @objc(trackMedia:withMediaId:withMediaTitle:withPlayerName:withMediaType:withMediaResource:withMediaStatus:withMediaLength:withMediaProgress:withMediaTTP:withMediaWidth:withMediaHeight:withMediaSE:withMediaFullScreen:)
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
        mediaFullScreen:String
    ) {
        
        if(mediaStatus=="0"){
            
            matomoTracker?.track(eventWithCategory:mediaType, action:"play",name: mediaTitle)
            matomoTracker?.dispatch()
        }

        if(mediaStatus==mediaLength){
            matomoTracker?.track(eventWithCategory:mediaType, action:"stop",name: mediaTitle)
            matomoTracker?.dispatch()
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
                    "&ma_st=\(encodeParameter(value: mediaStatus))" +
                    "&cid=\(encodeParameter(value: _id))" +
                    "&uid=\(encodeParameter(value: uid))"
        
        
        
        if(!mediaLength.isEmpty){
            query=query+"&ma_le=\(encodeParameter(value: mediaLength))";
        }
        
        if(!mediaProgress.isEmpty){
            query=query+"&ma_st=\(encodeParameter(value: mediaProgress))";
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
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                }
            }
            task.resume()
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

