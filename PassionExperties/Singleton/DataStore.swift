
import UIKit


class DataStore {
  /// Singleton instance
  static let sharedInstance = DataStore()
  /// This prevents others from using the default '()' initializer for this class.
  fileprivate init() {}
  /// API token of the user
  var apiToken: String?
 
}

