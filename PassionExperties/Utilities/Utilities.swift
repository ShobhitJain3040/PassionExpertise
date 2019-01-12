

import Foundation
import UIKit
import CoreData
import MBProgressHUD

class Utilities {
  
  
  /// Use this method to load a nib using the nibname.
  ///
  ///
  /// - parameters:
  ///   - nibnamed: name of the nib file
  ///   - bundle: the bundle
  /// - returns: the loaded view from nib
  static func loadFromNibNamed(_ nibNamed: String, bundle: Bundle? = nil, owner: AnyObject? = nil) -> UIView? {
    return UINib(nibName: nibNamed, bundle: bundle)
      .instantiate(withOwner: owner, options: nil)[0] as? UIView
  }
  
  /// Use this method to get Application delegate.
  ///
  ///
  /// - returns: Application Delegate
  static func getAppDelegate() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
  
  /// Use this method to get Application Managaed Context.
  ///
  ///
  /// - returns: `NSManagedObjectContext` for Application
  static func getAppManagedContext() -> NSManagedObjectContext {
    return getAppDelegate().managedObjectContext
  }
  
  /// Save current user in database
  public static func saveContext() throws {
    try Utilities.getAppManagedContext().save()
  }
  
  
  // MARK: Constraint convenience methods
  
  /// Adds the contraint to the view
  ///
  ///
  /// - parameters:
  ///   - newView: view on which contraint is added.
  ///   - toView: view with which contraint is defined.
  ///   - relation: relation Leading/Top/Bottom/Trailing.
  ///   - constant: amount of constant.
  @discardableResult
  static func addConstraint(_ newView: UIView, toView: UIView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat)-> NSLayoutConstraint {
    let constraint =  NSLayoutConstraint(item: newView, attribute: attribute, relatedBy: .equal, toItem: toView, attribute: attribute, multiplier: 1.0, constant: constant)
    toView.addConstraint(constraint)
    return constraint
  }
  
  /// Adds the constant width contraint to the view
  ///
  ///
  /// - parameters:
  ///   - newView: view on which contraint is added.
  ///   - constant: amount of constant.
  static func addConstantWidthConstraint(_ newView: UIView, constant: CGFloat)-> NSLayoutConstraint {
    let constraint =  NSLayoutConstraint(item: newView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
    newView.addConstraint(constraint)
    return constraint
  }
  
  /// Adds the constant height contraint to the view
  ///
  ///
  /// - parameters:
  ///   - newView: view on which contraint is added.
  ///   - constant: amount of constant.
  @discardableResult
  static func addConstantHeightConstraint(_ newView: UIView, constant: CGFloat)->NSLayoutConstraint {
    let constraint =  NSLayoutConstraint(item: newView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
    newView.addConstraint(constraint)
    return constraint
  }
  
  
  
  /// return the height of a label
  ///
  ///
  /// - parameters:
  ///  - label
  
  static func heightOfLabel(_ label: UILabel?) -> CGFloat {
    label?.sizeToFit()
    return label?.frame.height ?? 0
  }
  
  
  static func heightForLabel(_ text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    return label.frame.height
  }

  static func heightForLabel(_ text: NSAttributedString, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.attributedText = text
    label.sizeToFit()
    return label.frame.height
  }

  
  ///validate Registration/Login Fields
  ///
  ///
  /// - parameters:
  ///  - emailID: emailString as 'String'.
  ///  - countryCode: countryCode as 'String'.
  ///  - mobileNumber: mobileNumber as 'String'.
  ///  - isLoginFields: isLoginFields as 'Bool'.
  ///  - password: password as 'String'.
  static func isRegistrationFieldsValid(firstName: String?, lastName: String?, emailID: String?, mobileNumber: String?, DOB: String?, employeeCode: String?, password: String?, confirmPassword: String?, store: String?, country: String?, DOJ: String?) -> (success: Bool, message: String) {
    if firstName == nil || firstName == "" {
      return (false,"Please enter your first name")
    } else if lastName == nil || lastName == "" {
      return (false,"Please enter your last name")
    } else if emailID == nil || emailID == "" {
      return (false,"Please enter your email id")
    } else if mobileNumber == nil || mobileNumber == "" {
      return (false,"Please enter your mobile number")
    } else if DOB == nil || DOB == "" {
      return (false,"Please enter your date of birth")
    } else if employeeCode == nil || employeeCode == "" {
      return (false,"Please enter your salesmanCode")
    } else if password == nil || password == "" {
      return (false,"Please enter password")
    } else if confirmPassword == nil || confirmPassword == "" {
      return (false,"Please enter confirm Password")
    } else if store == nil || store == "" {
      return (false,"Please select store")
    } else if country == nil || country == "" {
      return (false,"Please select country")
    } else if DOJ == nil || DOJ == "" {
      return (false,"Please enter your date of joining")
    } else if emailID!.characters.count > 0 {
      let isvalid = isValidEmail(emailID!)
      if !isvalid {
        return (false, "Your entered email id should be correct")
      }
    } else  if mobileNumber!.characters.count > 0 {
      if mobileNumber!.characters.count < 10 {
        return (false,"Your entered mobile number should be 10 digits")
      }
      else {
        let isvalid = validateMobileNumber(mobileNumber!)
        if !isvalid {
          return (false,"Your entered mobile number should be correct")
        }
      }
    } else if password != confirmPassword {
      return (false, "password and confirm password is not same")
    }
    
    return (true, "")
  }
  
  
  ///validate Registration/Login Fields
  ///
  ///
  /// - parameters:
  ///  - code: emailString as 'String'.
  ///  - password: countryCode as 'String'.
  static func isLoginFieldsValid(code: String?, password:String?) -> (success: Bool, message: String?) {
    
    if let code = code, let password = password, code.characters.count > 0 && password.characters.count > 0 {
        return (true, nil)
    } else {
      return (false, "Employee code & password can't be blank")
    }
  }
  
  
  /// emailRegEx
  ///
  ///
  /// - parameters:
  ///  - emailString:String
  /// - return -> 'true' or 'false'
  static func isValidEmail(_ emailString:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: emailString)
    return result
  }
  
  /// validate Mobile Number
  ///
  ///
  /// - parameters:
  ///  - number: String
  /// - return -> 'true' or 'false'
  static func validateMobileNumber(_ number: String) -> Bool {
    let phoneRegex = "[789][0-9]{9}"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    let result =  phoneTest.evaluate(with: number)
    return result
  }
  
  
  static func timeStamp()-> String   {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm"
    let someDateTime = formatter.string(from: date)
    return someDateTime
    
  }
  
  static func logTimeStamp()-> String {
    return (Date().timeIntervalSince1970*1000).description
  }
  
  /// show AlertController
  ///
  ///
  /// - parameters:
  ///  - title:String
  ///  - message:String
  static func showAlertForMessage(title:String? = "", message:String, vc: UIViewController) {
    let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
      
    }
    alertController.addAction(cancelAction)
    vc.present(alertController, animated: true)
  }
  
