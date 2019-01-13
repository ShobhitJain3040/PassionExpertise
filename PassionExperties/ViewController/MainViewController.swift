//
//  LogInViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

enum UserType: String {
  case Dreamer = "Dreamer"
  case Consultant = "consultant"
}

enum ConsultantType: String {
  case Free = "Free"
  case Premium = "Premium"
  case Gold = "Gold"
}

class MainViewController: UIViewController {

  @IBOutlet weak var consultantButton: UIButton!
  @IBOutlet weak var dremarButton: UIButton!
  @IBOutlet weak var letStart: GradientButton!
  var currentUser: UserType?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.letStart.layer.cornerRadius = 10
      self.dremarButton.sendActions(for: .touchUpInside)
    }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: false)
  }

  @IBAction func pressDremarButton(_ sender: Any) {
    UserDefaults.standard.set(UserType.Dreamer.rawValue, forKey: "Type")
    self.dremarButton.setImage(UIImage(named: "dreamerIconSelected"), for: .normal)
    self.consultantButton.setImage(UIImage(named: "consultantIcon"), for: .normal)
  }
  
  @IBAction func pressConsultantButton(_ sender: Any) {
    UserDefaults.standard.set(UserType.Consultant.rawValue, forKey: "Type")
    self.consultantButton.setImage(UIImage(named: "consultantIconSelected"), for: .normal)
    self.dremarButton.setImage(UIImage(named: "dreamerIcon"), for: .normal)
  }
 
  
  @IBAction func pressStart(_ sender: Any) {
    self.performSegue(withIdentifier: "login", sender: nil)
  }
  
//   func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//    // Create a new variable to store the instance of PlayerTableViewController
//    let loginConsultantViewController = segue.destination as? LoginConsultantViewController
//    loginConsultantViewController?.currentUser = self.currentUser
//  }
}


