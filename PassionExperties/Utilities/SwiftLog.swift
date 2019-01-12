

import Foundation

/// Logs the message to the console with extra information, e.g. file name, method name and line number
///
/// To make it work you must set the "DEBUG" symbol, set it in the "Swift Compiler - Custom Flags" section, "Other Swift Flags" line.
/// You add the DEBUG symbol with the -D DEBUG entry.
public func debugLog(_ object: Any?, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
  #if DEBUG
    let className = (fileName as NSString).lastPathComponent
    if let object = object {
      print("<\(className)> \(functionName) [#\(lineNumber)]| \(String(describing: object))\n")
    }
  #endif
}
