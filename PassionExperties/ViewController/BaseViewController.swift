//
//  BaseViewController.swift
//  Junaid-perfumes-ios
//
//  Created by shalu tyagi on 18/11/18.
//  Copyright © 2018 shalu tyagi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

  var internetNotAvailable: InternetNotAvailable?
  var progressHud: ProgressHud!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if self.navigationController != nil {
      var isProgressAlreadyPresent = false
      for subView in self.navigationController!.view.subviews {
        if (subView as? ProgressHud) != nil {
          self.progressHud = subView as! ProgressHud
          isProgressAlreadyPresent = true
        }
      }
      if isProgressAlreadyPresent != true {
        self.progressHud = ProgressHud(frame: self.navigationController!.view.frame, onView: self.navigationController!.view)
      }
    } else {
      self.progressHud = ProgressHud(frame: self.view.frame, onView: self.view)
    }
  }
  
  /// call this func to add InternetNotAvailable to your view
  func addInternetNotAvailable(view: UIView? = nil) {
    //  load internet not availableview
    
    self.internetNotAvailable = Bundle.main.loadNibNamed("InternetNotAvailable", owner: self, options: nil)?[0] as? InternetNotAvailable
    
    //add target
    self.internetNotAvailable!.retryBtn.addTarget(self, action: #selector(self.retryBtnClicked(_:)), for: .touchUpInside)
    
    //adding internet not avilable view as subview
    if view != nil {
      self.internetNotAvailable!.frame = (view?.bounds)!
      view?.addSubview(internetNotAvailable!)
    } else {
      self.internetNotAvailable!.frame = self.view.bounds
      self.view.addSubview(internetNotAvailable!)
    }
  }
  
  /// retry button action
  /// override this metod in your class for realod data.
  @objc func retryBtnClicked(_ sender: AnyObject) {
    
  }
  
  ///remove InternetNotAvailable view
  func removeInternetNotAvailable() {
    self.internetNotAvailable?.removeFromSuperview()
  }

}
