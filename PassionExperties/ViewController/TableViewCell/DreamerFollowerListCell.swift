//
//  DreamerFollowerListCell.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import UIKit

class DreamerFollowerListCell: UITableViewCell {

  @IBOutlet weak var profilePic: UIImageView!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var experties: UILabel!
  @IBOutlet weak var experience: UILabel!
  @IBOutlet weak var fee: UILabel!
  @IBOutlet weak var ratingView: UIView!
  @IBOutlet weak var cardView: UIView!
  
  override func awakeFromNib() {
    self.profilePic.layer.cornerRadius = 30
    self.addShadowInCardView(self.cardView)
  }
 
  //add shadow
   func addShadowInCardView(_ view: UIView?, shadowColor: UIColor? = nil) {
    if let view = view {
      //add shadow on cell
      view.layer.cornerRadius = 3.0
      view.layer.shadowColor = shadowColor?.cgColor ?? UIColor.lightGray.cgColor
      view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
      view.layer.shadowRadius = 1.0
      view.layer.shadowOpacity = 0.5
      view.layer.masksToBounds = false
    }
  }
}
