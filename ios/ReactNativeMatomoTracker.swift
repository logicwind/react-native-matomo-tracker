import Foundation
import MatomoTracker

@objc(ReactNativeMatomoTracker)
class ReactNativeMatomoTracker: NSObject {

    var matomoTracker: MatomoTracker?

    
    override init() {
            super.init()
       
            // Initialize matomoTracker here or in createTracker method

    }
  
    @objc(createTracker:withSiteId:)
    func createTracker(uri:String,siteId:String) {
        let queue = UserDefaultsQueue(UserDefaults.standard, autoSave: true)
        let dispatcher = URLSessionDispatcher(baseURL: URL(string:uri)!)
        matomoTracker = MatomoTracker(siteId: siteId, queue: queue, dispatcher: dispatcher)
    
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
        let url = URL(string: url)
        matomoTracker?.track(view: [], url: url)
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
        let downloadURL = URL(string: url)!
        matomoTracker?.track(eventWithCategory: category,  action: action, name: downloadURL.absoluteString, value: nil)
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
    }
}
