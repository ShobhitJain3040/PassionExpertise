

import UIKit

class IconDownloader: NSObject, NSURLConnectionDataDelegate {
  
  var appRecord: AppRecord
  private var sessionTask: URLSessionDataTask?
  var completionHandler: (() -> Void)?
  
  override init() {
    
    self.appRecord = AppRecord()
  }
  
  //MARK: -
  
  // -------------------------------------------------------------------------------
  //	startDownload
  // -------------------------------------------------------------------------------
  
  func startDownload() {
    if let imageUrl =  self.appRecord.imageURLString {
      let request: URLRequest = URLRequest(url: URL(string: imageUrl)!)
      
      // create an session data task to obtain and download the app icon
      sessionTask = URLSession.shared.dataTask(with: request, completionHandler: {
        data, response, error in
        
        // in case we want to know the response status code
        //let httpStatusCode = (response as! HTTPURLResponse).statusCode
        
        if let actualError = error as NSError? {
          debugLog(actualError)
        }
        
        if let data = data {
          // Set appIcon and clear temporary data/image
          if let image = UIImage(data: data) {
            self.appRecord.appIcon = image
            //call our completion handler to tell our client that our icon is ready for display
            self.completionHandler?()
          }
        }
      })
      self.sessionTask?.resume()
    }
  }
  
  // -------------------------------------------------------------------------------
  //	cancelDownload
  // -------------------------------------------------------------------------------
  func cancelDownload() {
    self.sessionTask?.cancel()
    sessionTask = nil
  }
}
