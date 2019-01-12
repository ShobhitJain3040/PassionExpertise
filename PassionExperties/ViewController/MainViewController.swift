//
//  LogInViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  
  @IBOutlet weak var consultantButton: UIButton!
  @IBOutlet weak var dremarButton: UIButton!
  @IBOutlet weak var letStart: GradientButton!

  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.letStart.layer.cornerRadius = 10
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
    self.dremarButton.setImage(UIImage(named: "dreamerIconSelected"), for: .normal)
    self.consultantButton.setImage(UIImage(named: "consultantIcon"), for: .normal)
  }
  
  @IBAction func pressConsultantButton(_ sender: Any) {
    self.consultantButton.setImage(UIImage(named: "consultantIconSelected"), for: .normal)
    self.dremarButton.setImage(UIImage(named: "dreamerIcon"), for: .normal)
    
  }
  
}
