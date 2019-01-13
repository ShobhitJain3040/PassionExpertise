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

class ConsultantDashboardViewController: BaseViewController, UITextFieldDelegate {

  @IBOutlet weak var qualification: UITextField!
  @IBOutlet weak var expertIn: UITextField!
  @IBOutlet weak var achivements: UITextField!
  @IBOutlet weak var experience: UITextField!
  @IBOutlet weak var fee: UITextField!
  @IBOutlet weak var numberOfFreeMsg: UITextField!
  @IBOutlet weak var catogery: UITextField!
  @IBOutlet weak var doneButton: GradientButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    self.view.addGestureRecognizer(tap)
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
  }