  /// show ActionSheet
  ///
  ///
  /// - parameters:
  ///  - title: title as String?
  ///  - message: message as String?
  ///  - firstAction: firstAction as UIAlertAction?
  ///  - secondAction: secondAction as UIAlertAction?
  static func showActionSheet(_ title:String? = "", message: String, firstAction: UIAlertAction? = nil , secondAction: UIAlertAction? = nil, thirdAction: UIAlertAction? = nil, forthAction: UIAlertAction? = nil, cancelAction: UIAlertAction? = nil)  {
    
    let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
    
    if let firstAction = firstAction {
      actionSheet.addAction(firstAction)
    }
    
    if let secondAction = secondAction {
      actionSheet.addAction(secondAction)
    }
    
    if let thirdAction = thirdAction {
      actionSheet.addAction(thirdAction)
      
    }
    
    if let forthAction = forthAction {
      actionSheet.addAction(forthAction)
      
    }
    let cancelActionToAdd : UIAlertAction
    if cancelAction != nil {
      cancelActionToAdd = cancelAction!
    } else {
      cancelActionToAdd = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (action) in
      }
    }
    actionSheet.addAction(cancelActionToAdd)
    
    OperationQueue.main.addOperation {
      UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true) {
      }
    }
  }
  
  static func getVisibleViewControllerFrom(_ vc: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nc = vc as? UINavigationController {
      return self.getVisibleViewControllerFrom(nc.visibleViewController)
    } else if let tc = vc as? UITabBarController {
      return self.getVisibleViewControllerFrom(tc.selectedViewController)
    } else {
      if let pvc = vc?.presentedViewController {
        return self.getVisibleViewControllerFrom(pvc)
      } else {
        return vc
      }
    }
  }
  
  //show toast on screen with msg
  static func showToast(_ message: String) {
    let rootVC = UIApplication.shared.keyWindow?.rootViewController
    let rootView =  getVisibleViewControllerFrom(rootVC)?.view
    let toast = MBProgressHUD(frame: rootView!.frame)
    toast.mode = .text
    toast.label.text = message
    toast.removeFromSuperViewOnHide = true
    rootView?.addSubview(toast)
    rootView?.bringSubviewToFront(toast)
    toast.show(animated: true)
    toast.hide(animated: true, afterDelay: 2)
    toast.isUserInteractionEnabled = false
  }
}
