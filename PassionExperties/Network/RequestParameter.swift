

import Alamofire


open class RequestParameter {
  /// Url to hit the api
  var url: String
  
  /// Method type e.g. GET/POST etc.
  var method: Alamofire.HTTPMethod
  
  /// Headers needed for the api call
  var headers: [String: String]?
  
  /// Url encoded parameters
  var parameters: [String: Any]?
  
  
  /// Initializer to create the object
  ///
  ///
  /// - parameters:
  ///   - url: url to requst the API as `String` parameter.
  ///   - method: API method `Method` parameter.
  ///   - headers: Key:Value dictionay as `[String : String]` parameter.
  ///   - parameters: Key:Value dictionay as `[String : String]` parameter.
  /// - returns: Newly created RequestParameter object.
  fileprivate init(url: String, method: Alamofire.HTTPMethod, headers: [String: String]? = nil, parameters: [String: Any]? = nil) {
    self.url = url
    self.method = method
    self.headers = headers
    self.parameters = parameters
  }
  
  /// Creates the default signed signature in header and returns the RequestParameter
  ///
  ///
  /// - parameters:
  ///   - url: url to requst the API as `String` parameter.
  ///   - method: API method `Method` parameter.
  ///   - headers: Key:Value dictionay as `[String : String]` parameter.
  ///   - parameters: Key:Value dictionay as `[String : String]` parameter.
  /// - returns: Newly created RequestParameter object or nil if token or secret is nil.
  
  
  
  public static func createDefaultSignedRequestParameter(_ url: String, method: Alamofire.HTTPMethod, parameters: [String: Any]? = nil) -> RequestParameter {
    //check for token and key
//    if  DataStore.sharedInstance.apiToken == nil {
    
//      let userTokan = UserTokan.getCurrentUserCredential()
//      if userTokan != nil {
//        //set key and token
//        DataStore.sharedInstance.apiToken = userTokan?.tokan
//      }
//    }
    // Get the api token and secrect
    if  let token = DataStore.sharedInstance.apiToken {
      debugLog("url is: \(url)")
      debugLog("token is: \(token)")
      // create headers
      let headers = ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3QvanVuYWlkLXBlcmZ1bWUtYmFja2VuZC9hcGkvbG9naW4iLCJpYXQiOjE1NDI1MzQ5NDMsImV4cCI6MTU1ODA4Njk0MywibmJmIjoxNTQyNTM0OTQzLCJqdGkiOiJYV2Q4R3NSODlSeHloRFo3In0.vmtZP3utwmxMcRk40Az4I2l7gbTHJIHMcNkT5eq3pd4"]
//       let headers = ["Authorization": headers]
      // return the requet parameter
      return RequestParameter(url: url, method: method, headers: headers, parameters: parameters)
    }
    else {
      debugLog("url is: \(url)")
      // creating request without signature, since token or secret is nil
      return RequestParameter(url: url, method: method, parameters: parameters)
    }
  }
  
  
  
  /// Creates the simple (not signed) RequestParameter
  ///
  ///
  /// - parameters:
  ///   - url: url to requst the API as `String` parameter.
  ///   - method: API method `Method` parameter.
  ///   - headers: Key:Value dictionay as `[String : String]` parameter.
  ///   - parameters: Key:Value dictionay as `[String : String]` parameter.
  /// - returns: Newly created RequestParameter object.
  public static func createRequestParameter(_ url: String, method: Alamofire.HTTPMethod, headers: [String: String]? = nil, parameters: [String: Any]? = nil) -> RequestParameter {
    debugLog("Req Url is: \(url)")
    return RequestParameter(url: url, method: method, headers: headers, parameters: parameters)
  }
}
