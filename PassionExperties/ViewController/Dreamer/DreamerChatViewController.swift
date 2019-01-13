//
//  DreamerChatViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DreamerChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var tableView: UITableView?
  var userInfo = [String: String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let button = UIBarButtonItem(image: UIImage(named: "editProfileIcon"), style: .plain, target: self, action: #selector(onAllChat))
    self.navigationItem.rightBarButtonItem = button
    tableView = UITableView()
    self.view.addSubview(tableView!)
    
    tableView?.dataSource = self
    tableView?.delegate = self
    if let id = Auth.auth().currentUser?.uid {
      Database.database().reference().child(UserDefaults.standard.value(forKey: "Type") as! String).child(id).observe(.value) { (snapshot) in
        print(snapshot)
        self.userInfo = snapshot.value as? [String: String] ?? [String: String]()
        self.title = self.userInfo["name"]
      }
    }
  }
  
  @objc func onAllChat() {
    self.performSegue(withIdentifier: "allchats", sender: nil)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
