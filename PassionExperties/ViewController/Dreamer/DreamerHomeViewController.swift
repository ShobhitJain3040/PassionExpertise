//
//  DreamerDashboardViewController.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

class DreamerHomeViewController: BaseViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var AllList = ["Cooking", "Knitting", "Quilting", "Hunting", "Bird-watching", "Hiking", "letterboxing", "geocaching", "Antiques", "Decor", "Postcards", "Genealogy", "Scrapbooking", "embroidery", "cross-stitch", "Jewelry making", "Drawing", "painting", "photography", "Pottery", "Dinner or Movie club", "Ballroom dancing", "Volunteering", "Card games", "Horseback riding", "Yoga", "volleyball", "bowling", "soccer", "Jogging", "Jogging", "Foreign language study", "Reading", "Writing", "blogging", "Music", "musical instruments", "theater", "Radio Jocky", "Acting", "Modaling", "Youtuber"]
  
  
  var searchList = [""]
  
  override func viewDidLoad() {
        super.viewDidLoad()
      self.searchList = self.AllList
    self.tableView.reloadData()
    }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.searchList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
    cell.textLabel?.text = self.searchList[indexPath.row]
    return cell
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "DreamarHomeDetailViewController", sender: nil)
  }
  
  // call when "Done" key pressed
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    self.searchList = self.AllList
    self.tableView.reloadData()
  }
  
  //MARK:searchBar Delegate
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      //locally handle search location
      if searchText == "" {
      self.searchList = self.AllList
        
      } else {
        ///Filtered Array
        let array =  self.AllList.filter { (object) -> Bool in
          return nil != (object as? String)?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil)
        }
        self.searchList = array
      }
     self.tableView.reloadData()
  }
  
}
