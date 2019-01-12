//
//  DreamerSignUpViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

class DreamerSignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      //Looks for single or multiple taps.
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
      self.view.addGestureRecognizer(tap)
  
    }
    
  @objc func dismissKeyboard() {
    self.view.endEditing(true)
  }
 
}
