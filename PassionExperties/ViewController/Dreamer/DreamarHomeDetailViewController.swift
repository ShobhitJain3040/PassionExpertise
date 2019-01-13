//
//  DreamarHomeDetailViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 13/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

class DreamarHomeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DreamerFollowerListCell", for: indexPath) as! DreamerFollowerListCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }

  
}
