

import Foundation
import UIKit

class AppRecord: NSObject {
  var imageURLString: String?
  var appIcon: UIImage?
  var defaultPlaceHolderImage: UIImage?
  var counter  = 0
  
  override init() {
    self.appIcon = nil
    self.imageURLString = nil
    self.defaultPlaceHolderImage = nil
  }

}
