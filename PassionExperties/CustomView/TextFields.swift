//
//  TextFields.swift
//  PassionExperties
//
//  Created by Ankur Sharma on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit
import DTGradientButton

protocol Round:class{}

extension Round where Self: UIView{
  func round(){
    let layer = self.layer
    layer.cornerRadius = layer.bounds.size.height / 2.0
    
    self.clipsToBounds = true
  }
}


class RoundedTextFields: UITextField, Round {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    initialise()
  }
  
  func initialise(){
    self.round()
    self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    self.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    
  }
}



class CustomText: RoundedTextFields, UITextFieldDelegate{
  let BGColor = UIColor.groupTableViewBackground
  let filledBGColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  let selectedShadowColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
  let deSelectedFilledShadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
  let noShadowColor = UIColor.clear
  
  
  var bgColor: UIColor!
  var shadowColor: UIColor!
  override func initialise() {

    self.bgColor = BGColor
    self.shadowColor = noShadowColor

    self.updateShadow()
    self.delegate = self
  }
  
  
  func updateShadow(){
    //Basic texfield Setup
    borderStyle = .none
    backgroundColor = bgColor // Use anycolor that give you a 2d look.
    
    //To apply corner radius
    layer.cornerRadius = frame.size.height / 2
    
    //To apply border
//    layer.borderWidth = 0.25
//    layer.borderColor = UIColor.white.cgColor
    
    //To apply Shadow
    layer.shadowOpacity = 1
    layer.shadowRadius = 3.0
    layer.shadowOffset = CGSize.zero // Use any CGSize
    layer.shadowColor = shadowColor.cgColor
    
    //To apply padding
    let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: frame.height))
    leftView = paddingView
    leftViewMode = .always
   }
  
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    self.bgColor = filledBGColor
    self.shadowColor = selectedShadowColor
    self.updateShadow()
    return true
  }
  
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    updateShadowAsPerText()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.resignFirstResponder()
    updateShadowAsPerText()
    return true
  }
  
  
  
  fileprivate func updateShadowAsPerText(){
    if let text = self.text, !text.isEmpty{
      self.shadowColor = deSelectedFilledShadowColor
    }else{
      self.bgColor = BGColor
      self.shadowColor = noShadowColor
    }
    updateShadow()
  }
}


class DOB: CustomText{
  
  let datePicker = UIDatePicker()
  let dateFormatter =  DateFormatter()
  
  var date: Date{
    return datePicker.date
  }
  
  override func initialise() {
    super.initialise()
    
    datePicker.datePickerMode = .date
    datePicker.date = Date()
    datePicker.addTarget(self, action: #selector(self.updateDate), for: .valueChanged)
    
    dateFormatter.dateFormat = "DD/MMM/YYYY"
    
    self.inputAccessoryView = datePicker
  }
  
  @objc func updateDate()  {
    let date  = self.datePicker.date
    let dateStr = self.dateFormatter.string(from: date)
    self.text = dateStr
  }
  
}


enum Gender: String{
  case male = "Male", female = "Female", other = "Not Specified"
}

class GenderText: CustomText{
  var gender = Gender.other {
    didSet{
      self.text = gender.rawValue
      self.updateShadowAsPerText()
    }
  }
  
  func showAction(){
    let alert = UIAlertController(title: "Gender", message: nil, preferredStyle: .actionSheet)
    
    alert.addAction(UIAlertAction(title: "Male", style: .default, handler: { (action) in
      self.gender = .male
    }))
    
    
    alert.addAction(UIAlertAction(title: "Female", style: .default, handler: { (action) in
      self.gender = .female
    }))
    
    
    alert.addAction(UIAlertAction(title: "Other", style: .default, handler: { (action) in
      self.gender = .other
    }))
    
    Utilities.getVisibleViewControllerFrom()?.present(alert, animated: true, completion: nil)
  }
  
  
  override func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    showAction()
    return super.textFieldShouldBeginEditing(textField)
  }
}
