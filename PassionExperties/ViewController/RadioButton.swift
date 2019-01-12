//
//  RadioButton.swift
//  PassionExperties
//
//  Created by Shobhit Jain on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import Foundation

class RadioButton: UIButton {
  var alternateButton:Array<RadioButton>?
  
  override func awakeFromNib() {
    self.backgroundColor = UIColor.clear
    self.layer.cornerRadius = 5
    self.layer.borderWidth = 2.0
    self.layer.masksToBounds = true
  }
  
  func unselectAlternateButtons(){
    if alternateButton != nil {
      self.isSelected = true
      
      for aButton:RadioButton in alternateButton! {
        aButton.isSelected = false
      }
    }else{
      toggleButton()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    unselectAlternateButtons()
    super.touchesBegan(touches, with: event)
  }
  
  func toggleButton(){
    self.isSelected = !isSelected
  }
  
  override var isSelected: Bool {
    didSet {
      if isSelected {
        self.layer.borderColor = UIColor.red.cgColor
      } else {
        self.layer.borderColor = UIColor.lightGray.cgColor
      }
    }
  }
}
