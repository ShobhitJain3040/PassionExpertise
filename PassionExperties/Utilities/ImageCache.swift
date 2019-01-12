

import Foundation
import UIKit
import Alamofire

public typealias ImageCacheSuccessClosure = (_ image: UIImage?) -> (Void)
public typealias ImageCacheFailureClosure = (_ error: Error) -> (Void)

/// Caches the images
open class ImageCache {
  /// Url of the image
  public let imageUrl: String!
  
  /// Request for cloud image if not present in disk. Will be non nil only when `downloadImage` function is called
  open var request: DataRequest?
  
  /// File path with MD5 has name, used internally
  fileprivate var md5HashFilePath: String
  
  /// Public initializer
  ///
  ///
  /// - parameters:
  ///   - imageUrl: Url of the image
  public init(imageUrl: String) {
    self.imageUrl = imageUrl
    self.md5HashFilePath = ImageCache.getMD5HashFilePath(imageUrl)
  }
  
  /// This gives the image from the cache
  ///
  ///
  /// - returns: Image or nil if not present on disk/not able to convert data into image
  open  func getImageFromCache() -> UIImage? {
    if FileManager.default.fileExists(atPath: self.md5HashFilePath) {
      return UIImage(contentsOfFile: md5HashFilePath)
    }
    else {
      return nil
    }
  }
  
  /// Checks if the file is present on the disk
  ///
  ///
  /// - returns: true/false
  open func doesImageExist() -> Bool {
    return FileManager.default.fileExists(atPath: self.md5HashFilePath)
  }
  
  /// Download the image from the server if the image is not present in the disk. If image is on the disc then creates the image from the disc
  /// After downloading the image from the server it saves the image on disc on background thread.
  ///
  ///
  /// - parameters:
  ///   - success: `ImageCacheSuccessClosure`
  ///   - failure: `ImageCacheFailureClosure`
  open func downloadImage(_ success: @escaping ImageCacheSuccessClosure, failure: @escaping ImageCacheFailureClosure) {
    if doesImageExist() {
      // image is present in the disc
      success(UIImage(contentsOfFile: self.md5HashFilePath))
    }
    else {
      // download the image from the cloud
      self.request = Alamofire.request(self.imageUrl, method: .get)
      
      self.request?.responseData(completionHandler: { (dataResponse) in
        if let error = dataResponse.result.error {
          // error could be any of the NSURLErrorDomain like NSURLErrorCannotFindHost
          failure(error)
        }
        else if dataResponse.response?.statusCode == 200 {
          // 200 success
          if let imageData = dataResponse.result.value {
            // save image to the storage, right now I'm saving data on bg thread, if something happnes wrong I'll change it
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
              // background thread
              try? imageData.write(to: URL(fileURLWithPath: self.md5HashFilePath), options: [])
            })
            
            //there is some data
            success(UIImage(data: imageData))
          }
          else {
            // there is no data
            success(nil)
          }
        }
        else {
          // if status code is not 200 (success)
          let error = NSError(domain: "ImageCache", code: (dataResponse.response?.statusCode) ?? 44444, userInfo: ["Reason": "Response code is not 200"])
          failure(error)
        }
      })
    }
  }
  
  
  // MARK: Private methods
  
  /// This gives the file path with MD5 hash name.
  ///
  ///
  /// - parameters:
  ///   - imageName: Name/URL of the image as `String` parameter.
  /// - returns: The MD5 hash co
  fileprivate static func getMD5HashFilePath(_ url: String) -> String {
    let md5HashName = CryptoUtil.md5Hash(url)
    return ImageCache.getImageCacheDirectory() + "/" + md5HashName
  }
  
  /// This gives the Application support directory path
  ///
  ///
  /// - returns: Application support directory path.
  fileprivate static func getApplicationSupportDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
    return paths.first!
  }
  
  /// This gives the image cache directory path
  ///
  ///
  /// - returns: Application support directory path.
  public static func getImageCacheDirectory() -> String {
    // trying to give the unique directory name so that no other developer tries to create the same dircrectory
    // let's hope that this is unique
    let imageCacheDirectory = ImageCache.getApplicationSupportDirectory() + "/RImageCacheXZEGBV"
    if !FileManager.default.fileExists(atPath: imageCacheDirectory) {
      do {
        try FileManager.default.createDirectory(atPath: imageCacheDirectory, withIntermediateDirectories: true, attributes: nil)
      }
      catch {
        print("Couldn't create directory")
      }
    }
    return imageCacheDirectory
  }
}

