//
//  ConsultentData.swift
//  PassionExperties
//
//  Created by shalu tyagi on 12/01/19.
//  Copyright © 2019 shalu tyagi. All rights reserved.
//

import Foundation
import UIKit

class ConsultentData: NSObject {
  var id: String?
  var name: String?
  var imageUrl: String?
  var category: String?
  var rating: String?
  var fee: String?
  var experience: String?
  var experties: String?
  
   init(dic: Dictionary<String, Any>) {
    self.id =  dic["id"] as? String
    self.name =  dic["name"] as? String
    self.imageUrl =  dic["imageUrl"] as? String
    self.category =  dic["category"] as? String
    self.rating =  dic["rating"] as? String
    self.fee =  dic["fee"] as? String
    self.experience =  dic["experience"] as? String
    self.experties =  dic["experties"] as? String
  }
}
