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

class LoginConsultantViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var loginButton: GradientButton!
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
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
  
  @IBAction func onLoginButtonAction(_ sender: Any) {
    if let userName = self.userNameTextField.text, let password = self.passwordTextField.text {
      Auth.auth().signIn(withEmail: userName, password: password) { (authDataResult, error) in
        if error != nil {
          print("Error login in = \(error)")
          return
        }
        
        print("Login in success")
      }
    }
  }
  
  @IBAction func onSignUpButtonAction(_ sender: Any) {
    
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
