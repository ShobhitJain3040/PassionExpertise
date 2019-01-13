//
//  ConsultantDashboardViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 13/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ConsultantDashboardViewController: BaseViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView.tag == 101 {
      return self.categoryList.count
    } else if pickerView.tag == 102 {
      return self.AllList.count
    }
    return 0
  }
  

  @IBOutlet weak var qualification: UITextField!
  @IBOutlet weak var expertIn: UITextField!
  @IBOutlet weak var achivements: UITextField!
  @IBOutlet weak var experience: UITextField!
  @IBOutlet weak var fee: UITextField!
  @IBOutlet weak var numberOfFreeMsg: UITextField!
  @IBOutlet weak var catogery: UITextField!
  @IBOutlet weak var doneButton: GradientButton!
  
  let expartData = UIPickerView()
  let categoryPicker = UIPickerView()
  var activeTextField: UITextField?
  
  var AllList = ["Cooking", "Knitting", "Quilting", "Hunting", "Bird-watching", "Hiking", "letterboxing", "geocaching", "Antiques", "Decor", "Postcards", "Genealogy", "Scrapbooking", "embroidery", "cross-stitch", "Jewelry making", "Drawing", "painting", "photography", "Pottery", "Dinner or Movie club", "Ballroom dancing", "Volunteering", "Card games", "Horseback riding", "Yoga", "volleyball", "bowling", "soccer", "Jogging", "Jogging", "Foreign language study", "Reading", "Writing", "blogging", "Music", "musical instruments", "theater", "Radio Jocky", "Acting", "Modaling", "Youtuber"]
  
  var categoryList = ["Free", "Premium", "Gold"]
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    self.view.addGestureRecognizer(tap)
    self.categoryPicker.tag = 101
    self.expartData.tag = 102
    self.categoryPicker.delegate = self
    self.categoryPicker.dataSource = self
    self.expartData.delegate = self
    self.expartData.dataSource = self
    self.doneButton.layer.cornerRadius = 10
    
    }
  
  @objc func dismissKeyboard() {
    self.view.endEditing(true)
  }
  

  @IBAction func pressDoneButton(_ sender: Any) {
    if  !InternetManager.sharedInstance.isReachable {
      Utilities.showAlertForMessage(message: "Please check your internet connection", vc: self)
    } else {
      if  self.qualification.text != "" && self.expertIn.text != "" && self.achivements.text != "" && self.experience.text != "" && self.fee.text != "" && self.numberOfFreeMsg.text != "" && self.catogery.text != "" {
        
        self.progressHud.showHud()
        if let uID = Auth.auth().currentUser?.uid {
        let user = UserType(rawValue: UserDefaults.standard.value(forKey: "Type") as! String)
        let consultantRef = Database.database().reference().child(user!.rawValue).child(uID)
        let values: [String: String] = ["qualification": self.qualification.text ?? "defaultQualification", "expartIn": self.expertIn.text ?? "defaultExpartIn", "achivements": self.achivements.text ?? "defaultAchivements", "experience": self.experience.text ?? "defaultExperience", "fee": self.fee.text ?? "defaultFee", "numberOfFreeMsg": self.numberOfFreeMsg.text ?? "defaultNumberOfFreeMsg",  "catogery": self.catogery.text ?? "defaultCatogery", "formFilled": "true"]
          consultantRef.updateChildValues(values)
          self.progressHud.hideHud()
          
          let viewController:UIViewController = UIStoryboard(name: "Consultant", bundle: nil).instantiateViewController(withIdentifier: "ConsultantHomeViewController") as UIViewController

          self.present(viewController, animated: false, completion: nil)
        } else {
          
        }
        
      } else {
        Utilities.showAlertForMessage(message: "Please fill all field", vc: self)
      }
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.activeTextField = textField
    if textField == self.expertIn {
      //self.showExpartPicker(textField: textField)
    } else if textField == self.catogery {
      self.showCategoryPicker(textField: textField)
    }
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView.tag == 101 {
      return self.categoryList[row]
    } else if pickerView.tag == 102 {
      return self.AllList[row]
    }
    return nil
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView.tag == 101 {
      self.catogery.text = self.categoryList[row]
    } else if pickerView.tag == 102 {
      self.expertIn.text = self.AllList[row]
    }
  }
  
  func showExpartPicker(textField: UITextField) {
    //ToolBar
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker))
    toolbar.setItems([spaceButton,cancelButton], animated: false)
    
    // add toolbar to textField
    textField.inputAccessoryView = toolbar
    textField.inputView = self.expertIn
  }
  
  func showCategoryPicker(textField: UITextField) {
    //ToolBar
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker))
    toolbar.setItems([spaceButton,cancelButton], animated: false)
    
    // add toolbar to textField
    textField.inputAccessoryView = toolbar
    //     add datepicker to textField
    textField.inputView = self.categoryPicker
    self.categoryPicker.removeFromSuperview()
    textField.becomeFirstResponder()
  }
  
  
  @objc func cancelDatePicker(){
    //cancel button dismiss datepicker dialog
    self.view.endEditing(true)
  }
  
  }

