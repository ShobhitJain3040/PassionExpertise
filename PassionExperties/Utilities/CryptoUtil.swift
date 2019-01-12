

import Foundation



open class CryptoUtil {
  
  /// This gives the MD5 hash code for a name/url
  ///
  ///
  /// - parameters:
  ///   - imageName: Name/URL of the image as `String` parameter.
  /// - returns: The MD5 hash code.
  public static func md5Hash(_ imageName: String) -> String {
    // get the c string
    let str = imageName.cString(using: String.Encoding.utf8)
    // create md5 hash
    let strLen = CC_LONG(imageName.lengthOfBytes(using: String.Encoding.utf8))
    let digestLength = Int(CC_MD5_DIGEST_LENGTH)
    
    // allocate the result memory. don't forget to release it after use
    let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLength)
    
    // use md5 hash algorithm
    CC_MD5(str!, strLen, result)
    
    // convert into hexa decimal string
    let hash = NSMutableString()
    for i in 0..<digestLength {
      hash.appendFormat("%02x", result[i])
    }
    
    // release the allocated result
    result.deallocate(capacity: digestLength)
    
    return String(format: hash as String)
  }
}
