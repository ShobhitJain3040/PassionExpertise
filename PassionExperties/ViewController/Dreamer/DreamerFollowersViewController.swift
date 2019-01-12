//
//  DreamerFollowersViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

class DreamerFollowersViewController: BaseViewController {

  var consultantData: [ConsultentData]?
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  func getConsultantData() {
    if  !InternetManager.sharedInstance.isReachable {
      self.addInternetNotAvailable()
    } else {
      
    }
  }
  
  override func retryBtnClicked(_ sender: AnyObject) {
    if  !InternetManager.sharedInstance.isReachable {
      Utilities.showAlertForMessage(message: "Please check your internet connection", vc: self)
    } else {
      self.removeInternetNotAvailable()
      self.getConsultantData()
    }
  }
  
  
}
