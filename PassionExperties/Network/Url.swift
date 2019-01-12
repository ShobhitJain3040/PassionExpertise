

import Foundation

open class Url {
  // Host of our application
  
  #if PRODUCTION //production
  private static let host = ""
  #else
  public static let host = ""
  #endif
  
  public static let endUrl = host  + "/api"
  
  // login/authenticate call
  public static let loginUrl = endUrl + Endpoint.login
  public static let registerUrl = endUrl + Endpoint.register
  
  open class Endpoint {
    fileprivate static let login = ""
    fileprivate static let register = ""
  }
}
