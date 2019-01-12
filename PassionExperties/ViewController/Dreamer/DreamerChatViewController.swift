//
//  DreamerChatViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

class DreamerChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var tableView: UITableView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView()
    self.view.addSubview(tableView!)
    
    tableView?.dataSource = self
    tableView?.delegate = self
    // Do any additional setup after loading the view.
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
