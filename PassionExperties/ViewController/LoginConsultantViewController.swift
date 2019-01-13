//
//  LoginConsultantViewController.swift
//  PassionExperties
//
//  Created by Shobhit Jain on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class LoginConsultantViewController: BaseViewController, UITextFieldDelegate {
  
  @IBOutlet weak var loginButton: GradientButton!
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  var currentUser: UserType?
  
  var activeTextField: UITextField? = nil
  var offsetY:CGFloat = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.loginButton.layer.cornerRadius = 10
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    self.view.addGestureRecognizer(tap)
    self.userNameTextField.delegate = self
    self.passwordTextField.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func keyboardFrameChangeNotification(notification: Notification) {
    if let userInfo = notification.userInfo {
      let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
      let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
      let animationCurveRawValue = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int) ?? Int(UIView.AnimationOptions.curveEaseInOut.rawValue)
      let animationCurve = UIView.AnimationOptions(rawValue: UInt(animationCurveRawValue))
      if let textField = self.activeTextField {
        if let _ = endFrame, endFrame!.intersects(textField.frame) {
          self.offsetY = textField.frame.maxY - endFrame!.minY
          UIView.animate(withDuration: animationDuration, delay: TimeInterval(0), options: animationCurve, animations: {
            textField.frame.origin.y = textField.frame.origin.y - self.offsetY
          }, completion: nil)
        } else {
          if self.offsetY != 0 {
            UIView.animate(withDuration: animationDuration, delay: TimeInterval(0), options: animationCurve, animations: {
              textField.frame.origin.y = textField.frame.origin.y + self.offsetY
              self.offsetY = 0
            }, completion: nil)
          }
        }
      }
    }
  }
  
  @objc func dismissKeyboard() {
    self.view.endEditing(true)
  }
  
  
  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    // Create a new variable to store the instance of PlayerTableViewController
    let consultantSignUpViewController = segue.destination as? ConsultantSignUpViewController
    consultantSignUpViewController?.currentUser = self.currentUser
  }
  
  @IBAction func onLoginButtonAction(_ sender: Any) {
    if  !InternetManager.sharedInstance.isReachable {
      Utilities.showAlertForMessage(message: "Please check your internet connection", vc: self)
    } else {
    if let userName = self.userNameTextField.text, let password = self.passwordTextField.text {
      self.progressHud.showHud()
      Auth.auth().signIn(withEmail: userName, password: password) { (authDataResult, error) in
        if error != nil {
          print("Error login in = \(error)")
          self.progressHud.hideHud()
          Utilities.showAlertForMessage(message: "FailedLogin", vc: self)
          return
        }
        self.progressHud.hideHud()
        print("Login in success")
        DispatchQueue.main.async {
          let user = UserType(rawValue: UserDefaults.standard.value(forKey: "Type") as! String)
          if user == .Dreamer {
            Utilities.getAppDelegate().replaceStoryboard("DreamerStoryboard")
          } else {
            Utilities.getAppDelegate().replaceStoryboard("Consultant")
          }
        }
        
      }
    } else {
      Utilities.showAlertForMessage(message: "Please fill the userName/Password", vc: self)
      }
  }
  }
  
  @IBAction func onSignUpButtonAction(_ sender: Any) {
    self.performSegue(withIdentifier: "signup", sender: nil)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.activeTextField = textField
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    self.activeTextField = nil
  }
}
