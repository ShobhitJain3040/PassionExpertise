//
//  DreamerFollowersViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

class DreamerFollowersViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

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
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DreamerFollowerListCell", for: indexPath) as! DreamerFollowerListCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 130
  }

}
