

import Alamofire

public typealias SuccessClosure = (_ data: Data?) -> (Void)
public typealias FailureClosure = (_ error: Error?, _ data: Data?, _ statusCode: Int?) -> (Void)

open class NetworkManager {
  
  /// Makes the request.
  ///
  ///
  /// - parameters:
  ///   - requestParamter: `RequestParameter` parameter.
  ///   - success: success closure `SuccessClosure` parameter.
  ///   - failure: failure closure as `FailureClosure` parameter.
  /// - returns: `Request` object.
  public static func makeRequest(_ requestParamter: RequestParameter, success: @escaping SuccessClosure, failure: @escaping FailureClosure) -> Request {
    
    debugLog("Req URL : \(requestParamter.url)")
    //create the request
    let request = Alamofire.request(requestParamter.url, method: requestParamter.method, parameters: requestParamter.parameters, headers: requestParamter.headers)
    
    //get the response
    request.responseData { (dataResponse) in
      // Do conversion of data to json and the "data" parsing in background thread
      // Just to make UI thread more free form these kind of jobs.
      // for debuggin only since we don't want this computation for release/production
      #if DEBUG
      if let data = dataResponse.result.value {
        if let responseString = String(data: data, encoding: .utf8) {
          debugLog("Response string:\(responseString)")
        }
        else {
          debugLog("Response string is null")
        }
      }
      #endif
      
      if let error = dataResponse.result.error {
        // error could be any of the NSURLErrorDomain like NSURLErrorCannotFindHost
        debugLog(error)
        failure(error, dataResponse.result.value, nil)
      }
        //HTTP Status Code Return 200 For Making SuccessFull Connection
        //We Also Need To Check Server Response Status Code
        //Exp: {"status":"error","code":400,"data":"","message":"Invalid Request - Empty Job Id"}
        //We Need To Do This Things By Parsing Server Response
        //Success And Failure Are Dicided By Response Status
      else if dataResponse.response?.statusCode == 200 {
        //Check Block Data Url
          // Do what you need to with JSON here!
          // 200 success
          success(dataResponse.result.value)
      }
      else {
        // if status code is not 200 (success)
        failure(nil, dataResponse.result.value, dataResponse.response?.statusCode)
      }
    }
    debugLog("Request url :\(request)")
    return request
  }
  
  /// upload file
  ///
  ///
  /// - parameters:
  ///   - requestParamter: RequestParameter parameter.
  ///   - fileParameter: fileParameter as Dictionary.
  ///   - success: success closure SuccessClosure parameter.
  ///   - failure: failure closure as FailureClosure parameter.
  public static func upload(_ requestParamter: RequestParameter, fileParameter: [String: (data: Data, fileName: String, fileType: String)], success: @escaping SuccessClosure, failure: @escaping FailureClosure) {
    
    do { let url = try URLRequest(url: URL(string: requestParamter.url)!, method: requestParamter.method, headers: requestParamter.headers)
      
      Alamofire.upload(multipartFormData: { multipartFormData in
        
        // append multiple file data.
        for (key,value) in fileParameter {
          multipartFormData.append(value.data, withName: key, fileName: value.fileName, mimeType: value.fileType)
        }
        
        // append data  in multipartFormData
        if let parameters = requestParamter.parameters {
          for (key, value) in parameters {
            multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
          }
        }
      }, with: url, encodingCompletion:  {
        encodingResult in
        
        debugLog(encodingResult)
        switch encodingResult {
        case .success(let upload, _, _):
          
          upload.responseData { (dataResponse) in
            // for debuggin only since we don't want this computation for release/production
            #if DEBUG
            if let data = dataResponse.result.value {
              let responseString = String(data: data, encoding: .utf8)
              if responseString != nil {
                debugLog("Response string:\(responseString!)")
              }
              else {
                debugLog("Response string is null")
              }
            }
            #endif
            
            if let error = dataResponse.result.error {
              // error could be any of the NSURLErrorDomain like NSURLErrorCannotFindHost
              debugLog(error)
              failure(error, dataResponse.result.value, nil)
            }
            else if dataResponse.response?.statusCode == 200 {
              // 200 success
              success(dataResponse.result.value)
            }
            else {
              // if status code is not 200 (success)
              failure(nil, dataResponse.result.value, dataResponse.response?.statusCode)
            }
          }
        case .failure( _):
          //TODO : failure
          failure(nil, nil, 0)
        }
      })
      
    } catch {
      // error handled
      // do something with error.
    }
  }
}
