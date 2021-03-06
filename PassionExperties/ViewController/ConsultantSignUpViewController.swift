//
//  ConsultantSignUpViewController.swift
//  PassionExperties
//
//  Created by Shobhit Jain on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ConsultantSignUpViewController: BaseViewController, UITextFieldDelegate {
  let datePicker = UIDatePicker()
  var activeTextField: UITextField? = nil
  var offsetY:CGFloat = 0
  var currentUser: UserType?
  
  @IBOutlet weak var genderTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var dobTextField: UITextField!
  @IBOutlet weak var phoneNumberTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    self.title = "Dashboard"
    self.passwordTextField.delegate = self
    self.dobTextField.delegate = self
    self.phoneNumberTextField.delegate = self
    self.emailTextField.delegate = self
    self.nameTextField.delegate = self
  }
  
  
  @objc func dismissKeyboard() {
    self.view.endEditing(true)
  }

  
  @IBAction func onSignUp(_ sender: Any) {
    guard validate()else{return}
    
    if  !InternetManager.sharedInstance.isReachable {
      Utilities.showAlertForMessage(message: "Please check your internet connection", vc: self)
    } else {
    let ref = Database.database().reference()
    if let email = self.emailTextField.text, let password = self.passwordTextField.text {
      self.progressHud.showHud()
      Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
        if error != nil {
          print("Error = \(error)")
          self.progressHud.hideHud()
          Utilities.showAlertForMessage(message: "Failed", vc: self)
          return
        }
        guard let uid = user?.user.uid else {
          self.progressHud.hideHud()
          Utilities.showAlertForMessage(message: " Yor are already exit", vc: self)
          return
        }
        let user = UserType(rawValue: UserDefaults.standard.value(forKey: "Type") as! String)
        let consultantRef = Database.database().reference().child(user!.rawValue).child(uid)
        let values: [String: String] = ["name": self.nameTextField.text ?? "defaultName", "dob": self.dobTextField.text ?? "defaultdob", "mobile": self.phoneNumberTextField.text ?? "defaultmobile", "gender": self.genderTextField.text ?? "defaultGender"]
        consultantRef.updateChildValues(values)
        self.progressHud.hideHud()
        self.dismiss(animated: true, completion: nil)
      }
    } else {
      Utilities.showAlertForMessage(message: "Please fill all field", vc: self)
      }
    }
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.activeTextField = textField
    if textField == self.dobTextField {
      self.showDatePicker(textField: textField)
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    self.activeTextField = nil
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
  
  func showDatePicker(textField: UITextField) {
    //Formate Date
    datePicker.datePickerMode = .date
    
    //ToolBar
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    //done button & cancel button
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneDatePicker))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker))
    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    
    // add toolbar to textField
    textField.inputAccessoryView = toolbar
    // add datepicker to textField
    textField.inputView = datePicker
  }
  
  @objc func doneDatePicker() {
    //For date formate
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    self.activeTextField?.text = formatter.string(from: datePicker.date)
    //dismiss date picker dialog
    self.view.endEditing(true)
  }
  
  @objc func cancelDatePicker(){
    //cancel button dismiss datepicker dialog
    self.view.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func validate()-> Bool{
    
    //add any condtion specific to element
    guard let name = nameTextField.text , !name.isEmpty else {return false}
    
    guard let email = emailTextField.text, !email.isEmpty, email.contains("@"), email.contains(".") else{return false}
    
    guard let phone = phoneNumberTextField.text, !phone.isEmpty else {return false}
    
    guard let dob = dobTextField.text, !dob.isEmpty else {return false}
    
    guard let gender = genderTextField.text, !gender.isEmpty else{return false}
    
    guard let password = passwordTextField.text, !password.isEmpty else{
      return false
    }
    
    return true
  }
  
  @IBAction func loginClicked(_ sender: UIButton) {
    self.resignFirstResponder()
    self.dismiss(animated: true, completion: nil)
  }
}
