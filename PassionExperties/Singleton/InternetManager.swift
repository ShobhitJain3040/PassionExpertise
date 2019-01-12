

import Alamofire

open class InternetManager {
  
  /// Singleton instance
  static let sharedInstance = InternetManager()
  
  /// This prevents others from using the default '()' initializer for this class.
  fileprivate init() {
    self.reachabilityManager = NetworkReachabilityManager()
  }
  
  /// Reachability object
  open var reachabilityManager: NetworkReachabilityManager?
  
  /// Checks if the network is reachable or not.
  ///
  /// - returns: true/false or nil if `reachability` is nil
  open var isReachable: Bool {
    if self.reachabilityManager != nil {
      return self.reachabilityManager!.isReachable
    }
    return false
  }
  
  /// Starts the reachability notifier
  open func startNotifier() {
    reachabilityManager?.listener = { status in
      
      switch status {
        
      case .notReachable:
        debugLog("The network is not reachable")
        
      case .unknown :
        debugLog("It is unknown whether the network is reachable")
        
      case .reachable(.ethernetOrWiFi):
        debugLog("The network is reachable over the WiFi connection")
        
      case .reachable(.wwan):
        debugLog("The network is reachable over the WWAN connection")
        
      }
    }
    
    // start listening
    reachabilityManager?.startListening()
  }
}
