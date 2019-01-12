//
//  ConsultantSignUpViewController.swift
//  PassionExperties
//
//  Created by Shobhit Jain on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

class ConsultantSignUpViewController: UIViewController, UITextFieldDelegate {
  let datePicker = UIDatePicker()
  var activeTextField: UITextField? = nil
  var offsetY:CGFloat = 0
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var dobTextField: UITextField!
  @IBOutlet weak var phoneNumberTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var maleButton: RadioButton!
  @IBOutlet weak var femaleButton: RadioButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    self.title = "Dashboard"
    self.confirmPasswordTextField.delegate = self
    self.passwordTextField.delegate = self
    self.dobTextField.delegate = self
    self.phoneNumberTextField.delegate = self
    self.emailTextField.delegate = self
    self.nameTextField.delegate = self
    maleButton.isSelected = true
    femaleButton.isSelected = false
    maleButton.alternateButton = [femaleButton]
    femaleButton.alternateButton = [maleButton]
  }
  
  @IBAction func onMaleButtonSelected(_ sender: Any) {
  }
  
  @objc func dismissKeyboard() {
    self.view.endEditing(true)
  }
  
  @IBAction func onFemaleButtonSelected(_ sender: Any) {
  }
  
  @IBAction func onSignUp(_ sender: Any) {
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
}
