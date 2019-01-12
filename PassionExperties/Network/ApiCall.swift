


import Alamofire

open class ApiCall {
  /// Authenticate User.
  ///
  ///
  /// - parameters:
  ///   - employeeCode: employeeCode name as `String?`.
  ///   - password: password as `String`.
  ///   - success: success closure `SuccessClosure` parameter.
  ///   - failure: failure closure as `FailureClosure` parameter.
  /// - returns: `Request` object.
  @discardableResult
  public static func authenticateUser(employeeCode: String, password: String, success: @escaping SuccessClosure, failure: @escaping FailureClosure) -> Request {
    var parameters: [String: String]?
      parameters = ["employee_code": employeeCode, "password": password]
    let requestParameter = RequestParameter.createRequestParameter(Url.loginUrl, method: .post, parameters: parameters)
    return NetworkManager.makeRequest(requestParameter, success: success, failure: failure)
  }
 
  /// RegisterUser User.
  ///
  ///
  /// - parameters:
  ///   - employeeCode: employeeCode name as `String?`.
  ///   - password: password as `String`.
  ///   - success: success closure `SuccessClosure` parameter.
  ///   - failure: failure closure as `FailureClosure` parameter.
  /// - returns: `Request` object.
  @discardableResult
  public static func RegisterUser(first_name: String, last_name: String, email: String, mobile_number: String, dob: String, employee_code: String, doj: String, password: String, country_id: String, store_id: String, success: @escaping SuccessClosure, failure: @escaping FailureClosure) -> Request {
    var parameters: [String: String]?
    parameters = ["first_name": first_name, "last_name": last_name, "email": email, "mobile_number": mobile_number, "dob": dob, "employee_code": employee_code, "doj": doj, "password": password, "country_id": country_id, "store_id": store_id]
    
    let requestParameter = RequestParameter.createRequestParameter(Url.registerUrl, method: .post, headers: nil, parameters: parameters)
    return NetworkManager.makeRequest(requestParameter, success: success, failure: failure)
  }
  
}
